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

    /* Contexto completo:
       0..7  = r0..r7
       8..15 = s0..s7
    */
    uint16_t contexto[16];
} processo_t;

typedef struct {
    processo_t processos[SO_MAX_PROCESSOS];

    /* Índice do processo atualmente executando.
       -1 significa que não existe processo atual. */
    int processo_atual;

    /* Próximo PID disponível. */
    uint16_t proximo_pid;

    cpu_t *cpu;
} so_t;


/* Inicializa o sistema operacional. */
void so_inicializa(so_t *so, cpu_t *cpu);


/* Salva o contexto da CPU no processo atual. */
void so_atualiza_contexto_atual(so_t *so);


/* Restaura o contexto do processo atual para a CPU. */
void so_restaura_contexto_atual(so_t *so);


/* Cria um novo processo usando o contexto informado.
   Retorna o PID criado ou -1 em caso de erro. */
int so_cria_processo(so_t *so, const uint16_t contexto[16]);


/* Executa o escalonador básico.
   Se o processo atual puder continuar, ele continua.
   Caso contrário, escolhe o primeiro processo pronto. */
int so_escalona(so_t *so);


/* Retorna o índice do primeiro processo pronto.
   Retorna -1 se não existir nenhum. */
int so_primeiro_pronto(const so_t *so);


/* Retorna o PID do processo atual.
   Retorna 0 se não houver processo atual. */
uint16_t so_pid_atual(const so_t *so);


/* Retorna o estado de um processo. */
estado_processo_t so_estado_processo(
    const so_t *so,
    int indice
);


/* Imprime uma visão resumida dos processos. */
void so_imprime_resumo(const so_t *so);


/* Converte estado para texto. */
const char *so_estado_nome(estado_processo_t estado);

#endif