#include "so.h"

// Tabela de processos e pilhas de trabalho
struct Processo tab_processos[MAX_PROCESSOS];
int pilhas_processos[MAX_PROCESSOS][TAM_PILHA_PROC];

// Fila de processos prontos para o escalonador circular
int fila_prontos[MAX_PROCESSOS];
int fila_inicio;
int fila_fim;
int fila_n;

// Estado global do SO
int processo_atual;
int proximo_pid;
int escalonador_tipo;
int quantum_config;
int quantum_restante;
int tempo_sistema;
struct Metricas metricas;

// Processo de inicialização do usuário (definido em programas.c)
void proc_init(void);

// Declaracao de funcoes internas
void so_muda_estado(int proc_idx, int novo_estado);
int  so_escolhe_proximo(void);
void so_salva_quadro(int proc_idx, int *origem);
void so_restaura_quadro(int proc_idx, int *destino);
int  bios_console_disponivel(void);
int  bios_console_le(void);

// ------------------------------------------------------------- Fila circular

void fila_inicializa(void)
{
    fila_inicio = 0;
    fila_fim = 0;
    fila_n = 0;
}

void fila_insere(int proc_idx)
{
    if (fila_n >= MAX_PROCESSOS) {
        return;
    }
    fila_prontos[fila_fim] = proc_idx;
    fila_fim = fila_fim + 1;
    if (fila_fim >= MAX_PROCESSOS) {
        fila_fim = 0;
    }
    fila_n = fila_n + 1;
}

int fila_retira(void)
{
    int proc_idx;
    if (fila_n == 0) {
        return -1;
    }
    proc_idx = fila_prontos[fila_inicio];
    fila_inicio = fila_inicio + 1;
    if (fila_inicio >= MAX_PROCESSOS) {
        fila_inicio = 0;
    }
    fila_n = fila_n - 1;
    return proc_idx;
}

// -------------------------------------------------------- Gerência de Processos

int so_cria_proc_interno(int entry_point)
{
    int slot;
    int i;
    struct Processo *p;

    slot = -1;
    i = 0;
    while (i < MAX_PROCESSOS) {
        if (tab_processos[i].estado == PROC_LIVRE || tab_processos[i].estado == PROC_MORTO) {
            slot = i;
            break;
        }
        i = i + 1;
    }

    if (slot == -1) {
        return -1; // Tabela cheia
    }

    p = &tab_processos[slot];
    p->pid = proximo_pid;
    proximo_pid = proximo_pid + 1;
    p->bloqueado_por = BLOQ_NENHUM;
    p->esperando_pid = 0;
    p->prioridade = 500; // 0.5 em ponto fixo (* 1000)

    // Inicializa quadro de registradores
    i = 0;
    while (i < 16) {
        p->quadro[i] = 0;
        i = i + 1;
    }

    // sp inicial: topo da pilha do processo
    p->quadro[6] = (int) &pilhas_processos[slot][TAM_PILHA_PROC];
    // ip inicial: ponto de entrada
    p->quadro[7] = entry_point;
    // sr: Modo usuário (S=0), E/S desabilitada (I=0), Interrupções ativas (D=0)
    p->quadro[8] = 0x0000;

    // Métricas do processo
    p->t_criacao = tempo_sistema;
    p->t_termino = 0;
    p->n_preempcoes = 0;
    p->vezes_pronto = 0;
    p->vezes_bloqueado = 0;
    p->vezes_executando = 0;
    p->tempo_pronto = 0;
    p->tempo_bloqueado = 0;
    p->tempo_executando = 0;
    p->t_ultimo_estado = tempo_sistema;
    p->t_desbloqueou = 0;
    p->soma_tempo_resposta = 0;
    p->n_respostas = 0;

    metricas.n_processos_criados = metricas.n_processos_criados + 1;

    // Coloca em estado PRONTO
    so_muda_estado(slot, PROC_PRONTO);

    return p->pid;
}

