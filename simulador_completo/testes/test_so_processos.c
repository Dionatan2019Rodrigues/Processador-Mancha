#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "so.h"


static void prepara_contexto(
    uint16_t contexto[16],
    uint16_t ip,
    uint16_t sp)
{
    int i;

    memset(contexto, 0, sizeof(uint16_t) * 16);

    for (i = 0; i < 16; i++) {
        contexto[i] = (uint16_t)(0x1000 + i);
    }

    contexto[6] = sp;
    contexto[7] = ip;
}


int main(void)
{
    so_t so;

    uint16_t contexto_a[16];
    uint16_t contexto_b[16];
    uint16_t contexto_c[16];

    int pid2;
    int pid3;

    int slot2 = -1;
    int slot3 = -1;

    int i;


    printf("\n");
    printf("============================================\n");
    printf("TESTE 1 - processo inicial\n");
    printf("============================================\n");

    so_inicializa(&so, NULL);

    if (so.processo_atual != 0) {
        printf("ERRO: processo inicial nao esta no slot 0.\n");
        return 1;
    }

    if (so.processos[0].pid != 1) {
        printf("ERRO: PID inicial deveria ser 1.\n");
        return 1;
    }

    if (so.processos[0].estado != PROC_EXECUTANDO) {
        printf("ERRO: processo inicial deveria estar EXECUTANDO.\n");
        return 1;
    }

    printf("OK: processo inicial criado.\n");
    printf("  slot = 0\n");
    printf("  PID  = %u\n", so.processos[0].pid);
    printf("  estado = %s\n",
           so_estado_nome(so.processos[0].estado));


    printf("\n");
    printf("============================================\n");
    printf("TESTE 2 - criacao de processos\n");
    printf("============================================\n");

    prepara_contexto(contexto_a, 0x1100, 0x03D0);
    prepara_contexto(contexto_b, 0x2200, 0x03C0);
    prepara_contexto(contexto_c, 0x3300, 0x03B0);

    pid2 = so_cria_processo(&so, contexto_b);

    if (pid2 < 0) {
        printf("ERRO: nao foi possivel criar processo 2.\n");
        return 1;
    }

    pid3 = so_cria_processo(&so, contexto_c);

    if (pid3 < 0) {
        printf("ERRO: nao foi possivel criar processo 3.\n");
        return 1;
    }

    for (i = 0; i < SO_MAX_PROCESSOS; i++) {
        if (so.processos[i].usado &&
            so.processos[i].pid == (uint16_t)pid2) {
            slot2 = i;
        }

        if (so.processos[i].usado &&
            so.processos[i].pid == (uint16_t)pid3) {
            slot3 = i;
        }
    }

    if (slot2 < 0 || slot3 < 0) {
        printf("ERRO: processos criados nao encontrados.\n");
        return 1;
    }

    if (slot2 == slot3) {
        printf("ERRO: dois processos ocuparam o mesmo slot.\n");
        return 1;
    }

    if (pid2 == pid3) {
        printf("ERRO: processos receberam o mesmo PID.\n");
        return 1;
    }

    if (so.processos[slot2].estado != PROC_PRONTO ||
        so.processos[slot3].estado != PROC_PRONTO) {
        printf("ERRO: processos novos deveriam estar PRONTOS.\n");
        return 1;
    }

    printf("OK: processos criados.\n");
    printf("  processo 2: slot=%d PID=%d IP=%04X\n",
           slot2,
           pid2,
           so.processos[slot2].contexto[7]);

    printf("  processo 3: slot=%d PID=%d IP=%04X\n",
           slot3,
           pid3,
           so.processos[slot3].contexto[7]);


    printf("\n");
    printf("============================================\n");
    printf("TESTE 3 - processo atual continua executando\n");
    printf("============================================\n");

    if (so_escalona(&so) != 0) {
        printf("ERRO: escalonador deveria manter processo atual.\n");
        return 1;
    }

    printf("OK: processo atual continua executando.\n");
    printf("  slot atual = %d\n", so.processo_atual);
    printf("  PID atual  = %u\n", so_pid_atual(&so));


    printf("\n");
    printf("============================================\n");
    printf("TESTE 4 - escalonador escolhe processo pronto\n");
    printf("============================================\n");

    /*
     * Simula o caso em que o processo atual nao pode continuar.
     * O bloqueio real sera implementado em uma etapa posterior.
     */
    so.processos[so.processo_atual].estado = PROC_BLOQUEADO;

    if (so_escalona(&so) != slot2) {
        printf("ERRO: escalonador nao escolheu o primeiro processo pronto.\n");
        return 1;
    }

    if (so.processos[slot2].estado != PROC_EXECUTANDO) {
        printf("ERRO: novo processo nao ficou EXECUTANDO.\n");
        return 1;
    }

    printf("OK: escalonador escolheu o primeiro processo pronto.\n");
    printf("  slot atual = %d\n", so.processo_atual);
    printf("  PID atual  = %u\n", so_pid_atual(&so));


    printf("\n");
    printf("============================================\n");
    printf("TESTE 5 - contexto do processo escolhido\n");
    printf("============================================\n");

    /*
     * Como o teste nao possui uma CPU real associada,
     * verificamos diretamente o contexto armazenado.
     */
    if (so.processos[slot2].contexto[7] != 0x2200 ||
        so.processos[slot2].contexto[6] != 0x03C0) {

        printf("ERRO: contexto do processo escolhido esta incorreto.\n");
        return 1;
    }

    printf("OK: contexto do processo escolhido esta correto.\n");
    printf("  IP = %04X\n", so.processos[slot2].contexto[7]);
    printf("  SP = %04X\n", so.processos[slot2].contexto[6]);


    printf("\n");
    printf("============================================\n");
    printf("TESTE 6 - resumo da tabela de processos\n");
    printf("============================================\n");

    so_imprime_resumo(&so);


    printf("\n");
    printf("============================================\n");
    printf("OK: ETAPA 3 FUNCIONANDO.\n");
    printf("Criacao de processos + escalonador basico OK.\n");
    printf("============================================\n");

    return 0;
}