#include "so.h"

#include <stdio.h>
#include <string.h>


/* =========================================================
 * Funções internas
 * ========================================================= */

static int encontra_slot_livre(const so_t *so)
{
    int i;

    for (i = 0; i < SO_MAX_PROCESSOS; i++) {
        if (!so->processos[i].usado) {
            return i;
        }
    }

    return -1;
}


static uint16_t gera_pid(so_t *so)
{
    uint16_t pid;

    pid = so->proximo_pid;

    if (pid == 0) {
        pid = 1;
    }

    so->proximo_pid = pid + 1;

    if (so->proximo_pid == 0) {
        so->proximo_pid = 1;
    }

    return pid;
}


/* =========================================================
 * Inicialização
 * ========================================================= */

void so_inicializa(so_t *so, cpu_t *cpu)
{
    int i;

    if (so == NULL) {
        return;
    }

    memset(so, 0, sizeof(*so));

    so->cpu = cpu;
    so->processo_atual = -1;
    so->proximo_pid = 1;

    for (i = 0; i < SO_MAX_PROCESSOS; i++) {
        so->processos[i].usado = 0;
        so->processos[i].pid = 0;
        so->processos[i].estado = PROC_LIVRE;

        memset(
            so->processos[i].contexto,
            0,
            sizeof(so->processos[i].contexto)
        );
    }

    /*
     * Processo inicial.
     */
    so->processos[0].usado = 1;
    so->processos[0].pid = gera_pid(so);
    so->processos[0].estado = PROC_EXECUTANDO;

    so->processo_atual = 0;

    so_atualiza_contexto_atual(so);
}


/* =========================================================
 * Contexto
 * ========================================================= */

void so_atualiza_contexto_atual(so_t *so)
{
    if (so == NULL || so->cpu == NULL) {
        return;
    }

    if (so->processo_atual < 0 ||
        so->processo_atual >= SO_MAX_PROCESSOS) {
        return;
    }

    if (!so->processos[so->processo_atual].usado) {
        return;
    }

    cpu_obtem_contexto(
        so->cpu,
        so->processos[so->processo_atual].contexto
    );
}


void so_restaura_contexto_atual(so_t *so)
{
    if (so == NULL || so->cpu == NULL) {
        return;
    }

    if (so->processo_atual < 0 ||
        so->processo_atual >= SO_MAX_PROCESSOS) {
        return;
    }

    if (!so->processos[so->processo_atual].usado) {
        return;
    }

    cpu_define_contexto(
        so->cpu,
        so->processos[so->processo_atual].contexto
    );
}


/* =========================================================
 * Criação de processo
 * ========================================================= */

int so_cria_processo(
    so_t *so,
    const uint16_t contexto[16])
{
    int slot;
    uint16_t pid;

    if (so == NULL || contexto == NULL) {
        return -1;
    }

    slot = encontra_slot_livre(so);

    if (slot < 0) {
        return -1;
    }

    pid = gera_pid(so);

    so->processos[slot].usado = 1;
    so->processos[slot].pid = pid;
    so->processos[slot].estado = PROC_PRONTO;

    memcpy(
        so->processos[slot].contexto,
        contexto,
        sizeof(so->processos[slot].contexto)
    );

    return (int)pid;
}


/* =========================================================
 * Morte de processo
 * ========================================================= */

int so_mata_processo(
    so_t *so,
    uint16_t pid)
{
    int i;

    if (so == NULL || pid == 0) {
        return -1;
    }

    for (i = 0; i < SO_MAX_PROCESSOS; i++) {

        if (!so->processos[i].usado) {
            continue;
        }

        if (so->processos[i].pid != pid) {
            continue;
        }

        /*
         * O processo encontrado morreu.
         */
        so->processos[i].estado = PROC_MORTO;

        /*
         * Se era o processo atual, não existe mais
         * processo executando.
         */
        if (so->processo_atual == i) {
            so->processo_atual = -1;
        }

        /*
         * Libera o slot para reutilização.
         *
         * O PID NÃO é reutilizado porque proximo_pid
         * continua avançando.
         */
        so->processos[i].usado = 0;

        so->processos[i].pid = 0;

        memset(
            so->processos[i].contexto,
            0,
            sizeof(so->processos[i].contexto)
        );

        so->processos[i].estado = PROC_LIVRE;

        return 0;
    }

    /*
     * PID não encontrado.
     */
    return -1;
}


