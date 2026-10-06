// main.c -- simulador do processador Mancha completo (mancha.pdf, secções
// 2 a 13), com a mesma interface de operador do simulador do Mancha
// Mínimo: tela em curses mostrando o estado da CPU, e uma linha de
// comando com os mesmos comandos de operador.
//
// uso: ./simulador arquivo.mob [-D imagem_disco0] [-D imagem_disco1]
//
// comandos do operador:
//   E<texto>  poe <texto> na fila de entrada da console
//   Z         limpa a tela de saida da console
//   D<n>      muda a velocidade da simulacao
//   1         executa uma instrucao
//   C         continua a execucao
//   P         para a execucao
//   R         reinicia a CPU e o SO
//   T         mostra informacoes do processo atual
//   F         termina o simulador

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <curses.h>

#include "memoria.h"
#include "dispositivos.h"
#include "cpu.h"
#include "objeto.h"
#include "tela.h"
#include "so.h"

#define ALTURA_MINIMA 36
#define LARGURA_MINIMA 90
#define TAM_CMD 256

int main(int argc, char *argv[])
{
  const char *arquivo = NULL;
  const char *discos[DISCO_UNIDADES] = {0};
  int n_discos = 0;

  // ------------------------------------------------------------
  // Leitura dos argumentos.
  // ------------------------------------------------------------

  for (int i = 1; i < argc; i++) {

    if (strcmp(argv[i], "-D") == 0 && i + 1 < argc) {

      if (n_discos < DISCO_UNIDADES)
        discos[n_discos++] = argv[++i];
      else
        i++;

    } else if (arquivo == NULL) {

      arquivo = argv[i];
    }
  }

  if (arquivo == NULL) {

    fprintf(
        stderr,
        "uso: %s arquivo.mob [-D imagem_disco0] [-D imagem_disco1]\n",
        argv[0]
    );

    fprintf(
        stderr,
        "  (monte um .asm com o montador antes: "
        "./bin/montador entrada.asm)\n"
    );

    return 1;
  }

  // ------------------------------------------------------------
  // Cria memoria, dispositivos, CPU e SO.
  // ------------------------------------------------------------

  mem_t *mem = mem_cria();
  disp_t *disp = disp_cria(mem);
  cpu_t *cpu = cpu_cria(mem, disp);

  so_t *so = so_cria(cpu);

  if (so == NULL) {

    fprintf(stderr,
            "erro: nao foi possivel criar o SO\n");

    cpu_destroi(cpu);
    disp_destroi(disp);
    mem_destroi(mem);

    return 1;
  }

  // ------------------------------------------------------------
  // Monta as imagens de disco.
  // ------------------------------------------------------------

  for (int i = 0; i < n_discos; i++) {

    char erro[256];

    if (!disp_monta_disco(
            disp,
            i,
            discos[i],
            erro,
            sizeof(erro))) {

      fprintf(
          stderr,
          "erro ao montar disco %d: %s\n",
          i,
          erro
      );

      so_destroi(so);
      cpu_destroi(cpu);
      disp_destroi(disp);
      mem_destroi(mem);

      return 1;
    }
  }

  // ------------------------------------------------------------
  // Carrega o programa .mob na memoria.
  // ------------------------------------------------------------

  char erro[256];
  simbolo_t *simbolos = NULL;

  if (!obj_carrega(
          arquivo,
          mem,
          &simbolos,
          erro,
          sizeof(erro))) {

    fprintf(
        stderr,
        "erro ao carregar '%s': %s\n",
        arquivo,
        erro
    );

    so_destroi(so);
    cpu_destroi(cpu);
    disp_destroi(disp);
    mem_destroi(mem);

    return 1;
  }

  obj_libera_simbolos(simbolos);

  // ------------------------------------------------------------
  // Liga a CPU.
  // ------------------------------------------------------------

  cpu_liga(cpu);

  // ------------------------------------------------------------
  // ETAPA 1 DO T2
  //
  // O programa carregado passa a ser registrado como o primeiro
  // processo do sistema operacional: o processo init.
  // ------------------------------------------------------------

  if (!so_inicializa(so)) {

    fprintf(
        stderr,
        "erro: nao foi possivel inicializar o SO\n"
    );

    so_destroi(so);
    cpu_destroi(cpu);
    disp_destroi(disp);
    mem_destroi(mem);

    return 1;
  }

  // ------------------------------------------------------------
  // Interface.
  // ------------------------------------------------------------

  tela_inicializa();

  if (LINES < ALTURA_MINIMA ||
      COLS < LARGURA_MINIMA) {

    tela_finaliza();

    fprintf(
        stderr,
        "terminal pequeno demais (%dx%d); "
        "use pelo menos %dx%d\n",
        COLS,
        LINES,
        LARGURA_MINIMA,
        ALTURA_MINIMA
    );

    so_destroi(so);
    cpu_destroi(cpu);
    disp_destroi(disp);
    mem_destroi(mem);

    return 1;
  }

  bool rodando = false;

  int velocidade = 5;

  char mensagem[256] =
      "PARADO. Digite C para rodar, 1 para um passo, "
      "T para processos, F para sair.";

  char cmd[TAM_CMD] = "";
  int cmd_len = 0;

  int elapsed_ms = 0;
  const int tick_ms = 15;

  if (cpu_r(cpu, 7) == 0) {

    snprintf(
        mensagem,
        sizeof(mensagem),
        "aviso: quadro 0 (boot) nao definido no programa "
        "-- ip permanece 0000"
    );
  }

  bool fim = false;

  // ============================================================
  // LACO PRINCIPAL DO SIMULADOR
  // ============================================================

  while (!fim) {

    int c;

    // ----------------------------------------------------------
    // Leitura dos comandos do operador.
    // ----------------------------------------------------------

    while ((c = tela_le_tecla()) != ERR) {

      if (c == '\n' ||
          c == '\r' ||
          c == KEY_ENTER) {

        cmd[cmd_len] = '\0';

        if (cmd_len > 0) {

          char letra = cmd[0];
          char *resto = cmd + 1;

          switch (letra) {

            // --------------------------------------------------
            // Entrada da console.
            // --------------------------------------------------

            case 'E':
            case 'e':

              for (char *p = resto;
                   *p != '\0';
                   p++) {

                console_poe_entrada(disp, *p);
              }

              console_poe_entrada(disp, '\n');

              snprintf(
                  mensagem,
                  sizeof(mensagem),
                  "entrada adicionada: \"%s\"",
                  resto
              );

              break;

            // --------------------------------------------------
            // Limpa console.
            // --------------------------------------------------

            case 'Z':
            case 'z':

              console_limpa_saida(disp);

              snprintf(
                  mensagem,
                  sizeof(mensagem),
                  "tela da console limpa"
              );

              break;

            // --------------------------------------------------
            // Velocidade.
            // --------------------------------------------------

            case 'D':
            case 'd':

              if (resto[0] >= '0' &&
                  resto[0] <= '9') {

                velocidade = resto[0] - '0';

                snprintf(
                    mensagem,
                    sizeof(mensagem),
                    "velocidade alterada para D%d",
                    velocidade
                );

              } else {

                snprintf(
                    mensagem,
                    sizeof(mensagem),
                    "uso: D<0-9>"
                );
              }

              break;

            // --------------------------------------------------
            // Executa uma instrucao.
            // --------------------------------------------------

            case '1':

              if (cpu_parada(cpu)) {

                snprintf(
                    mensagem,
                    sizeof(mensagem),
                    "CPU parada, R reinicia"
                );

              } else {

                cpu_executa_1(cpu);

                // Atualiza o contexto do processo init.
                so_atualiza_contexto_atual(so);

                rodando = false;

                snprintf(
                    mensagem,
                    sizeof(mensagem),
                    "executado 1 passo"
                );
              }

              break;

            // --------------------------------------------------
            // Continua.
            // --------------------------------------------------

            case 'C':
            case 'c':

              if (cpu_parada(cpu)) {

                snprintf(
                    mensagem,
                    sizeof(mensagem),
                    "CPU parada, R reinicia"
                );

              } else {

                rodando = true;
                elapsed_ms = 0;

                snprintf(
                    mensagem,
                    sizeof(mensagem),
                    "rodando..."
                );
              }

              break;

            // --------------------------------------------------
            // Pausa.
            // --------------------------------------------------

            case 'P':
            case 'p':

              rodando = false;

              snprintf(
                  mensagem,
                  sizeof(mensagem),
                  "parado pelo operador"
              );

              break;

            // --------------------------------------------------
            // Reinicia CPU + SO.
            // --------------------------------------------------

            case 'R':
            case 'r':

              cpu_reinicia(cpu);
              so_reinicia(so);

              rodando = false;

              snprintf(
                  mensagem,
                  sizeof(mensagem),
                  "CPU reiniciada (ip=%04X)",
                  cpu_r(cpu, 7)
              );

              break;

            // --------------------------------------------------
            // TESTE DA ETAPA 1
            //
            // T mostra informacoes do processo atual.
            // --------------------------------------------------

            case 'T':
            case 't': {

              so_atualiza_contexto_atual(so);

              char resumo[256];

              so_resumo(
                  so,
                  resumo,
                  sizeof(resumo)
              );

              snprintf(
                  mensagem,
                  sizeof(mensagem),
                  "%s",
                  resumo
              );

              break;
            }

            // --------------------------------------------------
            // ETAPA 2
            //
            // V restaura o contexto salvo do processo atual.
            // --------------------------------------------------
            case 'V': case 'v': {
              if (so_restaura_contexto_atual(so)) {
                snprintf(mensagem, sizeof(mensagem),
                        "contexto restaurado: IP=%04X SP=%04X SR=%04X",
                        cpu_r(cpu, 7),
                        cpu_r(cpu, 6),
                        cpu_sr(cpu));
              } else {
                snprintf(mensagem, sizeof(mensagem),
                        "nao foi possivel restaurar o contexto");
              }
              break;
            }

            // --------------------------------------------------
            // Finaliza.
            // --------------------------------------------------

            case 'F':
            case 'f':

              fim = true;

              break;

            // --------------------------------------------------
            // Comando desconhecido.
            // --------------------------------------------------

            default:

              snprintf(
                  mensagem,
                  sizeof(mensagem),
                  "comando desconhecido: '%.100s'",
                  cmd
              );
          }
        }

        cmd_len = 0;
        cmd[0] = '\0';

      } else if (
          c == KEY_BACKSPACE ||
          c == 127 ||
          c == 8) {

        if (cmd_len > 0)
          cmd[--cmd_len] = '\0';

      } else if (
          c >= 32 &&
          c < 127 &&
          cmd_len < TAM_CMD - 1) {

        cmd[cmd_len++] = (char)c;
        cmd[cmd_len] = '\0';
      }
    }

    // ----------------------------------------------------------
    // Execucao automatica da CPU.
    // ----------------------------------------------------------

    if (rodando && !cpu_parada(cpu)) {

      if (velocidade == 0) {

        for (int i = 0;
             i < 2000 && !cpu_parada(cpu);
             i++) {

          cpu_executa_1(cpu);
          so_atualiza_contexto_atual(so);
        }

      } else {

        elapsed_ms += tick_ms;

        if (elapsed_ms >= velocidade * 100) {

          cpu_executa_1(cpu);
          so_atualiza_contexto_atual(so);

          elapsed_ms = 0;
        }
      }

      if (cpu_parada(cpu)) {

        rodando = false;

        snprintf(
            mensagem,
            sizeof(mensagem),
            "CPU parada (halt) apos %ld instrucoes",
            cpu_num_instrucoes(cpu)
        );
      }
    }

    // Garante que a tabela mantenha uma copia atualizada do contexto.
    so_atualiza_contexto_atual(so);

    // ----------------------------------------------------------
    // Desenha a interface.
    // ----------------------------------------------------------

    tela_desenha(
        cpu,
        mem,
        disp,
        arquivo,
        rodando,
        velocidade,
        mensagem,
        cmd
    );

    usleep(tick_ms * 1000);
  }

  // ------------------------------------------------------------
  // Finalizacao.
  // ------------------------------------------------------------

  tela_finaliza();

  so_destroi(so);
  cpu_destroi(cpu);
  disp_destroi(disp);
  mem_destroi(mem);

  return 0;
}