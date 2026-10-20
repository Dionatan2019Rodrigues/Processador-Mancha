
# Trabalho 2 — Sistemas Operacionais 

Sistema operacional multiprogramado e preemptivo desenvolvido sobre a arquitetura **Mancha**, para a disciplina de Sistemas Operacionais.

O projeto contempla os requisitos das **Partes I, II e III**, incluindo gerenciamento de processos, chamadas de sistema, escalonamento, sincronização, tratamento de entrada e saída e coleta de métricas.

---

## Sumário

- [01. Visão geral e arquitetura](#01-visão-geral-e-arquitetura)
- [02. Estrutura dos processos](#02-estrutura-dos-processos)
- [03. Chamadas de sistema](#03-chamadas-de-sistema)
- [04. Políticas de escalonamento](#04-políticas-de-escalonamento)
- [05. Bloqueio e tratamento de pendências](#05-bloqueio-e-tratamento-de-pendências)
- [06. Métricas do sistema](#06-métricas-do-sistema)
- [07. Compilação e execução](#07-compilação-e-execução)
- [08. Organização dos arquivos](#08-organização-dos-arquivos)

---

# 01. Visão geral e arquitetura

## Como o sistema está organizado

O sistema é dividido em quatro camadas principais. Cada uma possui uma responsabilidade específica e trabalha em conjunto com as demais para garantir a execução multiprogramada dos processos.

```text
┌──────────────────────────────────────────────────────────────┐
│                    PROGRAMAS DE USUÁRIO                      │
│                         programas.c                          │
│                                                              │
│         Init (PID 1) · Tarefa A · Tarefa B · E/S             │
│                                                              │
│                Modo usuário: S=0, I=0, D=0                   │
└────────────────────────────┬─────────────────────────────────┘
                             │
                       trap 7 — Syscalls
                             │
┌────────────────────────────▼─────────────────────────────────┐
│                    PONTE ASSEMBLY                             │
│                         ponte.asm                            │
│                                                              │
│       syscall_trampolim · escalonador_trampolim              │
│                     laço ocioso                              │
│                                                              │
│                Modo supervisor: S=1, I=1                     │
└────────────────────────────┬─────────────────────────────────┘
                             │
┌────────────────────────────▼─────────────────────────────────┐
│                       NÚCLEO DO SO                            │
│                           so.c                               │
│                                                              │
│        Processos · Escalonadores · Filas · Métricas          │
└────────────────────────────┬─────────────────────────────────┘
                             │
┌────────────────────────────▼─────────────────────────────────┐
│                     BIOS E HARDWARE                           │
│                         bios.asm                             │
│                                                              │
│          Interrupções · Console · Relógio                    │
└──────────────────────────────────────────────────────────────┘
```

### Isolamento de privilégios

O sistema mantém uma separação entre os programas de usuário e as operações privilegiadas.

| Modo | Características |
|---|---|
| Usuário (`SR.S=0`, `SR.I=0`) | Processos executam suas tarefas sem acesso direto às operações privilegiadas. |
| Supervisor (`SR.S=1`, `SR.I=1`) | O sistema operacional realiza as operações internas que exigem privilégios. |

No modo usuário, os processos não podem executar diretamente:

- Instruções privilegiadas: `halt`, `ei`, `di` e `rete`.
- Instruções de entrada e saída: `in`, `out`, `inb` e `outb`.

Toda operação de console, criação de processos ou sincronização deve passar pelas **chamadas de sistema**.

---

# 02. Estrutura dos processos

## Bloco de Controle de Processo (PCB)

Cada processo é representado pela estrutura `struct Processo`, definida em `so.h`.

Ela armazena as informações necessárias para identificar o processo, controlar seu estado, salvar seu contexto e acompanhar seu desempenho.

```c
struct Processo {
    int pid;                 // Identificador único (1, 2, 3...)
    int estado;              // LIVRE, PRONTO, EXECUTANDO,
                             // BLOQUEADO ou MORTO
    int bloqueado_por;       // BLOQ_CONSOLE_LE ou BLOQ_ESPERA_PROC
    int esperando_pid;       // PID aguardado por SO_ESPERA_PROC
    int prioridade;          // Prioridade dinâmica (0 a 1000)
    int quadro[16];          // Cópia dos 16 registradores da CPU
    ...                      // Contadores e métricas de desempenho
};
```

### Estados possíveis

| Estado | Significado |
|---|---|
| `LIVRE` | Entrada disponível para utilização. |
| `PRONTO` | Processo apto a executar, aguardando a CPU. |
| `EXECUTANDO` | Processo que está utilizando a CPU. |
| `BLOQUEADO` | Processo aguardando um evento ou a conclusão de outro processo. |
| `MORTO` | Processo que já foi encerrado. |

## Salvamento e restauração do contexto

Quando ocorre uma interrupção ou uma chamada de sistema (`trap`), a CPU Mancha empilha os 16 registradores. O sistema operacional utiliza esse quadro para preservar o estado de cada processo e permitir que sua execução seja retomada posteriormente.

| Posições | Registradores armazenados |
|---|---|
| `quadro[0..4]` | `r0` a `r4` — registradores de uso geral |
| `quadro[5]` | `bp` — base pointer |
| `quadro[6]` | `sp` — stack pointer da pilha do processo |
| `quadro[7]` | `ip` — instruction pointer, ponto de retomada |
| `quadro[8]` | `s0 (sr)` — registrador de estado e flags S/I/D |
| `quadro[9..15]` | Registradores de supervisor (`s1..s7`, `cs`, `ds` etc.) |

### Pilhas independentes

Cada processo possui uma pilha de execução própria, com **128 palavras**, armazenada em `pilhas_processos[slot]`.

Essa separação impede que as variáveis locais e as chamadas de funções de processos diferentes compartilhem a mesma pilha.

As pilhas dos processos também permanecem separadas das pilhas utilizadas pelo núcleo (`pilha_nucleo`) e pelo sistema (`pilha_sistema`).

---

# 03. Chamadas de sistema

Os processos utilizam cinco chamadas de sistema padronizadas, acessadas por meio de `trap 7`.

O número da operação é passado em `r0`, enquanto os argumentos são enviados por `r1` e `r2`, conforme a chamada.

## Interface de chamadas

| Nº | Chamada | Argumentos | Retorno |
|---:|---|---|---|
| 1 | `SO_LE` | Nenhum | Caractere lido em `r0` |
| 2 | `SO_ESCREVE` | `r1 = caractere` | `0` |
| 3 | `SO_CRIA_PROC` | `r1 = func` | PID criado ou `-1` |
| 4 | `SO_MATA_PROC` | `r1 = pid` | `0` ou `-1` |
| 5 | `SO_ESPERA_PROC` | `r1 = pid` | `0` ou `-1` |

## O que cada chamada faz

### `SO_LE` — Leitura do console

Lê um caractere do console.

Se não houver caracteres disponíveis no buffer, o processo é bloqueado até que uma entrada esteja disponível.

### `SO_ESCREVE` — Escrita no console

Escreve um caractere no console por meio do sistema operacional, em modo supervisor.

### `SO_CRIA_PROC` — Criação de processos

Cria um novo processo com ponto de entrada na função indicada por `r1` e aloca uma nova entrada na tabela de processos.

Retorna o PID do processo criado ou `-1` em caso de falha.

### `SO_MATA_PROC` — Encerramento de processos

Encerra o processo especificado por `r1`. O valor `0` representa o próprio processo.

Quando um processo termina, aqueles que estavam aguardando sua conclusão são desbloqueados.

Se o processo encerrado for o `init` (PID 1), o sistema apresenta o relatório de métricas e encerra a máquina por meio de `halt`.

### `SO_ESPERA_PROC` — Espera pela conclusão de um processo

Bloqueia o processo chamador até que o processo identificado pelo PID indicado termine.

Retorna `-1` caso o processo tente esperar por si mesmo ou indique um processo inexistente.

---

# 04. Políticas de escalonamento

O sistema implementa três políticas de escalonamento, selecionáveis por meio de macros de compilação definidas em `so.h`.

## Comparação das políticas

| Política | Tipo | Preempção | Característica principal |
|---|---|---|---|
| `ESC_SIMPLES` | Cooperativo | Não | O processo mantém a CPU até terminar voluntariamente ou bloquear. |
| `ESC_CIRCULAR` | Round-Robin | Sim | Os processos prontos recebem a CPU em ordem circular. |
| `ESC_PRIORIDADE` | Prioridade dinâmica | Sim | A escolha considera a prioridade calculada de cada processo. |

## 4.1 — `ESC_SIMPLES`

**Escalonamento cooperativo — Parte I**

O processo atual continua executando até que termine voluntariamente, por meio de `so_mata_proc`, ou seja bloqueado por uma chamada como `so_le` ou `so_espera_proc`.

O relógio continua contando os tiques, mas não provoca preempção.

## 4.2 — `ESC_CIRCULAR`

**Round-Robin preemptivo — Parte III**

Os processos prontos são organizados em uma fila circular FIFO chamada `fila_prontos`.

O funcionamento segue estas regras:

1. O relógio gera um tique a cada `TICKS_POR_CLOCK`, correspondente a **1.000 instruções**.
2. A cada tique, o sistema decrementa o `quantum_restante`.
3. Quando o quantum chega a zero, ocorre a preempção.
4. O contexto do processo atual é salvo.
5. O processo retorna ao final da fila de prontos.
6. O próximo processo é selecionado para utilizar a CPU.

## 4.3 — `ESC_PRIORIDADE`

**Prioridade dinâmica preemptiva — Parte III**

Cada processo recém-criado recebe prioridade inicial de `0.5`, representada internamente por `500` em ponto fixo.

Sempre que um processo perde a CPU por estouro de quantum ou por bloqueio, sua prioridade é recalculada:

\[
\text{prio} =
\frac{\text{prio} + \frac{t_{\text{exec}}}{t_{\text{quantum}}}}{2}
\]

### Critério de prioridade

**Quanto menor o valor numérico, maior a prioridade.**

Isso favorece processos limitados por entrada e saída (I/O-bound), que costumam bloquear rapidamente e utilizar apenas uma parte do quantum.

### Desempate circular

Quando dois ou mais processos possuem prioridades iguais, a busca começa no próximo slot após o processo corrente.

Esse mecanismo garante alternância circular entre processos empatados e ajuda a prevenir a inanição (*starvation*).

---

# 05. Bloqueio e tratamento de pendências

Um processo é bloqueado quando não pode continuar sua execução sem aguardar algum evento.

O sistema identifica o motivo do bloqueio e acompanha as condições necessárias para que o processo volte a executar.

## Situações de bloqueio

### 1. Console sem entrada disponível

Quando um processo executa `SO_LE` e não existe caractere disponível, ele passa para o estado `PROC_BLOQUEADO`, com o motivo `BLOQ_CONSOLE_LE`.

### 2. Espera por outro processo

Quando um processo executa `SO_ESPERA_PROC`, ele passa para `PROC_BLOQUEADO`, com o motivo `BLOQ_ESPERA_PROC`.

O PID do processo aguardado fica armazenado para que o sistema identifique quando a espera poderá terminar.

### 3. Tratamento de pendências

A rotina `so_trata_pendencias` verifica, a cada tique do relógio ou durante o laço ocioso, se chegaram novos caracteres pela porta do console.

Quando existe uma entrada disponível:

1. O caractere é armazenado em `quadro[0]` do processo que aguarda.
2. O processo é promovido ao estado `PROC_PRONTO`.
3. O escalonador poderá selecioná-lo para continuar a execução.

O encerramento de um processo também permite desbloquear aqueles que aguardavam sua conclusão.

### 4. Laço ocioso

Quando todos os processos estão bloqueados, o sistema utiliza a rotina `_so_idle_loop`.

Ela troca para a pilha do núcleo (`pilha_nucleo`), habilita as interrupções externas por meio de `ei` e incrementa o contador `tempo_ocioso` até que algum evento permita acordar um processo.

---

# 06. Métricas do sistema

Quando o processo `init` termina, o sistema apresenta um relatório consolidado de execução.

## Indicadores gerais

- **Tempo total de execução:** duração contabilizada em tiques de relógio.
- **Tempo ocioso:** tempo em que o sistema permaneceu sem processos aptos a executar.
- **Total de processos criados:** quantidade de processos criados durante a execução.
- **Total de preempções globais:** número total de preempções ocorridas no sistema.

## Contagem de interrupções

O relatório contabiliza interrupções por tipo:

| Tipo | Identificação |
|---|---|
| Boot | `0` |
| Chamadas de sistema | `7` |
| Console | `8` |
| Relógio | `10` |

## Estatísticas individuais dos processos

A tabela detalhada apresenta, para cada processo:

- PID — identificador do processo.
- Tempo de retorno — diferença entre o término e a criação do processo.
- Número de preempções sofridas.
- Quantidade de vezes e tempo total em cada estado:
  - Pronto.
  - Bloqueado.
  - Executando.
- Tempo médio de resposta — intervalo entre o desbloqueio e o próximo escalonamento.

Essas informações permitem observar o comportamento do sistema e comparar os resultados das diferentes políticas de escalonamento.

---

# 07. Compilação e execução

## Pré-requisitos

O projeto depende das ferramentas da plataforma Mancha fornecidas pelo professor no diretório `Processador-Mancha/`.

| Ferramenta | Caminho esperado |
|---|---|
| Compilador C (`mcc`) | `Processador-Mancha/compilador_c/bin/mcc` |
| Montador (`montador`) | `Processador-Mancha/simulador_completo/bin/montador` |
| Simulador interativo (`simulador`) | `Processador-Mancha/simulador_completo/bin/simulador` |

> **Importante:** a pasta `Processador-Mancha/` é  a pasta raiz do repositório`.

## Preparação do ambiente

Caso as ferramentas ainda não estejam compiladas, execute os comandos a seguir a partir da raiz do repositório:

```bash
cd Processador-Mancha/compilador_c && make
cd ../simulador_completo && make
cd ../../T2
```

## Comandos disponíveis

Os comandos abaixo devem ser executados dentro da pasta `T2/`.

| Comando | Finalidade |
|---|---|
| `make` | Compila o sistema operacional e o executor batch. |
| `make run` | Executa o sistema no simulador visual com interface interativa ncurses. |
| `make batch` | Executa o sistema em modo automatizado, exibindo a saída diretamente no terminal. |
| `make report` | Executa a bateria de testes comparativa das configurações de escalonamento. |
| `make clean` | Remove binários e arquivos intermediários. |

### Compilar o projeto

```bash
make
```

### Executar no simulador visual

```bash
make run
```

### Executar em modo batch

```bash
make batch
```

### Gerar o relatório comparativo

```bash
make report
```

### Limpar os arquivos gerados

```bash
make clean
```

## Configuração manual do escalonador

As políticas de escalonamento podem ser selecionadas por meio das macros do arquivo `so.h`.

Exemplo de configuração:

```c
#define CONFIG_ESCALONADOR ESC_CIRCULAR
#define CONFIG_QUANTUM     4
```

Valores possíveis para `CONFIG_ESCALONADOR`:

- `ESC_SIMPLES`
- `ESC_CIRCULAR`
- `ESC_PRIORIDADE`

O quantum é definido em tiques de relógio. Exemplos de valores: `2`, `4` e `8`.

Após alterar a configuração, recompile o projeto:

```bash
make clean && make
```

---

# 08. Organização dos arquivos

A pasta `T2/` contém os arquivos responsáveis pela implementação do sistema operacional, pela compilação, pelos testes e pela documentação.

```text
T2/
│
├── Makefile
│   └── Automação da compilação, execução e geração de relatórios
│
├── README.md
│   └── Documentação do projeto
│
├── RELATORIO.md
│   └── Comparação das sete configurações de escalonamento
│
├── bios.asm
│   └── Firmware/BIOS fornecido para a arquitetura Mancha
│
├── gera_relatorio.py
│   └── Automação dos testes e benchmarks
│
├── instructions.md
│   └── Especificação oficial do trabalho
│
├── ponte.asm
│   └── Trampolins Assembly entre hardware e núcleo C
│
├── programas.c
│   └── Processos de teste: Init, tarefas computacionais A/B e E/S
│
├── sim_batch_main.c
│   └── Executor nativo em C para testes sem interface ncurses
│
├── so.c
│   └── Implementação do núcleo do sistema operacional
│
└── so.h
    └── Cabeçalhos, constantes, estruturas PCB e métricas
```

---

**Trabalho 2 (T2) — Sistemas Operacionais**

Implementação de um mini sistema operacional multiprogramado e preemptivo sobre a arquitetura Mancha, com gerenciamento de processos, chamadas de sistema, escalonamento, bloqueio, sincronização e análise de desempenho.