void so_muda_estado(int proc_idx, int novo_estado)
{
    struct Processo *p;
    int delta;
    int anterior;

    p = &tab_processos[proc_idx];
    anterior = p->estado;

    // Atualiza tempo no estado anterior
    delta = tempo_sistema - p->t_ultimo_estado;
    if (delta > 0) {
        if (anterior == PROC_PRONTO) {
            p->tempo_pronto = p->tempo_pronto + delta;
        } else if (anterior == PROC_EXECUTANDO) {
            p->tempo_executando = p->tempo_executando + delta;
        } else if (anterior == PROC_BLOQUEADO) {
            p->tempo_bloqueado = p->tempo_bloqueado + delta;
        }
    }

    p->estado = novo_estado;
    p->t_ultimo_estado = tempo_sistema;

    if (novo_estado == PROC_PRONTO) {
        p->vezes_pronto = p->vezes_pronto + 1;
        if (anterior == PROC_BLOQUEADO) {
            p->t_desbloqueou = tempo_sistema;
        }
        if (escalonador_tipo == ESC_CIRCULAR) {
            fila_insere(proc_idx);
        }
    } else if (novo_estado == PROC_EXECUTANDO) {
        p->vezes_executando = p->vezes_executando + 1;
        if (p->t_desbloqueou > 0) {
            delta = tempo_sistema - p->t_desbloqueou;
            p->soma_tempo_resposta = p->soma_tempo_resposta + delta;
            p->n_respostas = p->n_respostas + 1;
            p->t_desbloqueou = 0;
        }
    } else if (novo_estado == PROC_BLOQUEADO) {
        p->vezes_bloqueado = p->vezes_bloqueado + 1;
    } else if (novo_estado == PROC_MORTO) {
        p->t_termino = tempo_sistema;
    }
}

// ------------------------------------------------------------- Escalonador

int so_escolhe_proximo(void)
{
    int i;
    int melhor;
    int menor_prio;
    int count;
    int idx;

    if (escalonador_tipo == ESC_SIMPLES) {
        // Se o processo atual continua pronto, continua ele mesmo
        if (processo_atual >= 0) {
            if (tab_processos[processo_atual].estado == PROC_PRONTO) {
                return processo_atual;
            }
        }
        // Senão escolhe o primeiro pronto na tabela
        i = 0;
        while (i < MAX_PROCESSOS) {
            if (tab_processos[i].estado == PROC_PRONTO) {
                return i;
            }
            i = i + 1;
        }
        return -1;
    } else if (escalonador_tipo == ESC_CIRCULAR) {
        while (fila_n > 0) {
            melhor = fila_retira();
            if (melhor >= 0 && tab_processos[melhor].estado == PROC_PRONTO) {
                return melhor;
            }
        }
        return -1;
    } else if (escalonador_tipo == ESC_PRIORIDADE) {
        melhor = -1;
        menor_prio = 32767;
        count = 0;
        idx = processo_atual + 1;
        if (idx >= MAX_PROCESSOS || idx < 0) {
            idx = 0;
        }
        while (count < MAX_PROCESSOS) {
            if (tab_processos[idx].estado == PROC_PRONTO) {
                if (tab_processos[idx].prioridade < menor_prio) {
                    menor_prio = tab_processos[idx].prioridade;
                    melhor = idx;
                }
            }
            idx = idx + 1;
            if (idx >= MAX_PROCESSOS) {
                idx = 0;
            }
            count = count + 1;
        }
        return melhor;
    }
    return -1;
}

// ----------------------------------------------------- Cópia de Contexto

void so_salva_quadro(int proc_idx, int *origem)
{
    int i;
    struct Processo *p;
    p = &tab_processos[proc_idx];
    i = 0;
    while (i < 16) {
        p->quadro[i] = origem[i];
        i = i + 1;
    }
}

void so_restaura_quadro(int proc_idx, int *destino)
{
    int i;
    struct Processo *p;
    p = &tab_processos[proc_idx];
    i = 0;
    while (i < 16) {
        destino[i] = p->quadro[i];
        i = i + 1;
    }
}

void so_restaura_atual(int *quadro_destino)
{
    if (processo_atual >= 0) {
        so_restaura_quadro(processo_atual, quadro_destino);
    }
}

