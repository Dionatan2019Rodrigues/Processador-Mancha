#include <stdio.h>
#include <stdint.h>

#include "cpu.h"
#include "memoria.h"
#include "dispositivos.h"
#include "instrucao.h"

int main(void)
{
    printf("========================================\n");
    printf(" TESTE DE TRAP 7\n");
    printf("========================================\n\n");

    mem_t *mem = mem_cria();
    if (!mem) {
        printf("ERRO: nao foi possivel criar memoria.\n");
        return 1;
    }

    disp_t *disp = disp_cria(mem);
    if (!disp) {
        printf("ERRO: nao foi possivel criar dispositivos.\n");
        mem_destroi(mem);
        return 1;
    }

    cpu_t *cpu = cpu_cria(mem, disp);
    if (!cpu) {
        printf("ERRO: nao foi possivel criar CPU.\n");
        disp_destroi(disp);
        mem_destroi(mem);
        return 1;
    }

    /*
     * ==================================================
     * VETOR 7 - TRAP
     * ==================================================
     *
     * Cada vetor ocupa 8 bytes:
     *
     *   IP
     *   SP
     *   CS
     *   DS
     */

    mem_escreve_palavra(mem, 7 * 8 + 0, 0x0200);
    mem_escreve_palavra(mem, 7 * 8 + 2, 0x03F0);
    mem_escreve_palavra(mem, 7 * 8 + 4, 0x8000);
    mem_escreve_palavra(mem, 7 * 8 + 6, 0x0000);

    /*
     * ==================================================
     * PROGRAMA DE TESTE
     * ==================================================
     *
     * Em 0x0080 colocamos:
     *
     *     trap 7
     *
     * A definicao em instrucao.c confirma:
     *
     *   trap = FMT_CONDICIONAL
     *   codop = 0
     *   forma = FORMA_IM6
     */

    uint16_t trap7 = instrucao_empacota(
        FMT_CONDICIONAL,
        0,
        false,
        0,
        -1,
        0,
        0,
        7,
        0
    );

    mem_escreve_palavra(mem, 0x0080, trap7);

    /*
     * ==================================================
     * CONTEXTO INICIAL
     * ==================================================
     *
     * Contexto:
     *
     *   0-7   = r0-r7
     *   8-15  = s0-s7
     *
     *   r6 = SP
     *   r7 = IP
     *   s0 = SR
     *   s4 = CS
     *   s6 = DS
     */

    uint16_t contexto[16] = {0};

    contexto[6] = 0x03D0; /* SP */
    contexto[7] = 0x0080; /* IP */

    /*
     * SR_D = 0x1000
     *
     * Desabilitamos interrupcoes externas neste teste
     * para garantir que a instrucao executada seja
     * realmente o trap 7.
     */
    contexto[8] = 0x1000; /* SR */

    contexto[12] = 0x0000; /* CS */
    contexto[14] = 0x0000; /* DS */

    /*
     * IMPORTANTE:
     *
     * NAO chamar cpu_liga().
     *
     * cpu_liga() dispara diretamente a interrupcao 0.
     */

    cpu_define_contexto(cpu, contexto);

    uint16_t antes[16];
    cpu_obtem_contexto(cpu, antes);

    printf("TESTE 1 - antes do trap\n");
    printf("  IP = %04X\n", antes[7]);
    printf("  SP = %04X\n", antes[6]);
    printf("  SR = %04X\n\n", antes[8]);

    /*
     * ==================================================
     * EXECUTA O TRAP 7
     * ==================================================
     */

    cpu_executa_1(cpu);

    uint16_t depois[16];
    cpu_obtem_contexto(cpu, depois);

    printf("TESTE 2 - depois do trap\n");
    printf("  ultima interrupcao = %d\n",
           cpu_ultima_interrupcao(cpu));

    printf("  evento = %s\n",
           cpu_ultimo_evento(cpu));

    printf("  IP do tratador = %04X\n",
           depois[7]);

    printf("  SP depois do trap = %04X\n\n",
           depois[6]);

    /*
     * ==================================================
     * VALIDACOES
     * ==================================================
     */

    if (cpu_ultima_interrupcao(cpu) != 7) {
        printf("ERRO: CPU nao identificou trap 7.\n");
        printf("  esperado = 7\n");
        printf("  obtido   = %d\n",
               cpu_ultima_interrupcao(cpu));

        cpu_destroi(cpu);
        disp_destroi(disp);
        mem_destroi(mem);
        return 1;
    }

    if (depois[7] != 0x0200) {
        printf("ERRO: IP nao foi para o tratador do trap.\n");
        printf("  esperado = 0200\n");
        printf("  obtido   = %04X\n",
               depois[7]);

        cpu_destroi(cpu);
        disp_destroi(disp);
        mem_destroi(mem);
        return 1;
    }

    if (depois[6] != 0x03D0) {
        printf("ERRO: SP incorreto apos salvar contexto.\n");
        printf("  esperado = 03D0\n");
        printf("  obtido   = %04X\n",
               depois[6]);

        cpu_destroi(cpu);
        disp_destroi(disp);
        mem_destroi(mem);
        return 1;
    }

    printf("========================================\n");
    printf("OK: TRAP 7 FUNCIONANDO.\n");
    printf("========================================\n");

    cpu_destroi(cpu);
    disp_destroi(disp);
    mem_destroi(mem);

    return 0;
}