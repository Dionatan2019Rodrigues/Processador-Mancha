#include <stdio.h>
#include <stdint.h>

#include "../src/syscall.h"


/*
 * Função de teste para SO_LE.
 *
 * Simula uma leitura de caractere.
 */
static int16_t teste_le(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4
)
{
    (void)arg2;
    (void)arg3;
    (void)arg4;

    /*
     * Apenas para verificar que os argumentos chegaram
     * corretamente.
     */
    return (int16_t)(100 + arg1);
}


/*
 * Função de teste para SO_ESCREVE.
 */
static int16_t teste_escreve(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4
)
{
    /*
     * Retorna a soma dos argumentos para comprovar
     * que todos foram recebidos corretamente.
     */
    return (int16_t)(arg1 + arg2 + arg3 + arg4);
}


/*
 * Função de teste para SO_CRIA_PROC.
 */
static int16_t teste_cria_proc(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4
)
{
    (void)arg2;
    (void)arg3;
    (void)arg4;

    return (int16_t)(200 + arg1);
}


/*
 * Função de teste para SO_MATA_PROC.
 */
static int16_t teste_mata_proc(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4
)
{
    (void)arg2;
    (void)arg3;
    (void)arg4;

    return (int16_t)(300 + arg1);
}


/*
 * Função de teste para SO_ESPERA_PROC.
 */
static int16_t teste_espera_proc(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4
)
{
    (void)arg2;
    (void)arg3;
    (void)arg4;

    return (int16_t)(400 + arg1);
}


int main(void)
{
    int16_t resultado;


    printf("============================================\n");
    printf("TESTE ETAPA 5 - INFRAESTRUTURA DE SYSCALLS\n");
    printf("============================================\n\n");


    /*
     * TESTE 1
     *
     * Inicialização da tabela.
     */
    syscall_inicializa();

    printf("TESTE 1 - inicializacao da tabela\n");

    resultado = syscall_executa(
        SO_LE,
        10,
        0,
        0,
        0
    );

    if (resultado != SO_SYSCALL_INVALIDA) {
        printf("ERRO: syscall nao registrada deveria ser invalida.\n");
        return 1;
    }

    printf("OK: tabela inicializada corretamente.\n\n");


    /*
     * TESTE 2
     *
     * Registrar todas as cinco syscalls.
     */
    printf("TESTE 2 - registro das cinco syscalls\n");

    if (syscall_registra(SO_LE, teste_le) != 0) {
        printf("ERRO: falha ao registrar SO_LE.\n");
        return 1;
    }

    if (syscall_registra(SO_ESCREVE, teste_escreve) != 0) {
        printf("ERRO: falha ao registrar SO_ESCREVE.\n");
        return 1;
    }

    if (syscall_registra(SO_CRIA_PROC, teste_cria_proc) != 0) {
        printf("ERRO: falha ao registrar SO_CRIA_PROC.\n");
        return 1;
    }

    if (syscall_registra(SO_MATA_PROC, teste_mata_proc) != 0) {
        printf("ERRO: falha ao registrar SO_MATA_PROC.\n");
        return 1;
    }

    if (syscall_registra(SO_ESPERA_PROC, teste_espera_proc) != 0) {
        printf("ERRO: falha ao registrar SO_ESPERA_PROC.\n");
        return 1;
    }

    printf("OK: cinco syscalls registradas.\n\n");


    /*
     * TESTE 3
     *
     * SO_LE.
     */
    printf("TESTE 3 - SO_LE\n");

    resultado = syscall_executa(
        SO_LE,
        7,
        0,
        0,
        0
    );

    printf("  retorno = %d\n", resultado);

    if (resultado != 107) {
        printf("ERRO: SO_LE retornou valor inesperado.\n");
        return 1;
    }

    printf("OK: SO_LE foi despachada corretamente.\n\n");


    /*
     * TESTE 4
     *
     * SO_ESCREVE.
     */
    printf("TESTE 4 - SO_ESCREVE\n");

    resultado = syscall_executa(
        SO_ESCREVE,
        10,
        20,
        30,
        40
    );

    printf("  retorno = %d\n", resultado);

    if (resultado != 100) {
        printf("ERRO: argumentos nao foram encaminhados corretamente.\n");
        return 1;
    }

    printf("OK: SO_ESCREVE recebeu os quatro argumentos.\n\n");


    /*
     * TESTE 5
     *
     * SO_CRIA_PROC.
     */
    printf("TESTE 5 - SO_CRIA_PROC\n");

    resultado = syscall_executa(
        SO_CRIA_PROC,
        5,
        0,
        0,
        0
    );

    printf("  retorno = %d\n", resultado);

    if (resultado != 205) {
        printf("ERRO: SO_CRIA_PROC nao foi despachada corretamente.\n");
        return 1;
    }

    printf("OK: SO_CRIA_PROC foi despachada corretamente.\n\n");


    /*
     * TESTE 6
     *
     * SO_MATA_PROC.
     */
    printf("TESTE 6 - SO_MATA_PROC\n");

    resultado = syscall_executa(
        SO_MATA_PROC,
        8,
        0,
        0,
        0
    );

    printf("  retorno = %d\n", resultado);

    if (resultado != 308) {
        printf("ERRO: SO_MATA_PROC nao foi despachada corretamente.\n");
        return 1;
    }

    printf("OK: SO_MATA_PROC foi despachada corretamente.\n\n");


    /*
     * TESTE 7
     *
     * SO_ESPERA_PROC.
     */
    printf("TESTE 7 - SO_ESPERA_PROC\n");

    resultado = syscall_executa(
        SO_ESPERA_PROC,
        9,
        0,
        0,
        0
    );

    printf("  retorno = %d\n", resultado);

    if (resultado != 409) {
        printf("ERRO: SO_ESPERA_PROC nao foi despachada corretamente.\n");
        return 1;
    }

    printf("OK: SO_ESPERA_PROC foi despachada corretamente.\n\n");


    /*
     * TESTE 8
     *
     * Número de syscall inválido.
     */
    printf("TESTE 8 - syscall inexistente\n");

    resultado = syscall_executa(
        99,
        0,
        0,
        0,
        0
    );

    printf("  retorno = %d\n", resultado);

    if (resultado != SO_SYSCALL_INVALIDA) {
        printf("ERRO: syscall inexistente deveria retornar erro.\n");
        return 1;
    }

    printf("OK: syscall inexistente foi rejeitada.\n\n");


    /*
     * TESTE 9
     *
     * Número inválido no registro.
     */
    printf("TESTE 9 - registro de numero invalido\n");

    if (syscall_registra(99, teste_le) != -1) {
        printf("ERRO: registro de numero invalido deveria falhar.\n");
        return 1;
    }

    printf("OK: numero invalido foi rejeitado.\n\n");


    printf("============================================\n");
    printf("OK: ETAPA 5 FUNCIONANDO.\n");
    printf("Infraestrutura de syscalls OK.\n");
    printf("============================================\n");

    return 0;
}