// ------------------------------------------------ Tratamento de Pendências (Parte II)

void so_trata_pendencias(void)
{
    int i;
    int achou;
    int c;

    // Verifica entrada do console
    while (bios_console_disponivel() > 0) {
        achou = -1;
        i = 0;
        while (i < MAX_PROCESSOS) {
            if (tab_processos[i].estado == PROC_BLOQUEADO) {
                if (tab_processos[i].bloqueado_por == BLOQ_CONSOLE_LE) {
                    achou = i;
                    break;
                }
            }
            i = i + 1;
        }

        if (achou != -1) {
            c = bios_console_le();
            tab_processos[achou].quadro[0] = c; // r0 recebe o caractere lido
            tab_processos[achou].bloqueado_por = BLOQ_NENHUM;
            so_muda_estado(achou, PROC_PRONTO);
            if (processo_atual == -1) {
                processo_atual = so_escolhe_proximo();
                if (processo_atual != -1) {
                    so_muda_estado(processo_atual, PROC_EXECUTANDO);
                    quantum_restante = quantum_config;
                }
            }
        } else {
            break; // Nenhum processo esperando console no momento
        }
    }
}

// ------------------------------------------------ Tique do Relógio (Parte III)

void so_tique_relogio(int *quadro)
{
    int atual;
    int prox;
    int t_exec;
    int frac;

    metricas.n_interrupcoes[10] = metricas.n_interrupcoes[10] + 1;
    tempo_sistema = tempo_sistema + 1;
    metricas.tempo_total = metricas.tempo_total + 1;

    so_trata_pendencias();

    // Sistema estava ocioso?
    if (processo_atual == -1) {
        metricas.tempo_ocioso = metricas.tempo_ocioso + 1;
        prox = so_escolhe_proximo();
        if (prox != -1) {
            processo_atual = prox;
            so_muda_estado(processo_atual, PROC_EXECUTANDO);
            quantum_restante = quantum_config;
            so_restaura_quadro(processo_atual, quadro);
        }
        return;
    }

    // Processo executando
    atual = processo_atual;
    quantum_restante = quantum_restante - 1;

    if (escalonador_tipo == ESC_SIMPLES) {
        // Escalonador simples: não preempciona por relógio
        return;
    }

    if (quantum_restante <= 0) {
        // Preempção!
        if (escalonador_tipo == ESC_PRIORIDADE) {
            t_exec = quantum_config - quantum_restante;
            if (t_exec > quantum_config) {
                t_exec = quantum_config;
            }
            frac = (t_exec * 1000) / quantum_config;
            tab_processos[atual].prioridade = (tab_processos[atual].prioridade + frac) / 2;
        }

        so_salva_quadro(atual, quadro);
        tab_processos[atual].n_preempcoes = tab_processos[atual].n_preempcoes + 1;
        metricas.n_preempcoes_total = metricas.n_preempcoes_total + 1;

        so_muda_estado(atual, PROC_PRONTO);

        prox = so_escolhe_proximo();
        if (prox == -1) {
            processo_atual = -1;
        } else {
            processo_atual = prox;
            so_muda_estado(processo_atual, PROC_EXECUTANDO);
            quantum_restante = quantum_config;
            so_restaura_quadro(processo_atual, quadro);
        }
    }
}

// ------------------------------------------------ Despacho de Chamadas de Sistema

