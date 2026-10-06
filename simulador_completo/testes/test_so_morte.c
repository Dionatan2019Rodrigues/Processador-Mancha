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


static int encontra_slot_por_pid(
    const so_t *so,
    uint16_t pid)
{
    int i;

    for (i = 0; i < SO_MAX_PROCESSOS; i++) {

        if (so->processos[i].usado &&
            so->processos[i].pid == pid) {

            return i;
        }
    }

    return -1;
}


int main(void)
{
    so_t so;

    uint16_t contexto_a[16];
    uint16_t contexto_b[16];
    uint16_t contexto_c[16];

    int pid2;
    int pid3;
    int pid4;

    int slot2;
    int slot3;
    int slot4;


    prepara_contexto(contexto_a, 0x1100, 0x03D0);
    prepara_contexto(contexto_b, 0x2200, 0x03C0);
    prepara_contexto(contexto_c, 0x3300, 0x03B0);


    printf("\n");
    printf("============================================\n");
    printf("TESTE 1 - criacao dos processos\n");
    printf("============================================\n");

    so_inicializa(&so, NULL);

    pid2 = so_cria_processo(&so, contexto_b);
    pid3 = so_cria_processo(&so, contexto_c);

    if (pid2 < 0 || pid3 < 0) {
        printf("ERRO: falha ao criar processos.\n");
        return 1;
    }

    slot2 = encontra_slot_por_pid(&so, (uint16_t)pid2);
    slot3 = encontra_slot_por_pid(&so, (uint16_t)pid3);

    printf("PID 2 = %d | slot = %d\n", pid2, slot2);
    printf("PID 3 = %d | slot = %d\n", pid3, slot3);

    printf("OK: processos criados.\n");


    printf("\n");
    printf("============================================\n");
    printf("TESTE 2 - matar processo pronto\n");
    printf("============================================\n");

    if (so_mata_processo(&so, (uint16_t)pid2) != 0) {
        printf("ERRO: nao foi possivel matar processo.\n");
        return 1;
    }

    if (so.processos[slot2].usado) {
        printf("ERRO: slot do processo morto nao foi liberado.\n");
        return 1;
    }

    if (so.processos[slot2].estado != PROC_LIVRE) {
        printf("ERRO: slot deveria estar LIVRE.\n");
        return 1;
    }

    printf("OK: processo morto e slot liberado.\n");


    printf("\n");
    printf("============================================\n");
    printf("TESTE 3 - PID nao e reutilizado\n");
    printf("============================================\n");

    pid4 = so_cria_processo(&so, contexto_a);

    if (pid4 < 0) {
        printf("ERRO: nao foi possivel criar novo processo.\n");
        return 1;
    }

    slot4 = encontra_slot_por_pid(&so, (uint16_t)pid4);

    if (slot4 != slot2) {
        printf("ERRO: slot liberado nao foi reutilizado.\n");
        return 1;
    }

    if (pid4 == pid2) {
        printf("ERRO: PID foi reutilizado.\n");
        return 1;
    }

    printf("OK: slot reutilizado e PID mantido unico.\n");
    printf("  antigo PID = %d\n", pid2);
    printf("  novo PID   = %d\n", pid4);
    printf("  slot reutilizado = %d\n", slot4);


    printf("\n");
    printf("============================================\n");
    printf("TESTE 4 - matar processo atual\n");
    printf("============================================\n");

    so.processo_atual = slot3;
    so.processos[slot3].estado = PROC_EXECUTANDO;

    if (so_mata_processo(&so, (uint16_t)pid3) != 0) {
        printf("ERRO: nao foi possivel matar processo atual.\n");
        return 1;
    }

    if (so.processo_atual != -1) {
        printf("ERRO: processo atual deveria ser -1.\n");
        return 1;
    }

    printf("OK: processo atual encerrado corretamente.\n");


    printf("\n");
    printf("============================================\n");
    printf("TESTE 5 - escalonador apos morte\n");
    printf("============================================\n");

    if (so_escalona(&so) != slot4) {
        printf("ERRO: escalonador nao encontrou processo pronto.\n");
        return 1;
    }

    if (so.processos[slot4].estado != PROC_EXECUTANDO) {
        printf("ERRO: processo nao ficou EXECUTANDO.\n");
        return 1;
    }

    printf("OK: escalonador continuou apos morte do processo.\n");
    printf("  slot atual = %d\n", so.processo_atual);
    printf("  PID atual  = %u\n", so_pid_atual(&so));


    printf("\n");
    printf("============================================\n");
    printf("TESTE 6 - PID inexistente\n");
    printf("============================================\n");

    if (so_mata_processo(&so, 9999) == 0) {
        printf("ERRO: PID inexistente deveria gerar erro.\n");
        return 1;
    }

    printf("OK: PID inexistente foi rejeitado.\n");


    printf("\n");
    printf("============================================\n");
    printf("RESUMO FINAL\n");
    printf("============================================\n");

    so_imprime_resumo(&so);


    printf("\n");
    printf("============================================\n");
    printf("OK: ETAPA 4 FUNCIONANDO.\n");
    printf("Morte de processos + reutilizacao de slot + PID unico OK.\n");
    printf("============================================\n");

    return 0;
}