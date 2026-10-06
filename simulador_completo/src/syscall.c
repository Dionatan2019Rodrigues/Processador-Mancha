#include "syscall.h"

#include <stddef.h>

/*
 * Tabela global de funções de syscall.
 *
 * Cada posição corresponde ao número da syscall.
 *
 * Exemplo:
 *
 * tabela[SO_LE]        -> função de leitura
 * tabela[SO_ESCREVE]   -> função de escrita
 * tabela[SO_CRIA_PROC] -> criação de processo
 * ...
 */
static syscall_handler_t tabela_syscalls[SO_NUM_SYSCALLS];


/*
 * Inicializa todas as posições como inválidas.
 */
void syscall_inicializa(void)
{
    uint16_t i;

    for (i = 0; i < SO_NUM_SYSCALLS; i++) {
        tabela_syscalls[i] = NULL;
    }
}


/*
 * Registra uma função para uma syscall.
 *
 * Retorno:
 *   0  -> sucesso
 *  -1  -> número inválido
 *  -2  -> função inválida
 */
int syscall_registra(
    uint16_t numero,
    syscall_handler_t handler
)
{
    if (numero >= SO_NUM_SYSCALLS) {
        return -1;
    }

    if (handler == NULL) {
        return -2;
    }

    tabela_syscalls[numero] = handler;

    return 0;
}


/*
 * Executa uma syscall.
 *
 * Se não houver uma função registrada para aquele número,
 * retorna SO_SYSCALL_INVALIDA.
 */
int16_t syscall_executa(
    uint16_t numero,
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4
)
{
    syscall_handler_t handler;

    if (numero >= SO_NUM_SYSCALLS) {
        return SO_SYSCALL_INVALIDA;
    }

    handler = tabela_syscalls[numero];

    if (handler == NULL) {
        return SO_SYSCALL_INVALIDA;
    }

    return handler(arg1, arg2, arg3, arg4);
}