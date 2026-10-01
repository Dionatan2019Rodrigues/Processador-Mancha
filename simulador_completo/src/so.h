// so.h -- estrutura inicial do sistema operacional do T2.
// Nesta primeira etapa o SO mantém a tabela de processos e o processo init.
// O escalonamento, syscalls, bloqueio e preempcao serao adicionados nas
// proximas etapas.

#ifndef SO_H
#define SO_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include "cpu.h"

#define SO_MAX_PROCESSOS 16
#define SO_PID_INICIAL 1

// Estados previstos pelo T2.
// Nesta primeira etapa usamos apenas LIVRE e EXECUTANDO.
typedef enum {
  PROC_LIVRE = 0,
  PROC_PRONTO,
  PROC_EXECUTANDO,
  PROC_BLOQUEADO,
  PROC_MORTO
} estado_processo_t;

// Contexto de um processo.
//
// A ordem utilizada aqui e:
//   r0 r1 r2 r3 r4 bp sp ip sr s1 s2 s3 cs cl ds dl
//
// Essa e a mesma informacao que futuramente sera necessaria para
// restaurar um processo atraves de rete.
typedef struct {
  uint16_t reg[16];
} contexto_processo_t;

// Entrada da tabela de processos.
typedef struct {
  bool usado;
  int pid;
  estado_processo_t estado;
  contexto_processo_t contexto;
} processo_t;

// Estrutura principal do sistema operacional.
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

// Cria e inicializa a estrutura do SO.
so_t *so_cria(cpu_t *cpu);

// Libera a estrutura do SO.
void so_destroi(so_t *so);

// Cria o primeiro processo (init) usando o contexto atual da CPU.
bool so_inicializa(so_t *so);

// Reinicia a tabela e cria novamente o processo init.
bool so_reinicia(so_t *so);

// Atualiza o contexto armazenado do processo atualmente executando.
void so_atualiza_contexto_atual(so_t *so);

// Consultas da tabela de processos.
int so_quantidade_processos(const so_t *so);
int so_processo_atual(const so_t *so);
const processo_t *so_processo(const so_t *so, int indice);

// Produz uma linha resumida da situacao atual do SO.
// Usada nesta primeira etapa para podermos testar a implementacao.
void so_resumo(const so_t *so, char *saida, size_t tam);

// Converte um estado para texto.
const char *so_nome_estado(estado_processo_t estado);

#endif