int so_trata_syscall(int *quadro, int num, int arg1, int arg2)
{
    int atual;
    int prox;
    int i;
    int alvo;
    int slot;
    int t_exec;
    int frac;
    int c;

    metricas.n_interrupcoes[7] = metricas.n_interrupcoes[7] + 1;
    atual = processo_atual;

    if (num == SO_LE) {
        // Parte II: Não bloqueia se houver caractere disponível
        if (bios_console_disponivel() > 0) {
            c = bios_console_le();
            return c;
        }

        // Bloqueia processo por console
        so_salva_quadro(atual, quadro);
        tab_processos[atual].bloqueado_por = BLOQ_CONSOLE_LE;

        if (escalonador_tipo == ESC_PRIORIDADE) {
            t_exec = quantum_config - quantum_restante;
            if (t_exec < 0) {
                t_exec = 0;
            }
            frac = (t_exec * 1000) / quantum_config;
            tab_processos[atual].prioridade = (tab_processos[atual].prioridade + frac) / 2;
        }

        so_muda_estado(atual, PROC_BLOQUEADO);

        prox = so_escolhe_proximo();
        if (prox == -1) {
            processo_atual = -1;
        } else {
            processo_atual = prox;
            so_muda_estado(processo_atual, PROC_EXECUTANDO);
            quantum_restante = quantum_config;
            so_restaura_quadro(processo_atual, quadro);
        }
        return TROCOU_PROCESSO;
    }

    if (num == SO_ESCREVE) {
        so_escreve_caractere(arg1);
        return 0;
    }

    if (num == SO_CRIA_PROC) {
        return so_cria_proc_interno(arg1);
    }

    if (num == SO_MATA_PROC) {
        alvo = arg1;
        // Mata a si próprio
        if (alvo == 0 || alvo == tab_processos[atual].pid) {
            alvo = tab_processos[atual].pid;
            so_muda_estado(atual, PROC_MORTO);

            // Desbloqueia processos que estavam esperando este terminar
            i = 0;
            while (i < MAX_PROCESSOS) {
                if (tab_processos[i].estado == PROC_BLOQUEADO) {
                    if (tab_processos[i].bloqueado_por == BLOQ_ESPERA_PROC && tab_processos[i].esperando_pid == alvo) {
                        tab_processos[i].bloqueado_por = BLOQ_NENHUM;
                        tab_processos[i].esperando_pid = 0;
                        tab_processos[i].quadro[0] = 0; // retorno 0 de sucesso
                        so_muda_estado(i, PROC_PRONTO);
                    }
                }
                i = i + 1;
            }

            // Se init morreu, imprime relatório e para
            if (alvo == 1) {
                so_imprime_relatorio();
                so_halt();
                return 0;
            }

            // Escala próximo processo
            prox = so_escolhe_proximo();
            if (prox == -1) {
                processo_atual = -1;
            } else {
                processo_atual = prox;
                so_muda_estado(processo_atual, PROC_EXECUTANDO);
                quantum_restante = quantum_config;
                so_restaura_quadro(processo_atual, quadro);
            }
            return TROCOU_PROCESSO;
        }

        // Mata outro processo
        slot = -1;
        i = 0;
        while (i < MAX_PROCESSOS) {
            if (tab_processos[i].pid == alvo && tab_processos[i].estado != PROC_MORTO && tab_processos[i].estado != PROC_LIVRE) {
                slot = i;
                break;
            }
            i = i + 1;
        }

        if (slot == -1) {
            return -1; // Processo não existe
        }

        so_muda_estado(slot, PROC_MORTO);

        // Desbloqueia quem esperava
        i = 0;
        while (i < MAX_PROCESSOS) {
            if (tab_processos[i].estado == PROC_BLOQUEADO) {
                if (tab_processos[i].bloqueado_por == BLOQ_ESPERA_PROC && tab_processos[i].esperando_pid == alvo) {
                    tab_processos[i].bloqueado_por = BLOQ_NENHUM;
                    tab_processos[i].esperando_pid = 0;
                    tab_processos[i].quadro[0] = 0;
                    so_muda_estado(i, PROC_PRONTO);
                }
            }
            i = i + 1;
        }

        return 0;
    }

    if (num == SO_ESPERA_PROC) {
        alvo = arg1;
        if (alvo <= 0 || alvo == tab_processos[atual].pid) {
            return -1; // Inválido ou esperando a si mesmo
        }

        // Procura se o processo existe e está vivo
        slot = -1;
        i = 0;
        while (i < MAX_PROCESSOS) {
            if (tab_processos[i].pid == alvo && tab_processos[i].estado != PROC_MORTO && tab_processos[i].estado != PROC_LIVRE) {
                slot = i;
                break;
            }
            i = i + 1;
        }

        if (slot == -1) {
            return -1; // Processo não existe ou já terminou
        }

        // Bloqueia esperando processo
        so_salva_quadro(atual, quadro);
        tab_processos[atual].bloqueado_por = BLOQ_ESPERA_PROC;
        tab_processos[atual].esperando_pid = alvo;

        if (escalonador_tipo == ESC_PRIORIDADE) {
            t_exec = quantum_config - quantum_restante;
            if (t_exec < 0) {
                t_exec = 0;
            }
            frac = (t_exec * 1000) / quantum_config;
            tab_processos[atual].prioridade = (tab_processos[atual].prioridade + frac) / 2;
        }

        so_muda_estado(atual, PROC_BLOQUEADO);

        prox = so_escolhe_proximo();
        if (prox == -1) {
            processo_atual = -1;
        } else {
            processo_atual = prox;
            so_muda_estado(processo_atual, PROC_EXECUTANDO);
            quantum_restante = quantum_config;
            so_restaura_quadro(processo_atual, quadro);
        }
        return TROCOU_PROCESSO;
    }

    return -1; // Syscall desconhecida
}

