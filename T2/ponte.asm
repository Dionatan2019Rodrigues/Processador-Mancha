; ponte.asm -- Ponte entre o hardware/BIOS e o kernel escrito em C
; Fornece inicialização, trampolins de interrupção, controle de E/S e
; wrappers de chamadas de sistema para os processos de usuário.

        .equ    TICKS_POR_CLOCK = 1000

; ================================================================= Inicialização
;
; Chamado por bios.asm/_start via "call _kernel_inicio" com sp em pilha_nucleo.
_kernel_inicio:
        ; 1. Instala o escalonador no gancho do relógio da BIOS
        ld      r0, escalonador_trampolim
        st      r0, (retomada_escalonador)

        ; 2. Instala os handlers de chamada de sistema (tabela_syscalls[1..5])
        ld      r1, syscall_trampolim
        ld      r0, tabela_syscalls
        add     r0, 2                       ; syscall 1: SO_LE
        st      r1, (r0)
        ld      r0, tabela_syscalls
        add     r0, 4                       ; syscall 2: SO_ESCREVE
        st      r1, (r0)
        ld      r0, tabela_syscalls
        add     r0, 6                       ; syscall 3: SO_CRIA_PROC
        st      r1, (r0)
        ld      r0, tabela_syscalls
        add     r0, 8                       ; syscall 4: SO_MATA_PROC
        st      r1, (r0)
        ld      r0, tabela_syscalls
        add     r0, 10                      ; syscall 5: SO_ESPERA_PROC
        st      r1, (r0)

        ; 3. Inicializa o SO em C (passa o endereço fixo onde o primeiro processo vai rodar)
        ld      r0, pilha_sistema
        add     r0, -32
        push    r0
        call    _f_so_inicializa
        add     sp, 2

        ; 4. Programa o relógio para disparar a cada TICKS_POR_CLOCK instruções
        ld      r0, TICKS_POR_CLOCK
        ld      r1, r0
        shr     r1, 8
        outb    r1, (0x22)                  ; PORTA_RELOGIO_LIM_ALTO
        outb    r0, (0x23)                  ; PORTA_RELOGIO_LIM_BAIXO

        ; 5. Habilita interrupções de console (bit 0) e relógio (bit 2) -> 1 | 4 = 5
        ld      r0, 5
        outb    r0, (0x30)                  ; PORTA_CTRL_INTERRUPCOES

        ; 6. Primeiro "rete" manual: inicia o processo 0 (init) em modo usuário
        ; O "rete" desempilha sr = 0x0000 (S=0, I=0, D=0), ligando interrupções
        ; de forma limpa e atômica ao entrar no espaço de usuário.
        ld      sp, pilha_sistema
        add     sp, -32
        rete

; ============================================ Trampolim do Relógio (Escalonador)
;
; Chega aqui por jmp a partir de _bios_trata_relogio com sp em pilha_sistema-32.
escalonador_trampolim:
        ld      r0, sp
        push    r0
        call    _f_so_tique_relogio
        add     sp, 2

        ; Se o sistema ficou ocioso (processo_atual == -1), desvia para a rotina idle
        ld      r0, (_g_processo_atual)
        cmp     r0, -1
        jmpc    eq, _ponte_vai_idle

        ld      sp, pilha_sistema
        add     sp, -32
        rete

_ponte_vai_idle:
        ld      sp, pilha_nucleo
        jmp     _so_idle_loop

; ============================================ Trampolim de Chamadas de Sistema
;
; Chega aqui por "call bp" a partir de _bios_chamada_sistema, com:
;   r0 = número da syscall
;   r1 = arg1, r2 = arg2  (valores que o processo colocou antes do trap)
;   sp+0 = endereço de retorno para _bios_chamada_sistema
;
; O quadro do processo interrompido está em pilha_sistema-32 (ENDEREÇO FIXO).
; A CPU reinicia sp para pilha_sistema antes de empilhar o quadro a cada
; interrupção/trap — o quadro NÃO está na pilha corrente.
;
; Convenção do mcc: argumentos empilhados direita→esquerda.
; so_trata_syscall(quadro, num, arg1, arg2):
;   push arg2 → (bp+10)
;   push arg1 → (bp+8)
;   push num  → (bp+6)
;   push quadro → (bp+4)   ← 1º parâmetro, push por último
syscall_trampolim:
        ld      r3, pilha_sistema
        add     r3, -32                     ; r3 = &quadro = pilha_sistema - 32 (fixo)
        push    r2                          ; arg2   → (bp+10)
        push    r1                          ; arg1   → (bp+8)
        push    r0                          ; num    → (bp+6)
        push    r3                          ; quadro → (bp+4)
        call    _f_so_trata_syscall
        add     sp, 8

        cmp     r0, 9999                    ; TROCOU_PROCESSO
        jmpc    eq, _ponte_sc_trocou

        ; Retorno normal sem troca de processo:
        ; r0 contém o valor de retorno; _bios_chamada_sistema vai gravar em (sp) e dar rete.
        ret

