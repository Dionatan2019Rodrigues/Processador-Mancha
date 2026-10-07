#include "so.h"

#include <stdio.h>
#include <stdlib.h>
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
 * Criação e destruição
 * ========================================================= */

so_t *so_cria(cpu_t *cpu)
{
    so_t *so;

    so = calloc(1, sizeof(so_t));

    if (so == NULL) {
        return NULL;
    }

    so->cpu = cpu;

    return so;
}


void so_destroi(so_t *so)
{
    free(so);
}


/* =========================================================
 * Inicialização
 * ========================================================= */

void so_inicializa(so_t *so)
{
    int i;

    if (so == NULL) {
        return;
    }

    /*
     * Mantém a CPU associada ao SO.
     */
    cpu_t *cpu = so->cpu;

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

    /*
     * Inicializa a infraestrutura das syscalls.
     */
    so_inicializa_syscalls(so);
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
 * Syscall SO_LE
 * ========================================================= */

static int16_t syscall_so_le(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4)
{
    /*
     * A leitura real da console será implementada
     * posteriormente, junto com bloqueio de processos.
     *
     * Neste momento a infraestrutura já está integrada.
     */

    (void)arg1;
    (void)arg2;
    (void)arg3;
    (void)arg4;

    return -1;
}


/* =========================================================
 * Syscall SO_ESCREVE
 * ========================================================= */

static int16_t syscall_so_escreve(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4)
{
    /*
     * A implementação real da saída será integrada
     * posteriormente.
     *
     * Por enquanto retornamos o primeiro argumento.
     * Isso permite testar a passagem de argumentos
     * através do trap 7.
     */

    (void)arg2;
    (void)arg3;
    (void)arg4;

    return (int16_t)arg1;
}


/* =========================================================
 * Syscall SO_CRIA_PROC
 * ========================================================= */

static int16_t syscall_so_cria_proc(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4)
{
    /*
     * A criação real através da syscall será ligada
     * posteriormente ao contexto completo do processo.
     */

    (void)arg1;
    (void)arg2;
    (void)arg3;
    (void)arg4;

    return -1;
}


/* =========================================================
 * Syscall SO_MATA_PROC
 * ========================================================= */

static int16_t syscall_so_mata_proc(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4)
{
    /*
     * A implementação completa será ligada posteriormente.
     */

    (void)arg1;
    (void)arg2;
    (void)arg3;
    (void)arg4;

    return -1;
}


/* =========================================================
 * Syscall SO_ESPERA_PROC
 * ========================================================= */

static int16_t syscall_so_espera_proc(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4)
{
    /*
     * O bloqueio e a espera pela morte de outro processo
     * serão implementados em uma etapa posterior.
     */

    (void)arg1;
    (void)arg2;
    (void)arg3;
    (void)arg4;

    return -1;
}


/* =========================================================
 * Registro das syscalls
 * ========================================================= */

void so_inicializa_syscalls(so_t *so)
{
    (void)so;

    syscall_inicializa();

    syscall_registra(
        SO_LE,
        syscall_so_le
    );

    syscall_registra(
        SO_ESCREVE,
        syscall_so_escreve
    );

    syscall_registra(
        SO_CRIA_PROC,
        syscall_so_cria_proc
    );

    syscall_registra(
        SO_MATA_PROC,
        syscall_so_mata_proc
    );

    syscall_registra(
        SO_ESPERA_PROC,
        syscall_so_espera_proc
    );
}


/* =========================================================
 * Atendimento de trap 7
 * ========================================================= */

int so_trata_syscall(so_t *so)
{
    processo_t *processo;
    uint16_t numero;
    uint16_t arg1;
    uint16_t arg2;
    uint16_t arg3;
    uint16_t arg4;
    int16_t retorno;

    if (so == NULL) {
        return -1;
    }

    if (so->processo_atual < 0 ||
        so->processo_atual >= SO_MAX_PROCESSOS) {

        return -1;
    }

    processo = &so->processos[so->processo_atual];

    if (!processo->usado) {
        return -1;
    }

    /*
     * O contexto salvo contém:
     *
     * contexto[0] = r0
     * contexto[1] = r1
     * contexto[2] = r2
     * contexto[3] = r3
     * contexto[4] = r4
     */

    numero = processo->contexto[0];
    arg1   = processo->contexto[1];
    arg2   = processo->contexto[2];
    arg3   = processo->contexto[3];
    arg4   = processo->contexto[4];

    retorno = syscall_executa(
        numero,
        arg1,
        arg2,
        arg3,
        arg4
    );

    /*
     * Convenção da T2:
     *
     * retorno da syscall -> r0
     */
    processo->contexto[0] = (uint16_t)retorno;

    /*
     * O processo continua executando a partir do
     * endereço salvo antes do trap.
     */
    so_restaura_contexto_atual(so);

    return 0;
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

        so->processos[i].estado = PROC_MORTO;

        if (so->processo_atual == i) {
            so->processo_atual = -1;
        }

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

    if (so->processo_atual >= 0 &&
        so->processo_atual < SO_MAX_PROCESSOS &&
        so->processos[so->processo_atual].usado &&
        so->processos[so->processo_atual].estado == PROC_EXECUTANDO) {

        return so->processo_atual;
    }

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