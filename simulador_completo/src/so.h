#ifndef SO_H
#define SO_H

#include <stdint.h>

#include "cpu.h"

#define SO_MAX_PROCESSOS 16

typedef enum {
    PROC_LIVRE = 0,
    PROC_PRONTO,
    PROC_EXECUTANDO,
    PROC_BLOQUEADO,
    PROC_MORTO
} estado_processo_t;

typedef struct {
    uint8_t usado;
    uint16_t pid;
    estado_processo_t estado;

    uint16_t contexto[16];
} processo_t;

typedef struct {
    processo_t processos[SO_MAX_PROCESSOS];

    int processo_atual;

    uint16_t proximo_pid;

    cpu_t *cpu;
} so_t;


/* Inicialização */
void so_inicializa(so_t *so, cpu_t *cpu);


/* Contexto */
void so_atualiza_contexto_atual(so_t *so);
void so_restaura_contexto_atual(so_t *so);


/* Criação */
int so_cria_processo(
    so_t *so,
    const uint16_t contexto[16]
);


/* Morte */
int so_mata_processo(
    so_t *so,
    uint16_t pid
);


/* Escalonamento */
int so_escalona(so_t *so);

int so_primeiro_pronto(
    const so_t *so
);


/* Consultas */
uint16_t so_pid_atual(
    const so_t *so
);

estado_processo_t so_estado_processo(
    const so_t *so,
    int indice
);


/* Informações */
void so_imprime_resumo(
    const so_t *so
);

const char *so_estado_nome(
    estado_processo_t estado
);

#endif