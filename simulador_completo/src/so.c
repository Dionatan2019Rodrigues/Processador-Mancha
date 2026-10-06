// so.c -- estrutura inicial do sistema operacional do T2.
//
// Nesta etapa implementamos:
//
//   - tabela de processos
//   - PID
//   - processo atual
//   - processo init
//   - salvamento do contexto
//   - restauracao do contexto
//
// Ainda nao existe:
//
//   - escalonador
//   - syscall
//   - bloqueio
//   - preempcao
//   - criacao real de novos processos
//   - destruicao de processos

#include "so.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Copia os 16 registradores da CPU para o contexto do processo.
static void contexto_copia_cpu(const cpu_t *cpu,
                               contexto_processo_t *ctx)
{
  if (cpu == NULL || ctx == NULL)
    return;

  cpu_obtem_contexto((cpu_t *)cpu, ctx->reg);
}

// Copia o contexto salvo do processo para a CPU.
static void contexto_copia_para_cpu(cpu_t *cpu,
                                    const contexto_processo_t *ctx)
{
  if (cpu == NULL || ctx == NULL)
    return;

  cpu_define_contexto(cpu, ctx->reg);
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

  for (int i = 0; i < SO_MAX_PROCESSOS; i++)
    processo_limpa(&so->tabela[i]);

  so->processo_atual = -1;
  so->proximo_pid = SO_PID_INICIAL;

  // O init ocupa o slot 0.
  //
  // O PID continua sendo independente do numero do slot.
  processo_t *init = &so->tabela[0];

  init->usado = true;
  init->pid = so->proximo_pid++;
  init->estado = PROC_EXECUTANDO;

  // Guarda o contexto completo da CPU.
  contexto_copia_cpu(so->cpu,
                     &init->contexto);

  so->processo_atual = 0;

  return true;
}

// Reinicializa o SO.
bool so_reinicia(so_t *so)
{
  return so_inicializa(so);
}

// Salva o contexto atual da CPU no processo atual.
void so_atualiza_contexto_atual(so_t *so)
{
  if (so == NULL || so->cpu == NULL)
    return;

  if (so->processo_atual < 0 ||
      so->processo_atual >= SO_MAX_PROCESSOS)
    return;

  processo_t *p =
    &so->tabela[so->processo_atual];

  if (!p->usado)
    return;

  contexto_copia_cpu(so->cpu,
                     &p->contexto);
}

// Restaura o contexto salvo do processo atual.
//
// Esta funcao sera fundamental para o escalonador:
//
//   1. salva processo A
//   2. escolhe processo B
//   3. restaura processo B
//   4. CPU continua de onde B havia parado
bool so_restaura_contexto_atual(so_t *so)
{
  if (so == NULL || so->cpu == NULL)
    return false;

  if (so->processo_atual < 0 ||
      so->processo_atual >= SO_MAX_PROCESSOS)
    return false;

  processo_t *p =
    &so->tabela[so->processo_atual];

  if (!p->usado)
    return false;

  contexto_copia_para_cpu(so->cpu,
                          &p->contexto);

  return true;
}

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

int so_processo_atual(const so_t *so)
{
  if (so == NULL)
    return -1;

  return so->processo_atual;
}

const processo_t *so_processo(const so_t *so,
                              int indice)
{
  if (so == NULL)
    return NULL;

  if (indice < 0 ||
      indice >= SO_MAX_PROCESSOS)
    return NULL;

  return &so->tabela[indice];
}

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

void so_resumo(const so_t *so,
               char *saida,
               size_t tam)
{
  if (saida == NULL || tam == 0)
    return;

  if (so == NULL) {
    snprintf(saida,
             tam,
             "SO inexistente");
    return;
  }

  if (so->processo_atual < 0 ||
      so->processo_atual >= SO_MAX_PROCESSOS) {

    snprintf(saida,
             tam,
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