_ponte_sc_trocou:
        ; O processo bloqueou/morreu e o novo processo já foi copiado para pilha_sistema-32.
        ; Se não há nenhum processo pronto, vai para o laço ocioso:
        ld      r0, (_g_processo_atual)
        cmp     r0, -1
        jmpc    eq, _ponte_vai_idle

        ld      sp, pilha_sistema
        add     sp, -32
        rete

; =================================================================== Laço Ocioso
;
; Executado pelo kernel quando todos os processos de usuário estão bloqueados.
_so_idle_loop:
        ei
_so_idle_laco:
        call    _f_so_trata_pendencias
        ld      r0, (_g_processo_atual)
        cmp     r0, -1
        jmpc    ne, _so_idle_sai
        jmp     _so_idle_laco

_so_idle_sai:
        ld      r0, pilha_sistema
        add     r0, -32
        push    r0
        call    _f_so_restaura_atual
        add     sp, 2
        ld      sp, pilha_sistema
        add     sp, -32
        rete

; ========================================================= Primitivas de Suporte
;
; void so_escreve_caractere(int c)
_f_so_escreve_caractere:
        push    bp
        ld      bp, sp
        ld      r0, (bp+4)
        outb    r0, (1)
        ld      sp, bp
        pop     bp
        ret

; int so_obtem_relogio_cont(void)
_f_so_obtem_relogio_cont:
        push    bp
        ld      bp, sp
        inb     r0, (0x20)
        shl     r0, 8
        inb     r1, (0x21)
        and     r1, 255
        or      r0, r1
        ld      sp, bp
        pop     bp
        ret

; void so_halt(void)
_f_so_halt:
        halt
        ret

; int bios_console_disponivel(void)
_f_bios_console_disponivel:
        push    bp
        ld      bp, sp
        call    bios_console_disponivel
        ld      sp, bp
        pop     bp
        ret

; int bios_console_le(void)
_f_bios_console_le:
        push    bp
        ld      bp, sp
        call    bios_console_le
        ld      sp, bp
        pop     bp
        ret

; ================================================= Wrappers de Syscalls (User C)
;
; int so_le(void)
_f_so_le:
        push    bp
        ld      bp, sp
        ld      r0, 1                       ; SO_LE
        trap    7
        ld      sp, bp
        pop     bp
        ret

; int so_escreve(int c)
_f_so_escreve:
        push    bp
        ld      bp, sp
        ld      r0, 2                       ; SO_ESCREVE
        ld      r1, (bp+4)
        trap    7
        ld      sp, bp
        pop     bp
        ret

; int so_cria_proc(void (*func)(void))
_f_so_cria_proc:
        push    bp
        ld      bp, sp
        ld      r0, 3                       ; SO_CRIA_PROC
        ld      r1, (bp+4)
        trap    7
        ld      sp, bp
        pop     bp
        ret

; int so_mata_proc(int pid)
_f_so_mata_proc:
        push    bp
        ld      bp, sp
        ld      r0, 4                       ; SO_MATA_PROC
        ld      r1, (bp+4)
        trap    7
        ld      sp, bp
        pop     bp
        ret

; int so_espera_proc(int pid)
_f_so_espera_proc:
        push    bp
        ld      bp, sp
        ld      r0, 5                       ; SO_ESPERA_PROC
        ld      r1, (bp+4)
        trap    7
        ld      sp, bp
        pop     bp
        ret

; Adaptação para runtime C padrão
_f_putchar:
        push    bp
        ld      bp, sp
        ld      r0, (bp+4)
        push    r0
        call    _f_so_escreve
        add     sp, 2
        ld      sp, bp
        pop     bp
        ret

_f_getchar:
        push    bp
        ld      bp, sp
        call    _f_so_le
        ld      sp, bp
        pop     bp
        ret
