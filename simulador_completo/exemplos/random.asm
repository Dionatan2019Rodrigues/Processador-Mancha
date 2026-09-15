; =========================================================
; random.asm
;
; Gera um numero pseudo-aleatorio entre 0 e 9
; utilizando o contador do relogio do Mancha.
;
; O programa espera o usuario digitar alguma coisa.
; O tempo de espera altera o contador do relogio.
;
; Depois:
;
;   contador -> mistura dos bits -> 0..255 -> %10 -> ASCII
;
; =========================================================


        .equ    pilha = 0x3F0


; ---------------------------------------------------------
; Vetor de inicializacao
; ---------------------------------------------------------

        .org    0

        .dw     main, pilha, 0, 0


; ---------------------------------------------------------
; Programa
; ---------------------------------------------------------

        .org    0x80


main:

; ---------------------------------------------------------
; Configura o limite do relogio para FFFF.
;
; 0022 = byte alto do limite
; 0023 = byte baixo do limite
; ---------------------------------------------------------

        ldq     r0, 0xFF
        outb    r0, (0x22)

        ldq     r0, 0xFF
        outb    r0, (0x23)


; ---------------------------------------------------------
; Espera o usuario digitar alguma coisa.
;
; Porta 0002 = estado da console
; Bit 1 = caractere recebido
; ---------------------------------------------------------

espera:

        in      r0, (2)

        and     r0, 2

        cmp     r0, 0

        jmpc    z, espera


; ---------------------------------------------------------
; Le e descarta o caractere digitado.
; ---------------------------------------------------------

        in      r0, (1)


; ---------------------------------------------------------
; Le o contador do relogio.
;
; 0020 = byte alto
; 0021 = byte baixo
;
; Vamos usar o byte baixo como fonte principal.
; ---------------------------------------------------------

        in      r0, (0x21)


; ---------------------------------------------------------
; Mistura o valor usando XOR e deslocamento.
;
; Como r0 veio de um byte, ele inicialmente esta
; entre 0 e 255.
; ---------------------------------------------------------

        ld      r1, r0

        shl     r1, 3

        xor     r0, r1


; ---------------------------------------------------------
; IMPORTANTE:
;
; Mantemos somente os 8 bits inferiores.
;
; Isso garante:
;
;       0 <= r0 <= 255
;
; e evita que a comparacao do modulo interprete
; o numero como negativo.
; ---------------------------------------------------------

        ldq     r1, 255

        and     r0, r1


; ---------------------------------------------------------
; Calcula r0 % 10.
;
; Exemplo:
;
;       57
;       57 - 10 = 47
;       47 - 10 = 37
;       37 - 10 = 27
;       27 - 10 = 17
;       17 - 10 = 7
;
; resultado = 7
; ---------------------------------------------------------

calcula:

        ldq     r1, 9

        cmp     r0, r1

        jmpc    le, imprime


        ldq     r1, -10

        add     r0, r1

        jmpq    calcula


; ---------------------------------------------------------
; Converte o numero para ASCII.
;
; '0' = 48
;
; Portanto:
;
;       numero + 48 = ASCII
; ---------------------------------------------------------

imprime:

        ldq     r1, 48

        add     r1, r0


; ---------------------------------------------------------
; Imprime o numero na console.
; Porta 0001 = dados da console.
; ---------------------------------------------------------

        out     r1, (1)


; ---------------------------------------------------------
; Imprime um espaco.
; ---------------------------------------------------------

        ldq     r1, 32

        out     r1, (1)


; ---------------------------------------------------------
; Finaliza.
; ---------------------------------------------------------

        halt