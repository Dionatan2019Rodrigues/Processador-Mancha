#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "cpu.h"
#include "memoria.h"
#include "dispositivos.h"
#include "so.h"
#include "instrucao.h"


/* =========================================================
 * Teste de integração:
 *
 *   programa -> trap 7 -> SO -> syscall -> retorno em r0
 * ========================================================= */


static void escreve_instrucao(
    mem_t *mem,
    uint16_t endereco,
    uint16_t instrucao)
{
    mem_escreve_palavra(mem, endereco, instrucao);
}


int main(void)
{
    mem_t *mem;
    disp_t *disp;
    cpu_t *cpu;
    so_t *so;

    uint16_t contexto[16];

    printf("\n");
    printf("========================================\n");
    printf(" TESTE DE INTEGRACAO TRAP 7 + SYSCALL\n");
    printf("========================================\n");

    /*
     * -------------------------------------------------------
     * Criacao dos componentes.
     * -------------------------------------------------------
     */

    mem = mem_cria();

    if (mem == NULL) {
        printf("ERRO: nao foi possivel criar memoria.\n");
        return 1;
    }

    disp = disp_cria(mem);

    if (disp == NULL) {
        printf("ERRO: nao foi possivel criar dispositivos.\n");
        mem_destroi(mem);
        return 1;
    }

    cpu = cpu_cria(mem, disp);

    if (cpu == NULL) {
        printf("ERRO: nao foi possivel criar CPU.\n");
        disp_destroi(disp);
        mem_destroi(mem);
        return 1;
    }

    so = so_cria(cpu);

    if (so == NULL) {
        printf("ERRO: nao foi possivel criar SO.\n");
        cpu_destroi(cpu);
        disp_destroi(disp);
        mem_destroi(mem);
        return 1;
    }

    so_inicializa(so);


    /*
     * -------------------------------------------------------
     * Vetor de trap 7.
     *
     * Cada vetor ocupa 8 bytes:
     *
     *   +0 IP
     *   +2 SP
     *   +4 CS
     *   +6 DS
     * -------------------------------------------------------
     */

    mem_escreve_palavra(
        mem,
        7 * 8 + 0,
        0x0200
    );

    mem_escreve_palavra(
        mem,
        7 * 8 + 2,
        0x03D0
    );

    mem_escreve_palavra(
        mem,
        7 * 8 + 4,
        0x8000
    );

    mem_escreve_palavra(
        mem,
        7 * 8 + 6,
        0x0000
    );


    /*
     * -------------------------------------------------------
     * Programa do processo.
     *
     * Endereco 0x0080:
     *
     *     trap 7
     *
     * O encoding do trap 7 e 0x8007.
     * -------------------------------------------------------
     */

    escreve_instrucao(
        mem,
        0x0080,
        instrucao_empacota(
            FMT_CONDICIONAL,
            0,
            false,
            0,
            -1,
            0,
            0,
            7,
            0
        )
    );


    /*
     * -------------------------------------------------------
     * Contexto do processo.
     *
     * r0 = SO_ESCREVE
     * r1 = 1234
     *
     * CS precisa ser 0 para que:
     *
     *     IP 0080 -> endereco fisico 0080
     *
     * -------------------------------------------------------
     */

    memset(contexto, 0, sizeof(contexto));

    contexto[0] = SO_ESCREVE;  /* r0 */
    contexto[1] = 1234;        /* r1 */

    contexto[6] = 0x03D0;      /* SP */
    contexto[7] = 0x0080;      /* IP */

    /*
     * SR:
     *
     * D=1 evita interrupcao externa
     * S=0 significa usuario
     */
    contexto[8] = 0x1000;

    /*
     * CS
     */
    contexto[12] = 0x0000;

    /*
     * DS
     */
    contexto[14] = 0x0000;


    cpu_define_contexto(cpu, contexto);


    /*
     * O SO precisa enxergar esse contexto
     * como sendo o contexto do processo atual.
     */
    so_atualiza_contexto_atual(so);


    printf("\n");
    printf("TESTE 1 - contexto antes do trap\n");
    printf("  r0 = %04X\n", cpu_r(cpu, 0));
    printf("  r1 = %04X\n", cpu_r(cpu, 1));
    printf("  IP = %04X\n", cpu_r(cpu, 7));


    /*
     * -------------------------------------------------------
     * Executa o trap.
     * -------------------------------------------------------
     */

    cpu_executa_1(cpu);


    printf("\n");
    printf("TESTE 2 - CPU executou trap 7\n");
    printf("  ultima interrupcao = %d\n",
           cpu_ultima_interrupcao(cpu));

    printf("  IP do tratador = %04X\n",
           cpu_r(cpu, 7));


    if (cpu_ultima_interrupcao(cpu) != 7) {

        printf("\n");
        printf("ERRO: trap 7 nao foi identificado.\n");

        so_destroi(so);
        cpu_destroi(cpu);
        disp_destroi(disp);
        mem_destroi(mem);

        return 1;
    }


    /*
     * -------------------------------------------------------
     * O processo ainda possui no contexto:
     *
     *   r0 = 1
     *   r1 = 1234
     *
     * Agora o SO atende a syscall.
     * -------------------------------------------------------
     */

    if (so_trata_syscall(so) != 0) {

        printf("\n");
        printf("ERRO: SO nao conseguiu atender syscall.\n");

        so_destroi(so);
        cpu_destroi(cpu);
        disp_destroi(disp);
        mem_destroi(mem);

        return 1;
    }


    /*
     * -------------------------------------------------------
     * Depois da syscall:
     *
     * SO_ESCREVE retorna arg1.
     *
     * Portanto:
     *
     *   r0 = 1234
     * -------------------------------------------------------
     */

    printf("\n");
    printf("TESTE 3 - retorno da syscall\n");
    printf("  r0 = %04X\n", cpu_r(cpu, 0));
    printf("  esperado = 04D2\n");


    if (cpu_r(cpu, 0) != 1234) {

        printf("\n");
        printf("ERRO: retorno da syscall nao chegou em r0.\n");

        so_destroi(so);
        cpu_destroi(cpu);
        disp_destroi(disp);
        mem_destroi(mem);

        return 1;
    }


    /*
     * -------------------------------------------------------
     * Verifica se o contexto foi restaurado.
     *
     * O processo deve voltar para o contexto salvo.
     * -------------------------------------------------------
     */

    printf("\n");
    printf("TESTE 4 - contexto restaurado\n");
    printf("  IP = %04X\n", cpu_r(cpu, 7));
    printf("  SP = %04X\n", cpu_r(cpu, 6));
    printf("  r0 = %04X\n", cpu_r(cpu, 0));


    /*
     * -------------------------------------------------------
     * Resultado final.
     * -------------------------------------------------------
     */

    printf("\n");
    printf("========================================\n");
    printf(" OK: ETAPA 6 FUNCIONANDO.\n");
    printf(" Trap 7 + syscall + retorno em r0 OK.\n");
    printf("========================================\n");


    so_destroi(so);
    cpu_destroi(cpu);
    disp_destroi(disp);
    mem_destroi(mem);

    return 0;
}