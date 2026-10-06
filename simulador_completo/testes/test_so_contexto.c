#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#include "memoria.h"
#include "dispositivos.h"
#include "cpu.h"
#include "so.h"

static bool contexto_igual(const uint16_t a[16],
                           const uint16_t b[16])
{
  for (int i = 0; i < 16; i++) {
    if (a[i] != b[i])
      return false;
  }

  return true;
}

int main(void)
{
  mem_t *mem = mem_cria();
  disp_t *disp = disp_cria(mem);
  cpu_t *cpu = cpu_cria(mem, disp);
  so_t *so = so_cria(cpu);

  if (mem == NULL ||
      disp == NULL ||
      cpu == NULL ||
      so == NULL) {

    fprintf(stderr,
            "FALHA: nao foi possivel criar a estrutura do teste\n");

    return 1;
  }

  uint16_t contexto_a[16] = {0};
  uint16_t contexto_b[16] = {0};
  uint16_t contexto_lido[16] = {0};

  /*
   * ============================================================
   * CONTEXTO A
   * ============================================================
   *
   * Vamos usar valores facilmente identificaveis.
   *
   * Principalmente:
   *
   *   SP = 03D0
   *   IP = 1234
   *   SR = B000
   */

  contexto_a[0] = 0x1000; // r0
  contexto_a[1] = 0x1001; // r1
  contexto_a[2] = 0x1002; // r2
  contexto_a[3] = 0x1003; // r3
  contexto_a[4] = 0x1004; // r4
  contexto_a[5] = 0x03E0; // bp
  contexto_a[6] = 0x03D0; // sp
  contexto_a[7] = 0x1234; // ip

  contexto_a[8]  = 0xB000; // sr
  contexto_a[9]  = 0x1009; // s1
  contexto_a[10] = 0x100A; // s2
  contexto_a[11] = 0x100B; // s3
  contexto_a[12] = 0x100C; // cs
  contexto_a[13] = 0x100D; // cl
  contexto_a[14] = 0x100E; // ds
  contexto_a[15] = 0x100F; // dl

  /*
   * ============================================================
   * CONTEXTO B
   * ============================================================
   *
   * Este representa outro processo.
   *
   * Principalmente:
   *
   *   SP = 03A0
   *   IP = 5678
   *   SR = 8000
   */

  contexto_b[0] = 0x2000; // r0
  contexto_b[1] = 0x2001; // r1
  contexto_b[2] = 0x2002; // r2
  contexto_b[3] = 0x2003; // r3
  contexto_b[4] = 0x2004; // r4
  contexto_b[5] = 0x03B0; // bp
  contexto_b[6] = 0x03A0; // sp
  contexto_b[7] = 0x5678; // ip

  contexto_b[8]  = 0x8000; // sr
  contexto_b[9]  = 0x2009; // s1
  contexto_b[10] = 0x200A; // s2
  contexto_b[11] = 0x200B; // s3
  contexto_b[12] = 0x200C; // cs
  contexto_b[13] = 0x200D; // cl
  contexto_b[14] = 0x200E; // ds
  contexto_b[15] = 0x200F; // dl

  /*
   * ============================================================
   * TESTE 1
   * ============================================================
   *
   * Coloca o contexto A na CPU.
   */

  cpu_define_contexto(cpu, contexto_a);

  printf("TESTE 1 - contexto colocado na CPU\n");
  printf("  IP = %04X\n", cpu_r(cpu, 7));
  printf("  SP = %04X\n", cpu_r(cpu, 6));
  printf("  SR = %04X\n", cpu_sr(cpu));

  /*
   * O SO cria o processo init e salva o contexto A.
   */

  if (!so_inicializa(so)) {
    fprintf(stderr,
            "FALHA: so_inicializa\n");

    return 1;
  }

  const processo_t *p =
    so_processo(so, 0);

  if (p == NULL ||
      !contexto_igual(p->contexto.reg,
                      contexto_a)) {

    fprintf(stderr,
            "FALHA: contexto A nao foi salvo corretamente\n");

    return 1;
  }

  printf("\n");
  printf("TESTE 2 - contexto A salvo pelo SO\n");
  printf("  processo: PID=%d\n", p->pid);
  printf("  IP salvo = %04X\n", p->contexto.reg[7]);
  printf("  SP salvo = %04X\n", p->contexto.reg[6]);
  printf("  SR salvo = %04X\n", p->contexto.reg[8]);

  /*
   * ============================================================
   * TESTE 3
   * ============================================================
   *
   * Agora colocamos o contexto B na CPU.
   *
   * Isso simula a CPU executando outro processo.
   */

  cpu_define_contexto(cpu, contexto_b);

  printf("\n");
  printf("TESTE 3 - CPU recebe outro contexto\n");
  printf("  IP = %04X\n", cpu_r(cpu, 7));
  printf("  SP = %04X\n", cpu_r(cpu, 6));
  printf("  SR = %04X\n", cpu_sr(cpu));

  if (cpu_r(cpu, 7) != 0x5678 ||
      cpu_r(cpu, 6) != 0x03A0 ||
      cpu_sr(cpu) != 0x8000) {

    fprintf(stderr,
            "FALHA: contexto B nao foi colocado corretamente na CPU\n");

    return 1;
  }

  /*
   * ============================================================
   * TESTE 4
   * ============================================================
   *
   * Agora pedimos ao SO para restaurar o processo.
   *
   * O esperado e:
   *
   *   CPU IP: 5678 -> 1234
   *   CPU SP: 03A0 -> 03D0
   *   CPU SR: 8000 -> B000
   */

  printf("\n");
  printf("TESTE 4 - restaurando contexto do processo\n");

  if (!so_restaura_contexto_atual(so)) {
    fprintf(stderr,
            "FALHA: so_restaura_contexto_atual\n");

    return 1;
  }

  printf("  IP antes : 5678\n");
  printf("  IP depois: %04X\n", cpu_r(cpu, 7));

  printf("  SP depois: %04X\n", cpu_r(cpu, 6));
  printf("  SR depois: %04X\n", cpu_sr(cpu));

  /*
   * Confirma que os 16 registradores voltaram para A.
   */

  cpu_obtem_contexto(cpu, contexto_lido);

  if (!contexto_igual(contexto_lido,
                      contexto_a)) {

    fprintf(stderr,
            "FALHA: contexto restaurado e diferente do contexto A\n");

    return 1;
  }

  /*
   * ============================================================
   * TESTE 5
   * ============================================================
   *
   * Agora fazemos o caminho contrario:
   *
   *   CPU recebe B
   *   SO salva B
   *   CPU recebe A
   *   SO restaura B
   */

  cpu_define_contexto(cpu, contexto_b);

  so_atualiza_contexto_atual(so);

  cpu_define_contexto(cpu, contexto_a);

  printf("\n");
  printf("TESTE 5 - salvando um novo contexto\n");
  printf("  novo IP salvo = %04X\n",
         so_processo(so, 0)->contexto.reg[7]);

  if (so_processo(so, 0)->contexto.reg[7] != 0x5678) {
    fprintf(stderr,
            "FALHA: novo contexto nao foi salvo corretamente\n");

    return 1;
  }

  if (!so_restaura_contexto_atual(so)) {
    fprintf(stderr,
            "FALHA: segunda restauracao\n");

    return 1;
  }

  printf("  IP restaurado = %04X\n",
         cpu_r(cpu, 7));

  cpu_obtem_contexto(cpu, contexto_lido);

  if (!contexto_igual(contexto_lido,
                      contexto_b)) {

    fprintf(stderr,
            "FALHA: segundo contexto nao foi restaurado corretamente\n");

    return 1;
  }

  printf("\n");
  printf("============================================\n");
  printf("OK: Etapa 2 funcionando.\n");
  printf("Salvamento e restauracao dos 16 registradores OK.\n");
  printf("============================================\n");

  so_destroi(so);
  cpu_destroi(cpu);
  disp_destroi(disp);
  mem_destroi(mem);

  return 0;
}