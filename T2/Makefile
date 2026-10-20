
CC        = gcc
CFLAGS    = -Wall -O2 -I../simulador_completo/src
MCC       = ../compilador_c/bin/mcc
MONTADOR  = ../simulador_completo/bin/montador
SIMULADOR = ../simulador_completo/bin/simulador
BIOS      = bios.asm

all: so.mob sim_batch

so.asm: so.c so.h
	$(MCC) so.c -o so.asm

programas.asm: programas.c so.h
	$(MCC) programas.c -o programas.asm

so.mob: $(BIOS) ponte.asm so.asm programas.asm
	$(MONTADOR) $(BIOS) ponte.asm so.asm programas.asm -o so.mob

sim_batch: sim_batch_main.c
	$(CC) $(CFLAGS) -o sim_batch \
		../simulador_completo/src/cpu.c \
		../simulador_completo/src/dispositivos.c \
		../simulador_completo/src/instrucao.c \
		../simulador_completo/src/memoria.c \
		../simulador_completo/src/objeto.c \
		sim_batch_main.c

run: so.mob
	$(SIMULADOR) so.mob

batch: so.mob sim_batch
	./sim_batch so.mob 1000000 "X"

report: so.mob sim_batch
	python3 gera_relatorio.py

clean:
	rm -rf so.asm programas.asm so.mob sim_batch *.dSYM

.PHONY: all clean run batch report
