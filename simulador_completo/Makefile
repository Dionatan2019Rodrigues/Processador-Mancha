# Makefile do simulador do processador Mancha completo
# ver mancha.pdf (secções 2 a 13) e src/*.c para a implementação

CC = gcc
CFLAGS = -Wall -Wextra -std=gnu11 -g -Isrc
LDLIBS_SIM = -lcurses

SRC = src
BIN = bin
EX  = exemplos

COMUM = $(SRC)/instrucao.c $(SRC)/objeto.c $(SRC)/memoria.c

SIM_SRC = $(SRC)/main.c \
          $(SRC)/cpu.c \
          $(SRC)/dispositivos.c \
          $(SRC)/tela.c \
          $(SRC)/so.c \
          $(COMUM)

MONT_SRC = $(SRC)/montador.c $(COMUM)

ASM_EXEMPLOS = $(wildcard $(EX)/*.asm)
MOB_EXEMPLOS = $(ASM_EXEMPLOS:.asm=.mob)

.PHONY: all simulador montador exemplos teste-contexto clean

all: simulador montador exemplos

simulador: $(BIN)/simulador

montador: $(BIN)/montador

$(BIN):
	mkdir -p $(BIN)

$(BIN)/simulador: $(SIM_SRC) $(wildcard $(SRC)/*.h) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $(SIM_SRC) $(LDLIBS_SIM)

$(BIN)/montador: $(MONT_SRC) $(wildcard $(SRC)/*.h) | $(BIN)
	$(CC) $(CFLAGS) -o $@ $(MONT_SRC)

exemplos: $(BIN)/montador $(MOB_EXEMPLOS)

teste-contexto: | $(BIN)
	$(CC) $(CFLAGS) -o $(BIN)/teste-contexto \
		testes/test_so_contexto.c \
		$(SRC)/so.c \
		$(SRC)/cpu.c \
		$(SRC)/dispositivos.c \
		$(COMUM)

teste-processos:
	gcc -Wall -Wextra -std=gnu11 -g -Isrc -o bin/teste-processos \
		testes/test_so_processos.c \
		src/so.c \
		src/cpu.c \
		src/dispositivos.c \
		src/instrucao.c src/objeto.c src/memoria.c
	./bin/teste-processos

teste-morte:
	gcc -Wall -Wextra -std=gnu11 -g -Isrc -o bin/teste-morte \
		testes/test_so_morte.c \
		src/so.c \
		src/cpu.c \
		src/dispositivos.c \
		src/instrucao.c src/objeto.c src/memoria.c
	./bin/teste-morte

$(EX)/%.mob: $(EX)/%.asm $(BIN)/montador
	$(BIN)/montador $< -o $@

clean:
	rm -rf $(BIN) $(EX)/*.mob