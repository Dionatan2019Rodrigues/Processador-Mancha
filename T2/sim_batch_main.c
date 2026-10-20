/* sim_batch_main.c -- runner headless do simulador Mancha (sem ncurses).
 *
 * Uso: ./sim_batch <arquivo.mob> [max_instrucoes] [string_entrada_console]
 *
 * Compilar (a partir do workspace raiz):
 *   gcc -Wall -g \
 *     -Imancha-master/simulador_completo/src \
 *     -o T2/sim_batch \
 *     mancha-master/simulador_completo/src/cpu.c \
 *     mancha-master/simulador_completo/src/dispositivos.c \
 *     mancha-master/simulador_completo/src/instrucao.c \
 *     mancha-master/simulador_completo/src/memoria.c \
 *     mancha-master/simulador_completo/src/objeto.c \
 *     T2/sim_batch_main.c
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "cpu.h"
#include "dispositivos.h"
#include "memoria.h"
#include "objeto.h"

int main(int argc, char **argv)
{
    if (argc < 2) {
        fprintf(stderr, "uso: sim_batch arquivo.mob [max_inst] [entrada]\n");
        return 1;
    }

    long max_inst = (argc >= 3) ? atol(argv[2]) : 2000000L;
    const char *entrada = (argc >= 4) ? argv[3] : NULL;
    long atraso_entrada = (argc >= 5) ? atol(argv[4]) : 0;

    mem_t  *mem  = mem_cria();
    disp_t *disp = disp_cria(mem);
    cpu_t  *cpu  = cpu_cria(mem, disp);

    char erro[256];
    simbolo_t *simbolos = NULL;
    obj_carrega(argv[1], mem, &simbolos, erro, sizeof(erro));
    obj_libera_simbolos(simbolos);

    /* injeta entrada imediatamente se nenhum atraso foi pedido */
    if (entrada && atraso_entrada == 0) {
        for (const char *p = entrada; *p; p++)
            console_poe_entrada(disp, (unsigned char)*p);
        console_poe_entrada(disp, '\n');
    }

    cpu_liga(cpu);

    long passos = 0;
    int  ultimo_tam = 0;

    while (!cpu_parada(cpu) && passos < max_inst) {
        if (entrada && atraso_entrada > 0 && passos == atraso_entrada) {
            for (const char *p = entrada; *p; p++)
                console_poe_entrada(disp, (unsigned char)*p);
            console_poe_entrada(disp, '\n');
        }
        cpu_executa_1(cpu);
        passos++;

        /* imprime qualquer saída nova do console em tempo real */
        int tam = 0;
        const char *saida = console_saida(disp, &tam);
        if (tam > ultimo_tam) {
            fwrite(saida + ultimo_tam, 1, (size_t)(tam - ultimo_tam), stdout);
            fflush(stdout);
            ultimo_tam = tam;
        }
    }

    /* garante que toda a saída restante seja exibida */
    {
        int tam = 0;
        const char *saida = console_saida(disp, &tam);
        if (tam > ultimo_tam) {
            fwrite(saida + ultimo_tam, 1, (size_t)(tam - ultimo_tam), stdout);
            fflush(stdout);
        }
    }

    fprintf(stderr, "\n[passos:%ld parado:%d ip:%04X evt:%s]\n",
            passos, cpu_parada(cpu), cpu_r(cpu, 7), cpu_ultimo_evento(cpu));

    cpu_destroi(cpu);
    disp_destroi(disp);
    mem_destroi(mem);
    return 0;
}
