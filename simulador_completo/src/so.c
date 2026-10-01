// so.c -- primeira etapa do sistema operacional do T2.
//
// Nesta etapa implementamos somente a infraestrutura basica de processos:
//
//   - tabela de processos
//   - PID
//   - processo atual
//   - processo init
//   - armazenamento do contexto de 16 registradores
//
// Ainda nao existe:
//
//   - escalonador
//   - syscall
//   - bloqueio
//   - preempcao
//   - criacao de novos processos
//   - destruicao de processos

#include "so.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Copia os registradores atuais da CPU para o contexto armazenado
// dentro da tabela de processos.
static void contexto_copia_cpu(const cpu_t *cpu,
                               contexto_processo_t *ctx)
{
  // Registradores de usuario:
  //
  // r0 r1 r2 r3 r4 bp sp ip
  for (int i = 0; i < 8; i++)
    ctx->reg[i] = cpu_r((cpu_t *)cpu, i);

  // Registradores de supervisor:
  //
  // sr s1 s2 s3 cs cl ds dl
  for (int i = 0; i < 8; i++)
    ctx->reg[8 + i] = cpu_s((cpu_t *)cpu, i);
}

// Coloca uma entrada da tabela no estado inicial LIVRE.
static void processo_limpa(processo_t *p)
{
  memset(p, 0, sizeof(*p));
  p->estado = PROC_LIVRE;
}

// Cria a estrutura do sistema operacional.
so_t *so_cria(cpu_t *cpu)
{
  so_t *so = calloc(1, sizeof(*so));

  if (so == NULL)
    return NULL;

  so->cpu = cpu;
  so->processo_atual = -1;
  so->proximo_pid = SO_PID_INICIAL;

  for (int i = 0; i < SO_MAX_PROCESSOS; i++)
    processo_limpa(&so->tabela[i]);

  return so;
}

// Libera a estrutura do sistema operacional.
void so_destroi(so_t *so)
{
  free(so);
}

// Inicializa o SO criando o primeiro processo.
//
// O programa que ja foi carregado na memoria e esta representado
// atualmente pela CPU passa a ser o processo init.
bool so_inicializa(so_t *so)
{
  if (so == NULL || so->cpu == NULL)
    return false;

  // Limpa a tabela inteira.
  for (int i = 0; i < SO_MAX_PROCESSOS; i++)
    processo_limpa(&so->tabela[i]);

  so->processo_atual = -1;
  so->proximo_pid = SO_PID_INICIAL;

  // ------------------------------------------------------------
  // Cria o processo init.
  //
  // Ele ocupa o slot 0 da tabela, mas seu PID e independente
  // do numero do slot.
  // ------------------------------------------------------------

  processo_t *init = &so->tabela[0];

  init->usado = true;

  init->pid = so->proximo_pid++;

  init->estado = PROC_EXECUTANDO;

  // Guarda uma fotografia completa da CPU.
  contexto_copia_cpu(so->cpu, &init->contexto);

  // O slot 0 passa a representar o processo atualmente executando.
  so->processo_atual = 0;

  return true;
}

// Reinicializa o SO.
//
// No momento ainda temos apenas o init, portanto um reset simplesmente
// limpa a tabela e cria novamente o processo inicial.
bool so_reinicia(so_t *so)
{
  return so_inicializa(so);
}

// Atualiza o contexto armazenado do processo atual.
//
// Isto sera fundamental nas proximas etapas quando o escalonador
// precisar trocar de processo.
void so_atualiza_contexto_atual(so_t *so)
{
  if (so == NULL || so->cpu == NULL)
    return;

  if (so->processo_atual < 0 ||
      so->processo_atual >= SO_MAX_PROCESSOS)
    return;

  processo_t *p = &so->tabela[so->processo_atual];

  if (!p->usado)
    return;

  contexto_copia_cpu(so->cpu, &p->contexto);
}

// Retorna a quantidade de entradas utilizadas na tabela.
int so_quantidade_processos(const so_t *so)
{
  if (so == NULL)
    return 0;

  int quantidade = 0;

  for (int i = 0; i < SO_MAX_PROCESSOS; i++) {
    if (so->tabela[i].usado)
      quantidade++;
  }

  return quantidade;
}

// Retorna o indice do processo atual.
int so_processo_atual(const so_t *so)
{
  if (so == NULL)
    return -1;

  return so->processo_atual;
}

// Retorna uma entrada da tabela.
const processo_t *so_processo(const so_t *so, int indice)
{
  if (so == NULL)
    return NULL;

  if (indice < 0 || indice >= SO_MAX_PROCESSOS)
    return NULL;

  return &so->tabela[indice];
}

// Converte estado numerico para texto.
const char *so_nome_estado(estado_processo_t estado)
{
  switch (estado) {
    case PROC_LIVRE:
      return "LIVRE";

    case PROC_PRONTO:
      return "PRONTO";

    case PROC_EXECUTANDO:
      return "EXECUTANDO";

    case PROC_BLOQUEADO:
      return "BLOQUEADO";

    case PROC_MORTO:
      return "MORTO";

    default:
      return "?";
  }
}

// Produz uma descricao resumida do estado atual do SO.
//
// Exemplo:
//
// processos=1 | atual: slot=0 PID=1 estado=EXECUTANDO |
// IP=0080 SP=03D0 SR=B000
void so_resumo(const so_t *so, char *saida, size_t tam)
{
  if (saida == NULL || tam == 0)
    return;

  if (so == NULL) {
    snprintf(saida, tam, "SO inexistente");
    return;
  }

  if (so->processo_atual < 0 ||
      so->processo_atual >= SO_MAX_PROCESSOS) {

    snprintf(saida, tam,
             "processos=%d | nenhum processo atual",
             so_quantidade_processos(so));

    return;
  }

  const processo_t *p =
      &so->tabela[so->processo_atual];

  snprintf(
      saida,
      tam,
      "processos=%d | atual: slot=%d PID=%d estado=%s | "
      "IP=%04X SP=%04X SR=%04X",
      so_quantidade_processos(so),
      so->processo_atual,
      p->pid,
      so_nome_estado(p->estado),
      p->contexto.reg[7],
      p->contexto.reg[6],
      p->contexto.reg[8]
  );
}