#ifndef SYSCALL_H
#define SYSCALL_H

#include <stdint.h>

/*
 * Números das chamadas de sistema.
 *
 * A convenção do T2 é:
 *
 *   r0 = número da syscall
 *   r1 = argumento 1
 *   r2 = argumento 2
 *   r3 = argumento 3
 *   r4 = argumento 4
 *
 * O valor retornado pela syscall será colocado em r0.
 */

#define SO_LE             0
#define SO_ESCREVE        1
#define SO_CRIA_PROC      2
#define SO_MATA_PROC      3
#define SO_ESPERA_PROC    4

#define SO_NUM_SYSCALLS   5

/*
 * Resultado padrão para syscall inexistente.
 */
#define SO_SYSCALL_INVALIDA  ((int16_t)-1)

/*
 * Função responsável por executar uma syscall.
 *
 * argumentos:
 *   numero     -> número da syscall
 *   argumentos -> r1, r2, r3 e r4
 *
 * retorno:
 *   valor que deverá ser colocado em r0.
 */
typedef int16_t (*syscall_handler_t)(
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4
);

/*
 * Inicializa a tabela de syscalls.
 */
void syscall_inicializa(void);

/*
 * Registra uma função para uma determinada syscall.
 */
int syscall_registra(
    uint16_t numero,
    syscall_handler_t handler
);

/*
 * Executa uma syscall.
 *
 * O número vem de r0.
 * Os argumentos vêm de r1-r4.
 */
int16_t syscall_executa(
    uint16_t numero,
    uint16_t arg1,
    uint16_t arg2,
    uint16_t arg3,
    uint16_t arg4
);

#endif