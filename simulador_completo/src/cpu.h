// cpu.h -- núcleo de execução do processador Mancha completo
// (mancha.pdf, secções 2, 3, 7 e 8: modos de operação, registradores,
// interrupções e organização da memória com segmentação/paginação).
//
// Escolha de projeto documentada no README: a posição exata dos bits do
// registrador sr não é dada em texto pelo PDF (só a ordem visual na
// figura 1). Foi escolhido: bit15=S, bit14=P, bit13=I, bit12=D, bit3=N,
// bit2=O, bit1=Z, bit0=C -- escolha interna e consistente, sem efeito
// sobre a semântica descrita no texto.

#ifndef CPU_H
#define CPU_H

#include <stdint.h>
#include <stdbool.h>
#include "memoria.h"
#include "dispositivos.h"

#define SR_S 0x8000
#define SR_P 0x4000
#define SR_I 0x2000
#define SR_D 0x1000
#define SR_N 0x0008
#define SR_O 0x0004
#define SR_Z 0x0002
#define SR_C 0x0001

typedef struct cpu cpu_t;

cpu_t *cpu_cria(mem_t *mem, disp_t *disp);
void cpu_destroi(cpu_t *cpu);

// carrega o quadro de desvio 0 (início de operação) em ip/sp/cs/ds, como
// se uma interrupção tivesse acontecido (mancha.pdf, secção 7)
void cpu_liga(cpu_t *cpu);
void cpu_reinicia(cpu_t *cpu);

// executa uma "unidade" de simulação: ou o atendimento de uma interrupção
// pendente (se houver e D estiver desligado), ou uma instrução
void cpu_executa_1(cpu_t *cpu);

bool cpu_parada(cpu_t *cpu);
long cpu_num_instrucoes(cpu_t *cpu);
const char *cpu_ultimo_evento(cpu_t *cpu);
int cpu_ultima_interrupcao(cpu_t *cpu);

uint16_t cpu_r(cpu_t *cpu, int indice);
uint16_t cpu_s(cpu_t *cpu, int indice);
uint16_t cpu_sr(cpu_t *cpu);

// ---------------------------------------------------------------
// Contexto completo da CPU
//
// A ordem utilizada pelo SO e:
//   r0 r1 r2 r3 r4 bp sp ip sr s1 s2 s3 cs cl ds dl
//
// Ou seja:
//   contexto[0..7]  = r0..r7
//   contexto[8..15] = s0..s7
// ---------------------------------------------------------------

// Copia o contexto completo da CPU para um vetor de 16 palavras.
void cpu_obtem_contexto(cpu_t *cpu, uint16_t contexto[16]);

// Carrega um contexto de 16 palavras para a CPU.
void cpu_define_contexto(cpu_t *cpu, const uint16_t contexto[16]);

bool cpu_bit(cpu_t *cpu, uint16_t mascara);
bool cpu_modo_supervisor(cpu_t *cpu);
bool cpu_paginacao_ativa(cpu_t *cpu);

// desmonta a instrução apontada por ip, para exibição na interface,
// nunca causa efeitos colaterais nem interrupções
void cpu_desmonta_proxima(cpu_t *cpu, char *saida, size_t tam);

// endereço real correspondente a um endereço virtual, só para exibição
// (não altera estado, ignora violações -- usado pela janela de memória)
uint32_t cpu_traduz_exibicao(cpu_t *cpu, uint16_t virtual, bool dados);

#endif