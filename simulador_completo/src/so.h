// so.h -- estrutura inicial do sistema operacional do T2.
// Nesta etapa o SO mantem a tabela de processos, o processo init
// e o salvamento/restauracao do contexto.

#ifndef SO_H
#define SO_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include "cpu.h"

#define SO_MAX_PROCESSOS 16
#define SO_PID_INICIAL 1

typedef enum {
  PROC_LIVRE = 0,
  PROC_PRONTO,
  PROC_EXECUTANDO,
  PROC_BLOQUEADO,
  PROC_MORTO
} estado_processo_t;

// Contexto completo do processo:
//
//   reg[0..7]  = r0..r7
//   reg[8..15] = s0..s7
//
// Ou seja:
//
//   r0 r1 r2 r3 r4 bp sp ip
//   sr s1 s2 s3 cs cl ds dl
typedef struct {
  uint16_t reg[16];
} contexto_processo_t;

typedef struct {
  bool usado;
  int pid;
  estado_processo_t estado;
  contexto_processo_t contexto;
} processo_t;

typedef struct {
  processo_t tabela[SO_MAX_PROCESSOS];

  // Indice da tabela que representa o processo atualmente executando.
  // -1 significa que nao existe processo atual.
  int processo_atual;

  // Proximo PID que sera utilizado.
  int proximo_pid;

  // CPU controlada pelo SO.
  cpu_t *cpu;
} so_t;

so_t *so_cria(cpu_t *cpu);
void so_destroi(so_t *so);

// Cria o primeiro processo (init) usando o contexto atual da CPU.
bool so_inicializa(so_t *so);

// Reinicia a tabela e cria novamente o processo init.
bool so_reinicia(so_t *so);

// Salva o contexto atual da CPU no processo em execucao.
void so_atualiza_contexto_atual(so_t *so);

// Restaura na CPU o contexto salvo do processo atual.
bool so_restaura_contexto_atual(so_t *so);

// Consultas da tabela de processos.
int so_quantidade_processos(const so_t *so);
int so_processo_atual(const so_t *so);
const processo_t *so_processo(const so_t *so, int indice);

void so_resumo(const so_t *so,
               char *saida,
               size_t tam);

const char *so_nome_estado(estado_processo_t estado);

#endif