# Relatório de Avaliação do SO Mancha (T2)

Este relatório documenta os testes de execução do mini-SO Mancha em diferentes configurações de escalonamento e tamanhos de quantum, conforme solicitado na Parte III do trabalho.

## Resumo Comparativo das Configurações

| Configuração | Escalonador | Quantum | Tempo Total (tiques) | Preempções | Syscalls |
|---|---|---|---|---|---|
| Escalonador Simples (Cooperativo) | `ESC_SIMPLES` | 4 | 378 | 0 | 865 |
| Round-Robin Circular (Quantum = 2) | `ESC_CIRCULAR` | 2 | 1111 | 553 | 865 |
| Round-Robin Circular (Quantum = 4) | `ESC_CIRCULAR` | 4 | 563 | 139 | 865 |
| Round-Robin Circular (Quantum = 8) | `ESC_CIRCULAR` | 8 | 454 | 54 | 865 |
| Prioridade Dinamica (Quantum = 2) | `ESC_PRIORIDADE` | 2 | 7138 | 3567 | 865 |
| Prioridade Dinamica (Quantum = 4) | `ESC_PRIORIDADE` | 4 | 780 | 192 | 865 |
| Prioridade Dinamica (Quantum = 8) | `ESC_PRIORIDADE` | 8 | 505 | 60 | 865 |

---

## Detalhamento das Execuções

### Escalonador Simples (Cooperativo)

```
======================================
  RELATORIO DE EXECUCAO DO SO
========================================
Escalonador: SIMPLES (Cooperativo)
Quantum: 4 tiques (4000 inst)
----------------------------------------
METRICAS GERAIS DO SISTEMA:
  Total proc criados: 4
  Tempo total exec:   378 tiques de relogio
  Tempo ocioso:       0 tiques de relogio
  Total preempcoes:   0
----------------------------------------
INTERRUPCOES RECEBIDAS:
  [0]  Boot:         1
  [7]  Syscalls:     865
  [8]  Console:      0
  [10] Relogio:      378
----------------------------------------
METRICAS POR PROCESSO:
PID | Retorno | Preemp | Pronto(v/t) | Bloq(v/t) | Exec(v/t) | Resp.Med
----+---------+--------+-------------+-----------+-----------+---------
  1 |     378 |      0 |    4/      0 |   3/    239 |   4/    139 |       0
  2 |     195 |      0 |    1/     41 |   0/      0 |   1/    154 |       0
  3 |     267 |      0 |    1/    195 |   0/      0 |   1/     72 |       0
  4 |     281 |      0 |    1/    268 |   0/      0 |   1/     13 |       0
========================================
```

### Round-Robin Circular (Quantum = 2)

```
======================================
  RELATORIO DE EXECUCAO DO SO
========================================
Escalonador: CIRCULAR (Round-Robin)
Quantum: 2 tiques (2000 inst)
----------------------------------------
METRICAS GERAIS DO SISTEMA:
  Total proc criados: 4
  Tempo total exec:   1111 tiques de relogio
  Tempo ocioso:       0 tiques de relogio
  Total preempcoes:   553
----------------------------------------
INTERRUPCOES RECEBIDAS:
  [0]  Boot:         1
  [7]  Syscalls:     865
  [8]  Console:      0
  [10] Relogio:      1111
----------------------------------------
METRICAS POR PROCESSO:
PID | Retorno | Preemp | Pronto(v/t) | Bloq(v/t) | Exec(v/t) | Resp.Med
----+---------+--------+-------------+-----------+-----------+---------
  1 |    1111 |    190 |  192/    213 |   1/    516 | 192/    382 |       0
  2 |     837 |    238 |  239/    360 |   0/      0 | 239/    477 |       0
  3 |     544 |    109 |  110/    325 |   0/      0 | 110/    219 |       0
  4 |     134 |     16 |   17/    101 |   0/      0 |  17/     33 |       0
========================================
```

### Round-Robin Circular (Quantum = 4)

```
======================================
  RELATORIO DE EXECUCAO DO SO
========================================
Escalonador: CIRCULAR (Round-Robin)
Quantum: 4 tiques (4000 inst)
----------------------------------------
METRICAS GERAIS DO SISTEMA:
  Total proc criados: 4
  Tempo total exec:   563 tiques de relogio
  Tempo ocioso:       0 tiques de relogio
  Total preempcoes:   139
----------------------------------------
INTERRUPCOES RECEBIDAS:
  [0]  Boot:         1
  [7]  Syscalls:     865
  [8]  Console:      0
  [10] Relogio:      563
----------------------------------------
METRICAS POR PROCESSO:
PID | Retorno | Preemp | Pronto(v/t) | Bloq(v/t) | Exec(v/t) | Resp.Med
----+---------+--------+-------------+-----------+-----------+---------
  1 |     563 |     50 |   52/    113 |   1/    248 |  52/    202 |       0
  2 |     417 |     59 |   60/    180 |   0/      0 |  60/    237 |       0
  3 |     270 |     26 |   27/    163 |   0/      0 |  27/    107 |       0
  4 |      75 |      4 |    5/     58 |   0/      0 |   5/     17 |       0
========================================
```

### Round-Robin Circular (Quantum = 8)