// ------------------------------------------------ Inicialização do SO

void so_inicializa(int *quadro_boot)
{
    int i;
    int init_pid;
    int prox;

    fila_inicializa();

    i = 0;
    while (i < MAX_PROCESSOS) {
        tab_processos[i].estado = PROC_LIVRE;
        tab_processos[i].pid = 0;
        i = i + 1;
    }

    i = 0;
    while (i < 16) {
        metricas.n_interrupcoes[i] = 0;
        i = i + 1;
    }

    metricas.n_processos_criados = 0;
    metricas.tempo_total = 0;
    metricas.tempo_ocioso = 0;
    metricas.n_preempcoes_total = 0;
    metricas.n_interrupcoes[0] = 1; // Boot

    proximo_pid = 1;
    tempo_sistema = 0;
    processo_atual = -1;

    // Configuração do escalonador
    escalonador_tipo = CONFIG_ESCALONADOR;
    quantum_config = CONFIG_QUANTUM;
    quantum_restante = quantum_config;

    // Cria o primeiro processo do sistema (init)
    init_pid = so_cria_proc_interno(proc_init);

    // Escala init para iniciar a execução
    prox = so_escolhe_proximo();
    processo_atual = prox;
    so_muda_estado(processo_atual, PROC_EXECUTANDO);

    // Prepara o quadro inicial na pilha do sistema para o primeiro rete
    so_restaura_quadro(processo_atual, quadro_boot);
}

// ------------------------------------------------ Funções de Impressão do Kernel (para relatório)

void k_print_str(char *s)
{
    while (*s != 0) {
        so_escreve_caractere(*s);
        s = s + 1;
    }
}

void k_puts(char *s)
{
    k_print_str(s);
    so_escreve_caractere(10);
}

void k_nova_linha(void)
{
    so_escreve_caractere(10);
}

void k_linha_igual(void)
{
    k_puts("========================================");
}

void k_linha_traco(void)
{
    k_puts("----------------------------------------");
}

void k_print_dec(int v)
{
    char buf[8];
    int i;
    int neg;

    i = 0;
    neg = 0;
    if (v < 0) {
        neg = 1;
        v = -v;
    }
    if (v == 0) {
        buf[0] = '0';
        i = 1;
    }
    while (v > 0) {
        buf[i] = (v % 10) + '0';
        i = i + 1;
        v = v / 10;
    }
    if (neg) {
        so_escreve_caractere('-');
    }
    while (i > 0) {
        i = i - 1;
        so_escreve_caractere(buf[i]);
    }
}

void k_print_campo(int v, int largura)
{
    int temp;
    int digitos;
    int espacos;

    temp = v;
    digitos = 0;
    if (temp <= 0) {
        digitos = 1;
        if (temp < 0) {
            temp = -temp;
            digitos = digitos + 1;
        }
    }
    while (temp > 0) {
        digitos = digitos + 1;
        temp = temp / 10;
    }
    espacos = largura - digitos;
    while (espacos > 0) {
        so_escreve_caractere(' ');
        espacos = espacos - 1;
    }
    k_print_dec(v);
}

