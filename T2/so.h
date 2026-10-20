#ifndef SO_H
#define SO_H

// Constantes do Sistema Operacional
#define MAX_PROCESSOS       8
#define TAM_PILHA_PROC      128    // 128 palavras = 256 bytes por processo
#define TICKS_POR_CLOCK     1000   // Instruções por tique de relógio
#define QUANTUM_PADRAO      4      // Quantum = 4 tiques de relógio (4000 instruções)
#define TROCOU_PROCESSO     9999   // Código de retorno interno para troca de contexto

// Tipos de Escalonador
#define ESC_SIMPLES         0      // Parte I: cooperativo/simples
#define ESC_CIRCULAR        1      // Parte III: Round-Robin circular preemptivo
#define ESC_PRIORIDADE      2      // Parte III: Prioridade dinâmica preemptiva

#ifndef CONFIG_ESCALONADOR
#define CONFIG_ESCALONADOR  ESC_CIRCULAR
#endif

#ifndef CONFIG_QUANTUM
#define CONFIG_QUANTUM      QUANTUM_PADRAO
#endif

// Estados do Processo
#define PROC_LIVRE          0
#define PROC_PRONTO         1
#define PROC_EXECUTANDO     2
#define PROC_BLOQUEADO      3
#define PROC_MORTO          4

// Motivos de Bloqueio
#define BLOQ_NENHUM         0
#define BLOQ_CONSOLE_LE     1
#define BLOQ_ESPERA_PROC    2

// Chamadas de Sistema (Syscalls)
#define SO_LE               1
#define SO_ESCREVE          2
#define SO_CRIA_PROC        3
#define SO_MATA_PROC        4
#define SO_ESPERA_PROC      5

// Estrutura de Métricas Globais
struct Metricas {
    int n_processos_criados;
    int tempo_total;
    int tempo_ocioso;
    int n_preempcoes_total;
    int n_interrupcoes[16];
};

// Estrutura do Processo (PCB)
struct Processo {
    int pid;
    int estado;
    int bloqueado_por;
    int esperando_pid;
    int prioridade;                // Ponto fixo: 500 = 0.5
    int quadro[16];                // 16 registradores salvos do hardware

    // Métricas específicas do processo
    int t_criacao;
    int t_termino;
    int n_preempcoes;
    int vezes_pronto;
    int vezes_bloqueado;
    int vezes_executando;
    int tempo_pronto;
    int tempo_bloqueado;
    int tempo_executando;
    int t_ultimo_estado;           // Marca temporal da última mudança de estado
    int t_desbloqueou;             // Momento em que saiu de BLOQUEADO para PRONTO
    int soma_tempo_resposta;       // Acumulador de tempo de resposta
    int n_respostas;               // Número de vezes que foi desbloqueado e escalonado
};

// Declaração de funções do núcleo
void so_inicializa(int *quadro_boot);
void so_trata_pendencias(void);
void so_tique_relogio(int *quadro);
int  so_trata_syscall(int *quadro, int num, int arg1, int arg2);
void so_restaura_atual(int *quadro_destino);
void so_imprime_relatorio(void);

// Funções de ponte assembly
int  so_obtem_relogio_cont(void);
void so_escreve_caractere(int c);
void so_halt(void);

// Biblioteca de chamadas de sistema para programas de usuário
int  so_le(void);
int  so_escreve(int c);
int  so_cria_proc(void (*func)(void));
int  so_mata_proc(int pid);
int  so_espera_proc(int pid);

// Funções de impressão de alto nível
void so_puts(char *s);
void so_nova_linha(void);
void so_print_str(char *s);
void so_print_dec(int v);
void so_print_hex(int v);

#endif