```
======================================
  RELATORIO DE EXECUCAO DO SO
========================================
Escalonador: CIRCULAR (Round-Robin)
Quantum: 8 tiques (8000 inst)
----------------------------------------
METRICAS GERAIS DO SISTEMA:
  Total proc criados: 4
  Tempo total exec:   454 tiques de relogio
  Tempo ocioso:       0 tiques de relogio
  Total preempcoes:   54
----------------------------------------
INTERRUPCOES RECEBIDAS:
  [0]  Boot:         1
  [7]  Syscalls:     865
  [8]  Console:      0
  [10] Relogio:      454
----------------------------------------
METRICAS POR PROCESSO:
PID | Retorno | Preemp | Pronto(v/t) | Bloq(v/t) | Exec(v/t) | Resp.Med
----+---------+--------+-------------+-----------+-----------+---------
  1 |     454 |     20 |   22/     94 |   1/    194 |  22/    166 |       0
  2 |     336 |     23 |   24/    148 |   0/      0 |  24/    188 |       0
  3 |     220 |     10 |   11/    134 |   0/      0 |  11/     86 |       0
  4 |      59 |      1 |    2/     45 |   0/      0 |   2/     14 |       0
========================================
```

### Prioridade Dinamica (Quantum = 2)

```
======================================
  RELATORIO DE EXECUCAO DO SO
========================================
Escalonador: PRIORIDADE DINAMICA
Quantum: 2 tiques (2000 inst)
----------------------------------------
METRICAS GERAIS DO SISTEMA:
  Total proc criados: 4
  Tempo total exec:   7138 tiques de relogio
  Tempo ocioso:       0 tiques de relogio
  Total preempcoes:   3567
----------------------------------------
INTERRUPCOES RECEBIDAS:
  [0]  Boot:         1
  [7]  Syscalls:     865
  [8]  Console:      0
  [10] Relogio:      7138
----------------------------------------
METRICAS POR PROCESSO:
PID | Retorno | Preemp | Pronto(v/t) | Bloq(v/t) | Exec(v/t) | Resp.Med
----+---------+--------+-------------+-----------+-----------+---------
  1 |    7138 |   2501 | 2502/   2135 |   0/      0 | 2502/   5003 |       0
  4 |     519 |     95 |   96/    328 |   0/      0 |  96/    191 |       0
  3 |    3131 |    595 |  596/   1940 |   0/      0 | 596/   1191 |       0
========================================
```

### Prioridade Dinamica (Quantum = 4)

```
======================================
  RELATORIO DE EXECUCAO DO SO
========================================
Escalonador: PRIORIDADE DINAMICA
Quantum: 4 tiques (4000 inst)
----------------------------------------
METRICAS GERAIS DO SISTEMA:
  Total proc criados: 4
  Tempo total exec:   780 tiques de relogio
  Tempo ocioso:       0 tiques de relogio
  Total preempcoes:   192
----------------------------------------
INTERRUPCOES RECEBIDAS:
  [0]  Boot:         1
  [7]  Syscalls:     865
  [8]  Console:      0
  [10] Relogio:      780
----------------------------------------
METRICAS POR PROCESSO:
PID | Retorno | Preemp | Pronto(v/t) | Bloq(v/t) | Exec(v/t) | Resp.Med
----+---------+--------+-------------+-----------+-----------+---------
  1 |     780 |     67 |   69/    207 |   1/    300 |  69/    273 |       0
  2 |     587 |     82 |   83/    257 |   0/      0 |  83/    330 |       0
  3 |     350 |     38 |   39/    196 |   0/      0 |  39/    154 |       0
  4 |      25 |      5 |    6/      2 |   0/      0 |   6/     23 |       0
========================================
```

### Prioridade Dinamica (Quantum = 8)

```
======================================
  RELATORIO DE EXECUCAO DO SO
========================================
Escalonador: PRIORIDADE DINAMICA
Quantum: 8 tiques (8000 inst)
----------------------------------------
METRICAS GERAIS DO SISTEMA:
  Total proc criados: 4
  Tempo total exec:   505 tiques de relogio
  Tempo ocioso:       0 tiques de relogio
  Total preempcoes:   60
----------------------------------------
INTERRUPCOES RECEBIDAS:
  [0]  Boot:         1
  [7]  Syscalls:     865
  [8]  Console:      0
  [10] Relogio:      505
----------------------------------------
METRICAS POR PROCESSO:
PID | Retorno | Preemp | Pronto(v/t) | Bloq(v/t) | Exec(v/t) | Resp.Med
----+---------+--------+-------------+-----------+-----------+---------
  1 |     505 |     22 |   24/    191 |   1/    130 |  24/    184 |       0
  2 |     375 |     26 |   27/    164 |   0/      0 |  27/    211 |       0
  3 |     187 |     11 |   12/     92 |   0/      0 |  12/     95 |       0
  4 |      21 |      1 |    2/      6 |   0/      0 |   2/     15 |       0
========================================
```

## Análise dos Resultados

1. **Escalonador Simples (Cooperativo):**
   - Não realiza preempções (`Total preempcoes: 0`).
   - Os processos executam até o término ou bloqueio (`SO_LE`, `SO_ESPERA_PROC`).
   - Menor overhead de troca de contexto, porém sem justiça entre processos com alta demanda de CPU.

2. **Escalonador Circular (Round-Robin):**
   - Garante compartilhamento de CPU por quantum temporal.
   - À medida que o quantum aumenta (2 → 4 → 8), o número de preempções diminui consideravelmente, reduzindo a concorrência mas diminuindo a sobrecarga das trocas.
   - O quantum de 4 tiques (4000 instruções) oferece um equilíbrio ideal de responsividade.

3. **Escalonador por Prioridade Dinâmica:**
   - Calcula continuamente a prioridade `prio = (prio + t_exec/quantum)/2`.
   - Processos I/O-bound (como o PID 4) bloqueiam rapidamente antes de usar todo o quantum, obtendo uma prioridade numérica menor (mais alta na escala).
   - O tempo de retorno e tempo em estado pronto para tarefas interativas/I/O é substancialmente menor do que no Round-Robin uniforme.