/* =========================================================
 * Escalonador básico
 * ========================================================= */

int so_primeiro_pronto(const so_t *so)
{
    int i;

    if (so == NULL) {
        return -1;
    }

    for (i = 0; i < SO_MAX_PROCESSOS; i++) {
        if (so->processos[i].usado &&
            so->processos[i].estado == PROC_PRONTO) {
            return i;
        }
    }

    return -1;
}


int so_escalona(so_t *so)
{
    int novo;

    if (so == NULL) {
        return -1;
    }

    /*
     * Se o processo atual ainda está executando,
     * ele continua.
     */
    if (so->processo_atual >= 0 &&
        so->processo_atual < SO_MAX_PROCESSOS &&
        so->processos[so->processo_atual].usado &&
        so->processos[so->processo_atual].estado == PROC_EXECUTANDO) {

        return so->processo_atual;
    }

    /*
     * Procura o primeiro processo pronto.
     */
    novo = so_primeiro_pronto(so);

    if (novo < 0) {
        so->processo_atual = -1;
        return -1;
    }

    so->processo_atual = novo;

    so->processos[novo].estado = PROC_EXECUTANDO;

    so_restaura_contexto_atual(so);

    return novo;
}


/* =========================================================
 * Consultas
 * ========================================================= */

uint16_t so_pid_atual(const so_t *so)
{
    if (so == NULL) {
        return 0;
    }

    if (so->processo_atual < 0 ||
        so->processo_atual >= SO_MAX_PROCESSOS) {
        return 0;
    }

    if (!so->processos[so->processo_atual].usado) {
        return 0;
    }

    return so->processos[so->processo_atual].pid;
}


estado_processo_t so_estado_processo(
    const so_t *so,
    int indice)
{
    if (so == NULL ||
        indice < 0 ||
        indice >= SO_MAX_PROCESSOS) {
        return PROC_LIVRE;
    }

    return so->processos[indice].estado;
}


/* =========================================================
 * Nome dos estados
 * ========================================================= */

const char *so_estado_nome(
    estado_processo_t estado)
{
    switch (estado) {

        case PROC_LIVRE:
            return "LIVRE";

        case PROC_PRONTO:
            return "PRONTO";

        case PROC_EXECUTANDO:
            return "EXECUTANDO";

        case PROC_BLOQUEADO:
            return "BLOQUEADO";

        case PROC_MORTO:
            return "MORTO";

        default:
            return "DESCONHECIDO";
    }
}


/* =========================================================
 * Resumo
 * ========================================================= */

void so_imprime_resumo(const so_t *so)
{
    int i;
    int quantidade = 0;

    if (so == NULL) {
        return;
    }

    for (i = 0; i < SO_MAX_PROCESSOS; i++) {
        if (so->processos[i].usado) {
            quantidade++;
        }
    }

    printf("\n");
    printf("============================================\n");
    printf("PROCESSOS: %d\n", quantidade);
    printf("============================================\n");

    for (i = 0; i < SO_MAX_PROCESSOS; i++) {

        if (!so->processos[i].usado) {
            continue;
        }

        printf(
            "slot=%d | PID=%u | estado=%s | IP=%04X | SP=%04X\n",
            i,
            so->processos[i].pid,
            so_estado_nome(so->processos[i].estado),
            so->processos[i].contexto[7],
            so->processos[i].contexto[6]
        );
    }

    if (so->processo_atual >= 0) {

        printf(
            "atual: slot=%d | PID=%u\n",
            so->processo_atual,
            so_pid_atual(so)
        );

    } else {

        printf("atual: nenhum processo\n");
    }

    printf("============================================\n");
}