void so_imprime_relatorio(void)
{
    int i;
    struct Processo *p;
    int retorno;
    int resp_med;

    k_nova_linha();
    k_linha_igual();
    k_puts("  RELATORIO DE EXECUCAO DO SO");
    k_linha_igual();

    k_print_str("Escalonador: ");
    if (escalonador_tipo == ESC_SIMPLES) {
        k_puts("SIMPLES (Cooperativo)");
    } else if (escalonador_tipo == ESC_CIRCULAR) {
        k_puts("CIRCULAR (Round-Robin)");
    } else if (escalonador_tipo == ESC_PRIORIDADE) {
        k_puts("PRIORIDADE DINAMICA");
    }

    k_print_str("Quantum: ");
    k_print_dec(quantum_config);
    k_print_str(" tiques (");
    k_print_dec(quantum_config * TICKS_POR_CLOCK);
    k_puts(" inst)");

    k_linha_traco();
    k_puts("METRICAS GERAIS DO SISTEMA:");
    k_print_str("  Total proc criados: ");
    k_print_dec(metricas.n_processos_criados);
    k_nova_linha();

    k_print_str("  Tempo total exec:   ");
    k_print_dec(metricas.tempo_total);
    k_puts(" tiques de relogio");

    k_print_str("  Tempo ocioso:       ");
    k_print_dec(metricas.tempo_ocioso);
    k_puts(" tiques de relogio");

    k_print_str("  Total preempcoes:   ");
    k_print_dec(metricas.n_preempcoes_total);
    k_nova_linha();

    k_linha_traco();
    k_puts("INTERRUPCOES RECEBIDAS:");
    k_print_str("  [0]  Boot:         ");
    k_print_dec(metricas.n_interrupcoes[0]);
    k_nova_linha();
    k_print_str("  [7]  Syscalls:     ");
    k_print_dec(metricas.n_interrupcoes[7]);
    k_nova_linha();
    k_print_str("  [8]  Console:      ");
    k_print_dec(metricas.n_interrupcoes[8]);
    k_nova_linha();
    k_print_str("  [10] Relogio:      ");
    k_print_dec(metricas.n_interrupcoes[10]);
    k_nova_linha();

    k_linha_traco();
    k_puts("METRICAS POR PROCESSO:");
    k_print_str("PID | Retorno | Preemp | Pronto(v/t) | ");
    k_puts("Bloq(v/t) | Exec(v/t) | Resp.Med");
    k_print_str("----+---------+--------+-------------+-");
    k_puts("----------+-----------+---------");

    i = 0;
    while (i < MAX_PROCESSOS) {
        p = &tab_processos[i];
        if (p->pid > 0) {
            retorno = p->t_termino - p->t_criacao;
            if (retorno < 0) {
                retorno = tempo_sistema - p->t_criacao;
            }

            resp_med = 0;
            if (p->n_respostas > 0) {
                resp_med = p->soma_tempo_resposta / p->n_respostas;
            }

            so_escreve_caractere(' ');
            k_print_campo(p->pid, 2);
            k_print_str(" | ");

            k_print_campo(retorno, 7);
            k_print_str(" | ");

            k_print_campo(p->n_preempcoes, 6);
            k_print_str(" | ");

            k_print_campo(p->vezes_pronto, 4);
            so_escreve_caractere('/');
            k_print_campo(p->tempo_pronto, 7);
            k_print_str(" | ");

            k_print_campo(p->vezes_bloqueado, 3);
            so_escreve_caractere('/');
            k_print_campo(p->tempo_bloqueado, 7);
            k_print_str(" | ");

            k_print_campo(p->vezes_executando, 3);
            so_escreve_caractere('/');
            k_print_campo(p->tempo_executando, 7);
            k_print_str(" | ");

            k_print_campo(resp_med, 7);
            k_nova_linha();
        }
        i = i + 1;
    }
    k_linha_igual();
}
