; ===== código gerado por mcc =====
.text
_f_fila_inicializa:
	push bp
	ld bp, sp
	ld r0, 0
	st r0, (_g_fila_inicio)
	ld r0, 0
	st r0, (_g_fila_fim)
	ld r0, 0
	st r0, (_g_fila_n)
	ld sp, bp
	pop bp
	ret
_f_fila_insere:
	push bp
	ld bp, sp
	ld r0, (_g_fila_n)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ge, _L7f8f6e18_6
	ld r0, 0
	jmp _L7f8f6e18_7
_L7f8f6e18_6:
	ld r0, 1
_L7f8f6e18_7:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_8
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_8:
	ld r0, _g_fila_prontos
	push r0
	ld r0, (_g_fila_fim)
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, (bp+4)
	pop r1
	st r0, (r1)
	ld r0, (_g_fila_fim)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (_g_fila_fim)
	ld r0, (_g_fila_fim)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ge, _L7f8f6e18_9
	ld r0, 0
	jmp _L7f8f6e18_10
_L7f8f6e18_9:
	ld r0, 1
_L7f8f6e18_10:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_11
	ld r0, 0
	st r0, (_g_fila_fim)
_L7f8f6e18_11:
	ld r0, (_g_fila_n)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (_g_fila_n)
	ld sp, bp
	pop bp
	ret
_f_fila_retira:
	push bp
	ld bp, sp
	sub sp, 2
	ld r0, (_g_fila_n)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_18
	ld r0, 0
	jmp _L7f8f6e18_19
_L7f8f6e18_18:
	ld r0, 1
_L7f8f6e18_19:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_20
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_20:
	ld r0, _g_fila_prontos
	push r0
	ld r0, (_g_fila_inicio)
	mul r0, 2
	pop r1
	add r1, r0
	ld r0, (r1)
	st r0, (bp+-2)
	ld r0, (_g_fila_inicio)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (_g_fila_inicio)
	ld r0, (_g_fila_inicio)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ge, _L7f8f6e18_21
	ld r0, 0
	jmp _L7f8f6e18_22
_L7f8f6e18_21:
	ld r0, 1
_L7f8f6e18_22:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_23
	ld r0, 0
	st r0, (_g_fila_inicio)
_L7f8f6e18_23:
	ld r0, (_g_fila_n)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (_g_fila_n)
	ld r0, (bp+-2)
	ld sp, bp
	pop bp
	ret
	ld sp, bp
	pop bp
	ret
_f_so_cria_proc_interno:
	push bp
	ld bp, sp
	sub sp, 6
	ld r0, 1
	xor r0, -1
	add r0, 1
	st r0, (bp+-2)
	ld r0, 0
	st r0, (bp+-4)
_L7f8f6e18_42:
	ld r0, (bp+-4)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_44
	ld r0, 0
	jmp _L7f8f6e18_45
_L7f8f6e18_44:
	ld r0, 1
_L7f8f6e18_45:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_43
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-4)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_48
	ld r0, 0
	jmp _L7f8f6e18_49
_L7f8f6e18_48:
	ld r0, 1
_L7f8f6e18_49:
	cmp r0, 0
	jmpc ne, _L7f8f6e18_47
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-4)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 4
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_50
	ld r0, 0
	jmp _L7f8f6e18_51
_L7f8f6e18_50:
	ld r0, 1
_L7f8f6e18_51:
	cmp r0, 0
	jmpc ne, _L7f8f6e18_47
	ld r0, 0
	jmp _L7f8f6e18_46
_L7f8f6e18_47:
	ld r0, 1
_L7f8f6e18_46:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_52
	ld r0, (bp+-4)
	st r0, (bp+-2)
	jmp _L7f8f6e18_43
_L7f8f6e18_52:
	ld r0, (bp+-4)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-4)
	jmp _L7f8f6e18_42
_L7f8f6e18_43:
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_53
	ld r0, 0
	jmp _L7f8f6e18_54
_L7f8f6e18_53:
	ld r0, 1
_L7f8f6e18_54:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_55
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_55:
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, r1
	st r0, (bp+-6)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, (_g_proximo_pid)
	pop r1
	st r0, (r1)
	ld r0, (_g_proximo_pid)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (_g_proximo_pid)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+4)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+6)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 500
	pop r1
	st r0, (r1+8)
	ld r0, 0
	st r0, (bp+-4)
_L7f8f6e18_56:
	ld r0, (bp+-4)
	push r0
	ld r0, 16
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_58
	ld r0, 0
	jmp _L7f8f6e18_59
_L7f8f6e18_58:
	ld r0, 1
_L7f8f6e18_59:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_57
	ld r0, (bp+-6)
	ld r1, r0
	ld r0, r1
	add r0, 10
	push r0
	ld r0, (bp+-4)
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1)
	ld r0, (bp+-4)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-4)
	jmp _L7f8f6e18_56
_L7f8f6e18_57:
	ld r0, (bp+-6)
	ld r1, r0
	ld r0, r1
	add r0, 10
	push r0
	ld r0, 6
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, _g_pilhas_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 256
	pop r1
	add r1, r0
	ld r0, r1
	push r0
	ld r0, 128
	mul r0, 2
	pop r1
	add r1, r0
	ld r0, r1
	pop r1
	st r0, (r1)
	ld r0, (bp+-6)
	ld r1, r0
	ld r0, r1
	add r0, 10
	push r0
	ld r0, 7
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, (bp+4)
	pop r1
	st r0, (r1)
	ld r0, (bp+-6)
	ld r1, r0
	ld r0, r1
	add r0, 10
	push r0
	ld r0, 8
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, (_g_tempo_sistema)
	pop r1
	st r0, (r1+42)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+44)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+46)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+48)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+50)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+52)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+54)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+56)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+58)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, (_g_tempo_sistema)
	pop r1
	st r0, (r1+60)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+62)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+64)
	ld r0, (bp+-6)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+66)
	ld r0, (_g_metricas)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (_g_metricas)
	ld r0, 1
	push r0
	ld r0, (bp+-2)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, (bp+-6)
	ld r1, r0
	ld r0, (r1)
	ld sp, bp
	pop bp
	ret
	ld sp, bp
	pop bp
	ret
_f_so_muda_estado:
	push bp
	ld bp, sp
	sub sp, 6
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+4)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, r1
	st r0, (bp+-2)
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+2)
	st r0, (bp+-6)
	ld r0, (_g_tempo_sistema)
	push r0
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+60)
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-4)
	ld r0, (bp+-4)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_98
	ld r0, 0
	jmp _L7f8f6e18_99
_L7f8f6e18_98:
	ld r0, 1
_L7f8f6e18_99:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_100
	ld r0, (bp+-6)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_101
	ld r0, 0
	jmp _L7f8f6e18_102
_L7f8f6e18_101:
	ld r0, 1
_L7f8f6e18_102:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_103
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+54)
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1+54)
	jmp _L7f8f6e18_104
_L7f8f6e18_103:
	ld r0, (bp+-6)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_105
	ld r0, 0
	jmp _L7f8f6e18_106
_L7f8f6e18_105:
	ld r0, 1
_L7f8f6e18_106:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_107
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+58)
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1+58)
	jmp _L7f8f6e18_108
_L7f8f6e18_107:
	ld r0, (bp+-6)
	push r0
	ld r0, 3
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_109
	ld r0, 0
	jmp _L7f8f6e18_110
_L7f8f6e18_109:
	ld r0, 1
_L7f8f6e18_110:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_111
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+56)
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1+56)
_L7f8f6e18_111:
_L7f8f6e18_108:
_L7f8f6e18_104:
_L7f8f6e18_100:
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (bp+6)
	pop r1
	st r0, (r1+2)
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (_g_tempo_sistema)
	pop r1
	st r0, (r1+60)
	ld r0, (bp+6)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_112
	ld r0, 0
	jmp _L7f8f6e18_113
_L7f8f6e18_112:
	ld r0, 1
_L7f8f6e18_113:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_114
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+48)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1+48)
	ld r0, (bp+-6)
	push r0
	ld r0, 3
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_115
	ld r0, 0
	jmp _L7f8f6e18_116
_L7f8f6e18_115:
	ld r0, 1
_L7f8f6e18_116:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_117
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (_g_tempo_sistema)
	pop r1
	st r0, (r1+62)
_L7f8f6e18_117:
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_118
	ld r0, 0
	jmp _L7f8f6e18_119
_L7f8f6e18_118:
	ld r0, 1
_L7f8f6e18_119:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_120
	ld r0, (bp+4)
	push r0
	call _f_fila_insere
	add sp, 2
_L7f8f6e18_120:
	jmp _L7f8f6e18_121
_L7f8f6e18_114:
	ld r0, (bp+6)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_122
	ld r0, 0
	jmp _L7f8f6e18_123
_L7f8f6e18_122:
	ld r0, 1
_L7f8f6e18_123:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_124
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+52)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1+52)
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+62)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_125
	ld r0, 0
	jmp _L7f8f6e18_126
_L7f8f6e18_125:
	ld r0, 1
_L7f8f6e18_126:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_127
	ld r0, (_g_tempo_sistema)
	push r0
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+62)
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-4)
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+64)
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1+64)
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+66)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1+66)
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+62)
_L7f8f6e18_127:
	jmp _L7f8f6e18_128
_L7f8f6e18_124:
	ld r0, (bp+6)
	push r0
	ld r0, 3
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_129
	ld r0, 0
	jmp _L7f8f6e18_130
_L7f8f6e18_129:
	ld r0, 1
_L7f8f6e18_130:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_131
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (bp+-2)
	ld r1, r0
	ld r0, (r1+50)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1+50)
	jmp _L7f8f6e18_132
_L7f8f6e18_131:
	ld r0, (bp+6)
	push r0
	ld r0, 4
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_133
	ld r0, 0
	jmp _L7f8f6e18_134
_L7f8f6e18_133:
	ld r0, 1
_L7f8f6e18_134:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_135
	ld r0, (bp+-2)
	ld r1, r0
	push r1
	ld r0, (_g_tempo_sistema)
	pop r1
	st r0, (r1+44)
_L7f8f6e18_135:
_L7f8f6e18_132:
_L7f8f6e18_128:
_L7f8f6e18_121:
	ld sp, bp
	pop bp
	ret
_f_so_escolhe_proximo:
	push bp
	ld bp, sp
	sub sp, 10
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_191
	ld r0, 0
	jmp _L7f8f6e18_192
_L7f8f6e18_191:
	ld r0, 1
_L7f8f6e18_192:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_193
	ld r0, (_g_processo_atual)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ge, _L7f8f6e18_194
	ld r0, 0
	jmp _L7f8f6e18_195
_L7f8f6e18_194:
	ld r0, 1
_L7f8f6e18_195:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_196
	ld r0, _g_tab_processos
	push r0
	ld r0, (_g_processo_atual)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_197
	ld r0, 0
	jmp _L7f8f6e18_198
_L7f8f6e18_197:
	ld r0, 1
_L7f8f6e18_198:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_199
	ld r0, (_g_processo_atual)
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_199:
_L7f8f6e18_196:
	ld r0, 0
	st r0, (bp+-2)
_L7f8f6e18_200:
	ld r0, (bp+-2)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_202
	ld r0, 0
	jmp _L7f8f6e18_203
_L7f8f6e18_202:
	ld r0, 1
_L7f8f6e18_203:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_201
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_204
	ld r0, 0
	jmp _L7f8f6e18_205
_L7f8f6e18_204:
	ld r0, 1
_L7f8f6e18_205:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_206
	ld r0, (bp+-2)
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_206:
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8f6e18_200
_L7f8f6e18_201:
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld sp, bp
	pop bp
	ret
	jmp _L7f8f6e18_207
_L7f8f6e18_193:
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_208
	ld r0, 0
	jmp _L7f8f6e18_209
_L7f8f6e18_208:
	ld r0, 1
_L7f8f6e18_209:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_210
_L7f8f6e18_211:
	ld r0, (_g_fila_n)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_213
	ld r0, 0
	jmp _L7f8f6e18_214
_L7f8f6e18_213:
	ld r0, 1
_L7f8f6e18_214:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_212
	call _f_fila_retira
	st r0, (bp+-4)
	ld r0, (bp+-4)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ge, _L7f8f6e18_217
	ld r0, 0
	jmp _L7f8f6e18_218
_L7f8f6e18_217:
	ld r0, 1
_L7f8f6e18_218:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_216
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-4)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_219
	ld r0, 0
	jmp _L7f8f6e18_220
_L7f8f6e18_219:
	ld r0, 1
_L7f8f6e18_220:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_216
	ld r0, 1
	jmp _L7f8f6e18_215
_L7f8f6e18_216:
	ld r0, 0
_L7f8f6e18_215:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_221
	ld r0, (bp+-4)
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_221:
	jmp _L7f8f6e18_211
_L7f8f6e18_212:
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld sp, bp
	pop bp
	ret
	jmp _L7f8f6e18_222
_L7f8f6e18_210:
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_223
	ld r0, 0
	jmp _L7f8f6e18_224
_L7f8f6e18_223:
	ld r0, 1
_L7f8f6e18_224:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_225
	ld r0, 1
	xor r0, -1
	add r0, 1
	st r0, (bp+-4)
	ld r0, 32767
	st r0, (bp+-6)
	ld r0, 0
	st r0, (bp+-8)
	ld r0, (_g_processo_atual)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-10)
	ld r0, (bp+-10)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ge, _L7f8f6e18_228
	ld r0, 0
	jmp _L7f8f6e18_229
_L7f8f6e18_228:
	ld r0, 1
_L7f8f6e18_229:
	cmp r0, 0
	jmpc ne, _L7f8f6e18_227
	ld r0, (bp+-10)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_230
	ld r0, 0
	jmp _L7f8f6e18_231
_L7f8f6e18_230:
	ld r0, 1
_L7f8f6e18_231:
	cmp r0, 0
	jmpc ne, _L7f8f6e18_227
	ld r0, 0
	jmp _L7f8f6e18_226
_L7f8f6e18_227:
	ld r0, 1
_L7f8f6e18_226:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_232
	ld r0, 0
	st r0, (bp+-10)
_L7f8f6e18_232:
_L7f8f6e18_233:
	ld r0, (bp+-8)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_235
	ld r0, 0
	jmp _L7f8f6e18_236
_L7f8f6e18_235:
	ld r0, 1
_L7f8f6e18_236:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_234
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-10)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_237
	ld r0, 0
	jmp _L7f8f6e18_238
_L7f8f6e18_237:
	ld r0, 1
_L7f8f6e18_238:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_239
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-10)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+8)
	push r0
	ld r0, (bp+-6)
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_240
	ld r0, 0
	jmp _L7f8f6e18_241
_L7f8f6e18_240:
	ld r0, 1
_L7f8f6e18_241:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_242
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-10)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+8)
	st r0, (bp+-6)
	ld r0, (bp+-10)
	st r0, (bp+-4)
_L7f8f6e18_242:
_L7f8f6e18_239:
	ld r0, (bp+-10)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-10)
	ld r0, (bp+-10)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ge, _L7f8f6e18_243
	ld r0, 0
	jmp _L7f8f6e18_244
_L7f8f6e18_243:
	ld r0, 1
_L7f8f6e18_244:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_245
	ld r0, 0
	st r0, (bp+-10)
_L7f8f6e18_245:
	ld r0, (bp+-8)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-8)
	jmp _L7f8f6e18_233
_L7f8f6e18_234:
	ld r0, (bp+-4)
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_225:
_L7f8f6e18_222:
_L7f8f6e18_207:
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld sp, bp
	pop bp
	ret
	ld sp, bp
	pop bp
	ret
_f_so_salva_quadro:
	push bp
	ld bp, sp
	sub sp, 4
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+4)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, r1
	st r0, (bp+-4)
	ld r0, 0
	st r0, (bp+-2)
_L7f8f6e18_250:
	ld r0, (bp+-2)
	push r0
	ld r0, 16
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_252
	ld r0, 0
	jmp _L7f8f6e18_253
_L7f8f6e18_252:
	ld r0, 1
_L7f8f6e18_253:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_251
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, r1
	add r0, 10
	push r0
	ld r0, (bp+-2)
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, (bp+6)
	push r0
	ld r0, (bp+-2)
	mul r0, 2
	pop r1
	add r1, r0
	ld r0, (r1)
	pop r1
	st r0, (r1)
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8f6e18_250
_L7f8f6e18_251:
	ld sp, bp
	pop bp
	ret
_f_so_restaura_quadro:
	push bp
	ld bp, sp
	sub sp, 4
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+4)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, r1
	st r0, (bp+-4)
	ld r0, 0
	st r0, (bp+-2)
_L7f8f6e18_258:
	ld r0, (bp+-2)
	push r0
	ld r0, 16
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_260
	ld r0, 0
	jmp _L7f8f6e18_261
_L7f8f6e18_260:
	ld r0, 1
_L7f8f6e18_261:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_259
	ld r0, (bp+6)
	push r0
	ld r0, (bp+-2)
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, r1
	add r0, 10
	push r0
	ld r0, (bp+-2)
	mul r0, 2
	pop r1
	add r1, r0
	ld r0, (r1)
	pop r1
	st r0, (r1)
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8f6e18_258
_L7f8f6e18_259:
	ld sp, bp
	pop bp
	ret
_f_so_restaura_atual:
	push bp
	ld bp, sp
	ld r0, (_g_processo_atual)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ge, _L7f8f6e18_265
	ld r0, 0
	jmp _L7f8f6e18_266
_L7f8f6e18_265:
	ld r0, 1
_L7f8f6e18_266:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_267
	ld r0, (bp+4)
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_restaura_quadro
	add sp, 4
_L7f8f6e18_267:
	ld sp, bp
	pop bp
	ret
_f_so_trata_pendencias:
	push bp
	ld bp, sp
	sub sp, 6
_L7f8f6e18_292:
	call _f_bios_console_disponivel
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_294
	ld r0, 0
	jmp _L7f8f6e18_295
_L7f8f6e18_294:
	ld r0, 1
_L7f8f6e18_295:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_293
	ld r0, 1
	xor r0, -1
	add r0, 1
	st r0, (bp+-4)
	ld r0, 0
	st r0, (bp+-2)
_L7f8f6e18_296:
	ld r0, (bp+-2)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_298
	ld r0, 0
	jmp _L7f8f6e18_299
_L7f8f6e18_298:
	ld r0, 1
_L7f8f6e18_299:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_297
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 3
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_300
	ld r0, 0
	jmp _L7f8f6e18_301
_L7f8f6e18_300:
	ld r0, 1
_L7f8f6e18_301:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_302
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+4)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_303
	ld r0, 0
	jmp _L7f8f6e18_304
_L7f8f6e18_303:
	ld r0, 1
_L7f8f6e18_304:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_305
	ld r0, (bp+-2)
	st r0, (bp+-4)
	jmp _L7f8f6e18_297
_L7f8f6e18_305:
_L7f8f6e18_302:
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8f6e18_296
_L7f8f6e18_297:
	ld r0, (bp+-4)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ne, _L7f8f6e18_306
	ld r0, 0
	jmp _L7f8f6e18_307
_L7f8f6e18_306:
	ld r0, 1
_L7f8f6e18_307:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_308
	call _f_bios_console_le
	st r0, (bp+-6)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-4)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, r1
	add r0, 10
	push r0
	ld r0, 0
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, (bp+-6)
	pop r1
	st r0, (r1)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-4)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+4)
	ld r0, 1
	push r0
	ld r0, (bp+-4)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, (_g_processo_atual)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_309
	ld r0, 0
	jmp _L7f8f6e18_310
_L7f8f6e18_309:
	ld r0, 1
_L7f8f6e18_310:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_311
	call _f_so_escolhe_proximo
	st r0, (_g_processo_atual)
	ld r0, (_g_processo_atual)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ne, _L7f8f6e18_312
	ld r0, 0
	jmp _L7f8f6e18_313
_L7f8f6e18_312:
	ld r0, 1
_L7f8f6e18_313:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_314
	ld r0, 2
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, (_g_quantum_config)
	st r0, (_g_quantum_restante)
_L7f8f6e18_314:
_L7f8f6e18_311:
	jmp _L7f8f6e18_315
_L7f8f6e18_308:
	jmp _L7f8f6e18_293
_L7f8f6e18_315:
	jmp _L7f8f6e18_292
_L7f8f6e18_293:
	ld sp, bp
	pop bp
	ret
_f_so_tique_relogio:
	push bp
	ld bp, sp
	sub sp, 8
	ld r0, _g_metricas+8
	push r0
	ld r0, 10
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, _g_metricas+8
	push r0
	ld r0, 10
	mul r0, 2
	pop r1
	add r1, r0
	ld r0, (r1)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1)
	ld r0, (_g_tempo_sistema)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (_g_tempo_sistema)
	ld r0, (_g_metricas+2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (_g_metricas+2)
	call _f_so_trata_pendencias
	ld r0, (_g_processo_atual)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_338
	ld r0, 0
	jmp _L7f8f6e18_339
_L7f8f6e18_338:
	ld r0, 1
_L7f8f6e18_339:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_340
	ld r0, (_g_metricas+4)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (_g_metricas+4)
	call _f_so_escolhe_proximo
	st r0, (bp+-4)
	ld r0, (bp+-4)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ne, _L7f8f6e18_341
	ld r0, 0
	jmp _L7f8f6e18_342
_L7f8f6e18_341:
	ld r0, 1
_L7f8f6e18_342:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_343
	ld r0, (bp+-4)
	st r0, (_g_processo_atual)
	ld r0, 2
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, (_g_quantum_config)
	st r0, (_g_quantum_restante)
	ld r0, (bp+4)
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_restaura_quadro
	add sp, 4
_L7f8f6e18_343:
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_340:
	ld r0, (_g_processo_atual)
	st r0, (bp+-2)
	ld r0, (_g_quantum_restante)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (_g_quantum_restante)
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_344
	ld r0, 0
	jmp _L7f8f6e18_345
_L7f8f6e18_344:
	ld r0, 1
_L7f8f6e18_345:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_346
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_346:
	ld r0, (_g_quantum_restante)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc le, _L7f8f6e18_347
	ld r0, 0
	jmp _L7f8f6e18_348
_L7f8f6e18_347:
	ld r0, 1
_L7f8f6e18_348:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_349
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_350
	ld r0, 0
	jmp _L7f8f6e18_351
_L7f8f6e18_350:
	ld r0, 1
_L7f8f6e18_351:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_352
	ld r0, (_g_quantum_config)
	push r0
	ld r0, (_g_quantum_restante)
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-6)
	ld r0, (bp+-6)
	push r0
	ld r0, (_g_quantum_config)
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_353
	ld r0, 0
	jmp _L7f8f6e18_354
_L7f8f6e18_353:
	ld r0, 1
_L7f8f6e18_354:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_355
	ld r0, (_g_quantum_config)
	st r0, (bp+-6)
_L7f8f6e18_355:
	ld r0, (bp+-6)
	push r0
	ld r0, 1000
	ld r1, r0
	pop r0
	mul r0, r1
	push r0
	ld r0, (_g_quantum_config)
	ld r1, r0
	pop r0
	div r0, r1
	st r0, (bp+-8)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+8)
	push r0
	ld r0, (bp+-8)
	ld r1, r0
	pop r0
	add r0, r1
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	div r0, r1
	pop r1
	st r0, (r1+8)
_L7f8f6e18_352:
	ld r0, (bp+4)
	push r0
	ld r0, (bp+-2)
	push r0
	call _f_so_salva_quadro
	add sp, 4
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+46)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1+46)
	ld r0, (_g_metricas+6)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (_g_metricas+6)
	ld r0, 1
	push r0
	ld r0, (bp+-2)
	push r0
	call _f_so_muda_estado
	add sp, 4
	call _f_so_escolhe_proximo
	st r0, (bp+-4)
	ld r0, (bp+-4)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_356
	ld r0, 0
	jmp _L7f8f6e18_357
_L7f8f6e18_356:
	ld r0, 1
_L7f8f6e18_357:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_358
	ld r0, 1
	xor r0, -1
	add r0, 1
	st r0, (_g_processo_atual)
	jmp _L7f8f6e18_359
_L7f8f6e18_358:
	ld r0, (bp+-4)
	st r0, (_g_processo_atual)
	ld r0, 2
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, (_g_quantum_config)
	st r0, (_g_quantum_restante)
	ld r0, (bp+4)
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_restaura_quadro
	add sp, 4
_L7f8f6e18_359:
_L7f8f6e18_349:
	ld sp, bp
	pop bp
	ret
_f_so_trata_syscall:
	push bp
	ld bp, sp
	sub sp, 16
	ld r0, _g_metricas+8
	push r0
	ld r0, 7
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, _g_metricas+8
	push r0
	ld r0, 7
	mul r0, 2
	pop r1
	add r1, r0
	ld r0, (r1)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	st r0, (r1)
	ld r0, (_g_processo_atual)
	st r0, (bp+-2)
	ld r0, (bp+6)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_483
	ld r0, 0
	jmp _L7f8f6e18_484
_L7f8f6e18_483:
	ld r0, 1
_L7f8f6e18_484:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_485
	call _f_bios_console_disponivel
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_486
	ld r0, 0
	jmp _L7f8f6e18_487
_L7f8f6e18_486:
	ld r0, 1
_L7f8f6e18_487:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_488
	call _f_bios_console_le
	st r0, (bp+-16)
	ld r0, (bp+-16)
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_488:
	ld r0, (bp+4)
	push r0
	ld r0, (bp+-2)
	push r0
	call _f_so_salva_quadro
	add sp, 4
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, 1
	pop r1
	st r0, (r1+4)
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_489
	ld r0, 0
	jmp _L7f8f6e18_490
_L7f8f6e18_489:
	ld r0, 1
_L7f8f6e18_490:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_491
	ld r0, (_g_quantum_config)
	push r0
	ld r0, (_g_quantum_restante)
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-12)
	ld r0, (bp+-12)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_492
	ld r0, 0
	jmp _L7f8f6e18_493
_L7f8f6e18_492:
	ld r0, 1
_L7f8f6e18_493:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_494
	ld r0, 0
	st r0, (bp+-12)
_L7f8f6e18_494:
	ld r0, (bp+-12)
	push r0
	ld r0, 1000
	ld r1, r0
	pop r0
	mul r0, r1
	push r0
	ld r0, (_g_quantum_config)
	ld r1, r0
	pop r0
	div r0, r1
	st r0, (bp+-14)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+8)
	push r0
	ld r0, (bp+-14)
	ld r1, r0
	pop r0
	add r0, r1
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	div r0, r1
	pop r1
	st r0, (r1+8)
_L7f8f6e18_491:
	ld r0, 3
	push r0
	ld r0, (bp+-2)
	push r0
	call _f_so_muda_estado
	add sp, 4
	call _f_so_escolhe_proximo
	st r0, (bp+-4)
	ld r0, (bp+-4)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_495
	ld r0, 0
	jmp _L7f8f6e18_496
_L7f8f6e18_495:
	ld r0, 1
_L7f8f6e18_496:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_497
	ld r0, 1
	xor r0, -1
	add r0, 1
	st r0, (_g_processo_atual)
	jmp _L7f8f6e18_498
_L7f8f6e18_497:
	ld r0, (bp+-4)
	st r0, (_g_processo_atual)
	ld r0, 2
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, (_g_quantum_config)
	st r0, (_g_quantum_restante)
	ld r0, (bp+4)
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_restaura_quadro
	add sp, 4
_L7f8f6e18_498:
	ld r0, 9999
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_485:
	ld r0, (bp+6)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_499
	ld r0, 0
	jmp _L7f8f6e18_500
_L7f8f6e18_499:
	ld r0, 1
_L7f8f6e18_500:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_501
	ld r0, (bp+8)
	push r0
	call _f_so_escreve_caractere
	add sp, 2
	ld r0, 0
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_501:
	ld r0, (bp+6)
	push r0
	ld r0, 3
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_502
	ld r0, 0
	jmp _L7f8f6e18_503
_L7f8f6e18_502:
	ld r0, 1
_L7f8f6e18_503:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_504
	ld r0, (bp+8)
	push r0
	call _f_so_cria_proc_interno
	add sp, 2
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_504:
	ld r0, (bp+6)
	push r0
	ld r0, 4
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_505
	ld r0, 0
	jmp _L7f8f6e18_506
_L7f8f6e18_505:
	ld r0, 1
_L7f8f6e18_506:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_507
	ld r0, (bp+8)
	st r0, (bp+-8)
	ld r0, (bp+-8)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_510
	ld r0, 0
	jmp _L7f8f6e18_511
_L7f8f6e18_510:
	ld r0, 1
_L7f8f6e18_511:
	cmp r0, 0
	jmpc ne, _L7f8f6e18_509
	ld r0, (bp+-8)
	push r0
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1)
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_512
	ld r0, 0
	jmp _L7f8f6e18_513
_L7f8f6e18_512:
	ld r0, 1
_L7f8f6e18_513:
	cmp r0, 0
	jmpc ne, _L7f8f6e18_509
	ld r0, 0
	jmp _L7f8f6e18_508
_L7f8f6e18_509:
	ld r0, 1
_L7f8f6e18_508:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_514
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1)
	st r0, (bp+-8)
	ld r0, 4
	push r0
	ld r0, (bp+-2)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, 0
	st r0, (bp+-6)
_L7f8f6e18_515:
	ld r0, (bp+-6)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_517
	ld r0, 0
	jmp _L7f8f6e18_518
_L7f8f6e18_517:
	ld r0, 1
_L7f8f6e18_518:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_516
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 3
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_519
	ld r0, 0
	jmp _L7f8f6e18_520
_L7f8f6e18_519:
	ld r0, 1
_L7f8f6e18_520:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_521
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+4)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_524
	ld r0, 0
	jmp _L7f8f6e18_525
_L7f8f6e18_524:
	ld r0, 1
_L7f8f6e18_525:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_523
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+6)
	push r0
	ld r0, (bp+-8)
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_526
	ld r0, 0
	jmp _L7f8f6e18_527
_L7f8f6e18_526:
	ld r0, 1
_L7f8f6e18_527:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_523
	ld r0, 1
	jmp _L7f8f6e18_522
_L7f8f6e18_523:
	ld r0, 0
_L7f8f6e18_522:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_528
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+4)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+6)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, r1
	add r0, 10
	push r0
	ld r0, 0
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1)
	ld r0, 1
	push r0
	ld r0, (bp+-6)
	push r0
	call _f_so_muda_estado
	add sp, 4
_L7f8f6e18_528:
_L7f8f6e18_521:
	ld r0, (bp+-6)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-6)
	jmp _L7f8f6e18_515
_L7f8f6e18_516:
	ld r0, (bp+-8)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_529
	ld r0, 0
	jmp _L7f8f6e18_530
_L7f8f6e18_529:
	ld r0, 1
_L7f8f6e18_530:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_531
	call _f_so_imprime_relatorio
	call _f_so_halt
	ld r0, 0
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_531:
	call _f_so_escolhe_proximo
	st r0, (bp+-4)
	ld r0, (bp+-4)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_532
	ld r0, 0
	jmp _L7f8f6e18_533
_L7f8f6e18_532:
	ld r0, 1
_L7f8f6e18_533:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_534
	ld r0, 1
	xor r0, -1
	add r0, 1
	st r0, (_g_processo_atual)
	jmp _L7f8f6e18_535
_L7f8f6e18_534:
	ld r0, (bp+-4)
	st r0, (_g_processo_atual)
	ld r0, 2
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, (_g_quantum_config)
	st r0, (_g_quantum_restante)
	ld r0, (bp+4)
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_restaura_quadro
	add sp, 4
_L7f8f6e18_535:
	ld r0, 9999
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_514:
	ld r0, 1
	xor r0, -1
	add r0, 1
	st r0, (bp+-10)
	ld r0, 0
	st r0, (bp+-6)
_L7f8f6e18_536:
	ld r0, (bp+-6)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_538
	ld r0, 0
	jmp _L7f8f6e18_539
_L7f8f6e18_538:
	ld r0, 1
_L7f8f6e18_539:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_537
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1)
	push r0
	ld r0, (bp+-8)
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_544
	ld r0, 0
	jmp _L7f8f6e18_545
_L7f8f6e18_544:
	ld r0, 1
_L7f8f6e18_545:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_543
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 4
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ne, _L7f8f6e18_546
	ld r0, 0
	jmp _L7f8f6e18_547
_L7f8f6e18_546:
	ld r0, 1
_L7f8f6e18_547:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_543
	ld r0, 1
	jmp _L7f8f6e18_542
_L7f8f6e18_543:
	ld r0, 0
_L7f8f6e18_542:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_541
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ne, _L7f8f6e18_548
	ld r0, 0
	jmp _L7f8f6e18_549
_L7f8f6e18_548:
	ld r0, 1
_L7f8f6e18_549:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_541
	ld r0, 1
	jmp _L7f8f6e18_540
_L7f8f6e18_541:
	ld r0, 0
_L7f8f6e18_540:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_550
	ld r0, (bp+-6)
	st r0, (bp+-10)
	jmp _L7f8f6e18_537
_L7f8f6e18_550:
	ld r0, (bp+-6)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-6)
	jmp _L7f8f6e18_536
_L7f8f6e18_537:
	ld r0, (bp+-10)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_551
	ld r0, 0
	jmp _L7f8f6e18_552
_L7f8f6e18_551:
	ld r0, 1
_L7f8f6e18_552:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_553
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_553:
	ld r0, 4
	push r0
	ld r0, (bp+-10)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, 0
	st r0, (bp+-6)
_L7f8f6e18_554:
	ld r0, (bp+-6)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_556
	ld r0, 0
	jmp _L7f8f6e18_557
_L7f8f6e18_556:
	ld r0, 1
_L7f8f6e18_557:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_555
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 3
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_558
	ld r0, 0
	jmp _L7f8f6e18_559
_L7f8f6e18_558:
	ld r0, 1
_L7f8f6e18_559:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_560
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+4)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_563
	ld r0, 0
	jmp _L7f8f6e18_564
_L7f8f6e18_563:
	ld r0, 1
_L7f8f6e18_564:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_562
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+6)
	push r0
	ld r0, (bp+-8)
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_565
	ld r0, 0
	jmp _L7f8f6e18_566
_L7f8f6e18_565:
	ld r0, 1
_L7f8f6e18_566:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_562
	ld r0, 1
	jmp _L7f8f6e18_561
_L7f8f6e18_562:
	ld r0, 0
_L7f8f6e18_561:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_567
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+4)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+6)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, r1
	add r0, 10
	push r0
	ld r0, 0
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1)
	ld r0, 1
	push r0
	ld r0, (bp+-6)
	push r0
	call _f_so_muda_estado
	add sp, 4
_L7f8f6e18_567:
_L7f8f6e18_560:
	ld r0, (bp+-6)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-6)
	jmp _L7f8f6e18_554
_L7f8f6e18_555:
	ld r0, 0
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_507:
	ld r0, (bp+6)
	push r0
	ld r0, 5
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_568
	ld r0, 0
	jmp _L7f8f6e18_569
_L7f8f6e18_568:
	ld r0, 1
_L7f8f6e18_569:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_570
	ld r0, (bp+8)
	st r0, (bp+-8)
	ld r0, (bp+-8)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc le, _L7f8f6e18_573
	ld r0, 0
	jmp _L7f8f6e18_574
_L7f8f6e18_573:
	ld r0, 1
_L7f8f6e18_574:
	cmp r0, 0
	jmpc ne, _L7f8f6e18_572
	ld r0, (bp+-8)
	push r0
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1)
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_575
	ld r0, 0
	jmp _L7f8f6e18_576
_L7f8f6e18_575:
	ld r0, 1
_L7f8f6e18_576:
	cmp r0, 0
	jmpc ne, _L7f8f6e18_572
	ld r0, 0
	jmp _L7f8f6e18_571
_L7f8f6e18_572:
	ld r0, 1
_L7f8f6e18_571:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_577
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_577:
	ld r0, 1
	xor r0, -1
	add r0, 1
	st r0, (bp+-10)
	ld r0, 0
	st r0, (bp+-6)
_L7f8f6e18_578:
	ld r0, (bp+-6)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_580
	ld r0, 0
	jmp _L7f8f6e18_581
_L7f8f6e18_580:
	ld r0, 1
_L7f8f6e18_581:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_579
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1)
	push r0
	ld r0, (bp+-8)
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_586
	ld r0, 0
	jmp _L7f8f6e18_587
_L7f8f6e18_586:
	ld r0, 1
_L7f8f6e18_587:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_585
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 4
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ne, _L7f8f6e18_588
	ld r0, 0
	jmp _L7f8f6e18_589
_L7f8f6e18_588:
	ld r0, 1
_L7f8f6e18_589:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_585
	ld r0, 1
	jmp _L7f8f6e18_584
_L7f8f6e18_585:
	ld r0, 0
_L7f8f6e18_584:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_583
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-6)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+2)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ne, _L7f8f6e18_590
	ld r0, 0
	jmp _L7f8f6e18_591
_L7f8f6e18_590:
	ld r0, 1
_L7f8f6e18_591:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_583
	ld r0, 1
	jmp _L7f8f6e18_582
_L7f8f6e18_583:
	ld r0, 0
_L7f8f6e18_582:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_592
	ld r0, (bp+-6)
	st r0, (bp+-10)
	jmp _L7f8f6e18_579
_L7f8f6e18_592:
	ld r0, (bp+-6)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-6)
	jmp _L7f8f6e18_578
_L7f8f6e18_579:
	ld r0, (bp+-10)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_593
	ld r0, 0
	jmp _L7f8f6e18_594
_L7f8f6e18_593:
	ld r0, 1
_L7f8f6e18_594:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_595
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_595:
	ld r0, (bp+4)
	push r0
	ld r0, (bp+-2)
	push r0
	call _f_so_salva_quadro
	add sp, 4
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, 2
	pop r1
	st r0, (r1+4)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, (bp+-8)
	pop r1
	st r0, (r1+6)
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_596
	ld r0, 0
	jmp _L7f8f6e18_597
_L7f8f6e18_596:
	ld r0, 1
_L7f8f6e18_597:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_598
	ld r0, (_g_quantum_config)
	push r0
	ld r0, (_g_quantum_restante)
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-12)
	ld r0, (bp+-12)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_599
	ld r0, 0
	jmp _L7f8f6e18_600
_L7f8f6e18_599:
	ld r0, 1
_L7f8f6e18_600:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_601
	ld r0, 0
	st r0, (bp+-12)
_L7f8f6e18_601:
	ld r0, (bp+-12)
	push r0
	ld r0, 1000
	ld r1, r0
	pop r0
	mul r0, r1
	push r0
	ld r0, (_g_quantum_config)
	ld r1, r0
	pop r0
	div r0, r1
	st r0, (bp+-14)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, (r1+8)
	push r0
	ld r0, (bp+-14)
	ld r1, r0
	pop r0
	add r0, r1
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	div r0, r1
	pop r1
	st r0, (r1+8)
_L7f8f6e18_598:
	ld r0, 3
	push r0
	ld r0, (bp+-2)
	push r0
	call _f_so_muda_estado
	add sp, 4
	call _f_so_escolhe_proximo
	st r0, (bp+-4)
	ld r0, (bp+-4)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_602
	ld r0, 0
	jmp _L7f8f6e18_603
_L7f8f6e18_602:
	ld r0, 1
_L7f8f6e18_603:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_604
	ld r0, 1
	xor r0, -1
	add r0, 1
	st r0, (_g_processo_atual)
	jmp _L7f8f6e18_605
_L7f8f6e18_604:
	ld r0, (bp+-4)
	st r0, (_g_processo_atual)
	ld r0, 2
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, (_g_quantum_config)
	st r0, (_g_quantum_restante)
	ld r0, (bp+4)
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_restaura_quadro
	add sp, 4
_L7f8f6e18_605:
	ld r0, 9999
	ld sp, bp
	pop bp
	ret
_L7f8f6e18_570:
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld sp, bp
	pop bp
	ret
	ld sp, bp
	pop bp
	ret
_f_so_inicializa:
	push bp
	ld bp, sp
	sub sp, 6
	call _f_fila_inicializa
	ld r0, 0
	st r0, (bp+-2)
_L7f8f6e18_614:
	ld r0, (bp+-2)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_616
	ld r0, 0
	jmp _L7f8f6e18_617
_L7f8f6e18_616:
	ld r0, 1
_L7f8f6e18_617:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_615
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1+2)
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1)
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8f6e18_614
_L7f8f6e18_615:
	ld r0, 0
	st r0, (bp+-2)
_L7f8f6e18_618:
	ld r0, (bp+-2)
	push r0
	ld r0, 16
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_620
	ld r0, 0
	jmp _L7f8f6e18_621
_L7f8f6e18_620:
	ld r0, 1
_L7f8f6e18_621:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_619
	ld r0, _g_metricas+8
	push r0
	ld r0, (bp+-2)
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, 0
	pop r1
	st r0, (r1)
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8f6e18_618
_L7f8f6e18_619:
	ld r0, 0
	st r0, (_g_metricas)
	ld r0, 0
	st r0, (_g_metricas+2)
	ld r0, 0
	st r0, (_g_metricas+4)
	ld r0, 0
	st r0, (_g_metricas+6)
	ld r0, _g_metricas+8
	push r0
	ld r0, 0
	mul r0, 2
	pop r1
	add r1, r0
	push r1
	ld r0, 1
	pop r1
	st r0, (r1)
	ld r0, 1
	st r0, (_g_proximo_pid)
	ld r0, 0
	st r0, (_g_tempo_sistema)
	ld r0, 1
	xor r0, -1
	add r0, 1
	st r0, (_g_processo_atual)
	ld r0, 1
	st r0, (_g_escalonador_tipo)
	ld r0, 4
	st r0, (_g_quantum_config)
	ld r0, (_g_quantum_config)
	st r0, (_g_quantum_restante)
	ld r0, _f_proc_init
	push r0
	call _f_so_cria_proc_interno
	add sp, 2
	st r0, (bp+-4)
	call _f_so_escolhe_proximo
	st r0, (bp+-6)
	ld r0, (bp+-6)
	st r0, (_g_processo_atual)
	ld r0, 2
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_muda_estado
	add sp, 4
	ld r0, (bp+4)
	push r0
	ld r0, (_g_processo_atual)
	push r0
	call _f_so_restaura_quadro
	add sp, 4
	ld sp, bp
	pop bp
	ret
_f_k_print_str:
	push bp
	ld bp, sp
_L7f8f6e18_626:
	ld r0, (bp+4)
	ld r1, r0
	ldb r0, (r1)
	and r0, 255
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ne, _L7f8f6e18_628
	ld r0, 0
	jmp _L7f8f6e18_629
_L7f8f6e18_628:
	ld r0, 1
_L7f8f6e18_629:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_627
	ld r0, (bp+4)
	ld r1, r0
	ldb r0, (r1)
	and r0, 255
	push r0
	call _f_so_escreve_caractere
	add sp, 2
	ld r0, (bp+4)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+4)
	jmp _L7f8f6e18_626
_L7f8f6e18_627:
	ld sp, bp
	pop bp
	ret
_f_k_puts:
	push bp
	ld bp, sp
	ld r0, (bp+4)
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, 10
	push r0
	call _f_so_escreve_caractere
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_k_nova_linha:
	push bp
	ld bp, sp
	ld r0, 10
	push r0
	call _f_so_escreve_caractere
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_k_linha_igual:
	push bp
	ld bp, sp
	ld r0, _str7f8f6e18_1
	push r0
	call _f_k_puts
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_k_linha_traco:
	push bp
	ld bp, sp
	ld r0, _str7f8f6e18_3
	push r0
	call _f_k_puts
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_k_print_dec:
	push bp
	ld bp, sp
	sub sp, 12
	ld r0, 0
	st r0, (bp+-10)
	ld r0, 0
	st r0, (bp+-12)
	ld r0, (bp+4)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_645
	ld r0, 0
	jmp _L7f8f6e18_646
_L7f8f6e18_645:
	ld r0, 1
_L7f8f6e18_646:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_647
	ld r0, 1
	st r0, (bp+-12)
	ld r0, (bp+4)
	xor r0, -1
	add r0, 1
	st r0, (bp+4)
_L7f8f6e18_647:
	ld r0, (bp+4)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_648
	ld r0, 0
	jmp _L7f8f6e18_649
_L7f8f6e18_648:
	ld r0, 1
_L7f8f6e18_649:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_650
	ld r0, bp
	add r0, -8
	push r0
	ld r0, 0
	mul r0, 1
	pop r1
	add r1, r0
	push r1
	ld r0, 48
	pop r1
	stb r0, (r1)
	ld r0, 1
	st r0, (bp+-10)
_L7f8f6e18_650:
_L7f8f6e18_651:
	ld r0, (bp+4)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_653
	ld r0, 0
	jmp _L7f8f6e18_654
_L7f8f6e18_653:
	ld r0, 1
_L7f8f6e18_654:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_652
	ld r0, bp
	add r0, -8
	push r0
	ld r0, (bp+-10)
	mul r0, 1
	pop r1
	add r1, r0
	push r1
	ld r0, (bp+4)
	push r0
	ld r0, 10
	ld r1, r0
	pop r0
	ld r2, r0
	div r0, r1
	mul r0, r1
	sub r2, r0
	ld r0, r2
	push r0
	ld r0, 48
	ld r1, r0
	pop r0
	add r0, r1
	pop r1
	stb r0, (r1)
	ld r0, (bp+-10)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-10)
	ld r0, (bp+4)
	push r0
	ld r0, 10
	ld r1, r0
	pop r0
	div r0, r1
	st r0, (bp+4)
	jmp _L7f8f6e18_651
_L7f8f6e18_652:
	ld r0, (bp+-12)
	cmp r0, 0
	jmpc eq, _L7f8f6e18_655
	ld r0, 45
	push r0
	call _f_so_escreve_caractere
	add sp, 2
_L7f8f6e18_655:
_L7f8f6e18_656:
	ld r0, (bp+-10)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_658
	ld r0, 0
	jmp _L7f8f6e18_659
_L7f8f6e18_658:
	ld r0, 1
_L7f8f6e18_659:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_657
	ld r0, (bp+-10)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-10)
	ld r0, bp
	add r0, -8
	push r0
	ld r0, (bp+-10)
	mul r0, 1
	pop r1
	add r1, r0
	ldb r0, (r1)
	and r0, 255
	push r0
	call _f_so_escreve_caractere
	add sp, 2
	jmp _L7f8f6e18_656
_L7f8f6e18_657:
	ld sp, bp
	pop bp
	ret
_f_k_print_campo:
	push bp
	ld bp, sp
	sub sp, 6
	ld r0, (bp+4)
	st r0, (bp+-2)
	ld r0, 0
	st r0, (bp+-4)
	ld r0, (bp+-2)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc le, _L7f8f6e18_674
	ld r0, 0
	jmp _L7f8f6e18_675
_L7f8f6e18_674:
	ld r0, 1
_L7f8f6e18_675:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_676
	ld r0, 1
	st r0, (bp+-4)
	ld r0, (bp+-2)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_677
	ld r0, 0
	jmp _L7f8f6e18_678
_L7f8f6e18_677:
	ld r0, 1
_L7f8f6e18_678:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_679
	ld r0, (bp+-2)
	xor r0, -1
	add r0, 1
	st r0, (bp+-2)
	ld r0, (bp+-4)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-4)
_L7f8f6e18_679:
_L7f8f6e18_676:
_L7f8f6e18_680:
	ld r0, (bp+-2)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_682
	ld r0, 0
	jmp _L7f8f6e18_683
_L7f8f6e18_682:
	ld r0, 1
_L7f8f6e18_683:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_681
	ld r0, (bp+-4)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-4)
	ld r0, (bp+-2)
	push r0
	ld r0, 10
	ld r1, r0
	pop r0
	div r0, r1
	st r0, (bp+-2)
	jmp _L7f8f6e18_680
_L7f8f6e18_681:
	ld r0, (bp+6)
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-6)
_L7f8f6e18_684:
	ld r0, (bp+-6)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_686
	ld r0, 0
	jmp _L7f8f6e18_687
_L7f8f6e18_686:
	ld r0, 1
_L7f8f6e18_687:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_685
	ld r0, 32
	push r0
	call _f_so_escreve_caractere
	add sp, 2
	ld r0, (bp+-6)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-6)
	jmp _L7f8f6e18_684
_L7f8f6e18_685:
	ld r0, (bp+4)
	push r0
	call _f_k_print_dec
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_so_imprime_relatorio:
	push bp
	ld bp, sp
	sub sp, 8
	call _f_k_nova_linha
	call _f_k_linha_igual
	ld r0, _str7f8f6e18_35
	push r0
	call _f_k_puts
	add sp, 2
	call _f_k_linha_igual
	ld r0, _str7f8f6e18_36
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_712
	ld r0, 0
	jmp _L7f8f6e18_713
_L7f8f6e18_712:
	ld r0, 1
_L7f8f6e18_713:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_714
	ld r0, _str7f8f6e18_37
	push r0
	call _f_k_puts
	add sp, 2
	jmp _L7f8f6e18_715
_L7f8f6e18_714:
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_716
	ld r0, 0
	jmp _L7f8f6e18_717
_L7f8f6e18_716:
	ld r0, 1
_L7f8f6e18_717:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_718
	ld r0, _str7f8f6e18_38
	push r0
	call _f_k_puts
	add sp, 2
	jmp _L7f8f6e18_719
_L7f8f6e18_718:
	ld r0, (_g_escalonador_tipo)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8f6e18_720
	ld r0, 0
	jmp _L7f8f6e18_721
_L7f8f6e18_720:
	ld r0, 1
_L7f8f6e18_721:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_722
	ld r0, _str7f8f6e18_39
	push r0
	call _f_k_puts
	add sp, 2
_L7f8f6e18_722:
_L7f8f6e18_719:
_L7f8f6e18_715:
	ld r0, _str7f8f6e18_40
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, (_g_quantum_config)
	push r0
	call _f_k_print_dec
	add sp, 2
	ld r0, _str7f8f6e18_41
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, (_g_quantum_config)
	push r0
	ld r0, 1000
	ld r1, r0
	pop r0
	mul r0, r1
	push r0
	call _f_k_print_dec
	add sp, 2
	ld r0, _str7f8f6e18_42
	push r0
	call _f_k_puts
	add sp, 2
	call _f_k_linha_traco
	ld r0, _str7f8f6e18_43
	push r0
	call _f_k_puts
	add sp, 2
	ld r0, _str7f8f6e18_44
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, (_g_metricas)
	push r0
	call _f_k_print_dec
	add sp, 2
	call _f_k_nova_linha
	ld r0, _str7f8f6e18_45
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, (_g_metricas+2)
	push r0
	call _f_k_print_dec
	add sp, 2
	ld r0, _str7f8f6e18_46
	push r0
	call _f_k_puts
	add sp, 2
	ld r0, _str7f8f6e18_47
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, (_g_metricas+4)
	push r0
	call _f_k_print_dec
	add sp, 2
	ld r0, _str7f8f6e18_48
	push r0
	call _f_k_puts
	add sp, 2
	ld r0, _str7f8f6e18_49
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, (_g_metricas+6)
	push r0
	call _f_k_print_dec
	add sp, 2
	call _f_k_nova_linha
	call _f_k_linha_traco
	ld r0, _str7f8f6e18_50
	push r0
	call _f_k_puts
	add sp, 2
	ld r0, _str7f8f6e18_51
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, _g_metricas+8
	push r0
	ld r0, 0
	mul r0, 2
	pop r1
	add r1, r0
	ld r0, (r1)
	push r0
	call _f_k_print_dec
	add sp, 2
	call _f_k_nova_linha
	ld r0, _str7f8f6e18_52
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, _g_metricas+8
	push r0
	ld r0, 7
	mul r0, 2
	pop r1
	add r1, r0
	ld r0, (r1)
	push r0
	call _f_k_print_dec
	add sp, 2
	call _f_k_nova_linha
	ld r0, _str7f8f6e18_53
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, _g_metricas+8
	push r0
	ld r0, 8
	mul r0, 2
	pop r1
	add r1, r0
	ld r0, (r1)
	push r0
	call _f_k_print_dec
	add sp, 2
	call _f_k_nova_linha
	ld r0, _str7f8f6e18_54
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, _g_metricas+8
	push r0
	ld r0, 10
	mul r0, 2
	pop r1
	add r1, r0
	ld r0, (r1)
	push r0
	call _f_k_print_dec
	add sp, 2
	call _f_k_nova_linha
	call _f_k_linha_traco
	ld r0, _str7f8f6e18_55
	push r0
	call _f_k_puts
	add sp, 2
	ld r0, _str7f8f6e18_56
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, _str7f8f6e18_57
	push r0
	call _f_k_puts
	add sp, 2
	ld r0, _str7f8f6e18_58
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, _str7f8f6e18_59
	push r0
	call _f_k_puts
	add sp, 2
	ld r0, 0
	st r0, (bp+-2)
_L7f8f6e18_723:
	ld r0, (bp+-2)
	push r0
	ld r0, 8
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_725
	ld r0, 0
	jmp _L7f8f6e18_726
_L7f8f6e18_725:
	ld r0, 1
_L7f8f6e18_726:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_724
	ld r0, _g_tab_processos
	push r0
	ld r0, (bp+-2)
	mul r0, 68
	pop r1
	add r1, r0
	ld r0, r1
	st r0, (bp+-4)
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_727
	ld r0, 0
	jmp _L7f8f6e18_728
_L7f8f6e18_727:
	ld r0, 1
_L7f8f6e18_728:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_729
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+44)
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+42)
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-6)
	ld r0, (bp+-6)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8f6e18_730
	ld r0, 0
	jmp _L7f8f6e18_731
_L7f8f6e18_730:
	ld r0, 1
_L7f8f6e18_731:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_732
	ld r0, (_g_tempo_sistema)
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+42)
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-6)
_L7f8f6e18_732:
	ld r0, 0
	st r0, (bp+-8)
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+66)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8f6e18_733
	ld r0, 0
	jmp _L7f8f6e18_734
_L7f8f6e18_733:
	ld r0, 1
_L7f8f6e18_734:
	cmp r0, 0
	jmpc eq, _L7f8f6e18_735
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+64)
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+66)
	ld r1, r0
	pop r0
	div r0, r1
	st r0, (bp+-8)
_L7f8f6e18_735:
	ld r0, 32
	push r0
	call _f_so_escreve_caractere
	add sp, 2
	ld r0, 2
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1)
	push r0
	call _f_k_print_campo
	add sp, 4
	ld r0, _str7f8f6e18_60
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, 7
	push r0
	ld r0, (bp+-6)
	push r0
	call _f_k_print_campo
	add sp, 4
	ld r0, _str7f8f6e18_61
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, 6
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+46)
	push r0
	call _f_k_print_campo
	add sp, 4
	ld r0, _str7f8f6e18_62
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, 4
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+48)
	push r0
	call _f_k_print_campo
	add sp, 4
	ld r0, 47
	push r0
	call _f_so_escreve_caractere
	add sp, 2
	ld r0, 7
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+54)
	push r0
	call _f_k_print_campo
	add sp, 4
	ld r0, _str7f8f6e18_63
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, 3
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+50)
	push r0
	call _f_k_print_campo
	add sp, 4
	ld r0, 47
	push r0
	call _f_so_escreve_caractere
	add sp, 2
	ld r0, 7
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+56)
	push r0
	call _f_k_print_campo
	add sp, 4
	ld r0, _str7f8f6e18_64
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, 3
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+52)
	push r0
	call _f_k_print_campo
	add sp, 4
	ld r0, 47
	push r0
	call _f_so_escreve_caractere
	add sp, 2
	ld r0, 7
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	ld r0, (r1+58)
	push r0
	call _f_k_print_campo
	add sp, 4
	ld r0, _str7f8f6e18_65
	push r0
	call _f_k_print_str
	add sp, 2
	ld r0, 7
	push r0
	ld r0, (bp+-8)
	push r0
	call _f_k_print_campo
	add sp, 4
	call _f_k_nova_linha
_L7f8f6e18_729:
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8f6e18_723
_L7f8f6e18_724:
	call _f_k_linha_igual
	ld sp, bp
	pop bp
	ret

.data
_g_tab_processos:
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
_g_pilhas_processos:
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
_g_fila_prontos:
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
_g_fila_inicio:
	.db 0
	.db 0
_g_fila_fim:
	.db 0
	.db 0
_g_fila_n:
	.db 0
	.db 0
_g_processo_atual:
	.db 0
	.db 0
_g_proximo_pid:
	.db 0
	.db 0
_g_escalonador_tipo:
	.db 0
	.db 0
_g_quantum_config:
	.db 0
	.db 0
_g_quantum_restante:
	.db 0
	.db 0
_g_tempo_sistema:
	.db 0
	.db 0
_g_metricas:
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0
	.db 0

; ----- literais de string -----
_str7f8f6e18_0:
	.db 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 0
_str7f8f6e18_1:
	.db 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 61, 0
_str7f8f6e18_2:
	.db 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 0
_str7f8f6e18_3:
	.db 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 0
_str7f8f6e18_4:
	.db 32, 32, 82, 69, 76, 65, 84, 79, 82, 73, 79, 32, 68, 69, 32, 69, 88, 69, 67, 85, 67, 65, 79, 32, 68, 79, 32, 83, 79, 0
_str7f8f6e18_5:
	.db 69, 115, 99, 97, 108, 111, 110, 97, 100, 111, 114, 58, 32, 0
_str7f8f6e18_6:
	.db 83, 73, 77, 80, 76, 69, 83, 32, 40, 67, 111, 111, 112, 101, 114, 97, 116, 105, 118, 111, 41, 0
_str7f8f6e18_7:
	.db 67, 73, 82, 67, 85, 76, 65, 82, 32, 40, 82, 111, 117, 110, 100, 45, 82, 111, 98, 105, 110, 41, 0
_str7f8f6e18_8:
	.db 80, 82, 73, 79, 82, 73, 68, 65, 68, 69, 32, 68, 73, 78, 65, 77, 73, 67, 65, 0
_str7f8f6e18_9:
	.db 81, 117, 97, 110, 116, 117, 109, 58, 32, 0
_str7f8f6e18_10:
	.db 32, 116, 105, 113, 117, 101, 115, 32, 40, 0
_str7f8f6e18_11:
	.db 32, 105, 110, 115, 116, 41, 0
_str7f8f6e18_12:
	.db 77, 69, 84, 82, 73, 67, 65, 83, 32, 71, 69, 82, 65, 73, 83, 32, 68, 79, 32, 83, 73, 83, 84, 69, 77, 65, 58, 0
_str7f8f6e18_13:
	.db 32, 32, 84, 111, 116, 97, 108, 32, 112, 114, 111, 99, 32, 99, 114, 105, 97, 100, 111, 115, 58, 32, 0
_str7f8f6e18_14:
	.db 32, 32, 84, 101, 109, 112, 111, 32, 116, 111, 116, 97, 108, 32, 101, 120, 101, 99, 58, 32, 32, 32, 0
_str7f8f6e18_15:
	.db 32, 116, 105, 113, 117, 101, 115, 32, 100, 101, 32, 114, 101, 108, 111, 103, 105, 111, 0
_str7f8f6e18_16:
	.db 32, 32, 84, 101, 109, 112, 111, 32, 111, 99, 105, 111, 115, 111, 58, 32, 32, 32, 32, 32, 32, 32, 0
_str7f8f6e18_17:
	.db 32, 116, 105, 113, 117, 101, 115, 32, 100, 101, 32, 114, 101, 108, 111, 103, 105, 111, 0
_str7f8f6e18_18:
	.db 32, 32, 84, 111, 116, 97, 108, 32, 112, 114, 101, 101, 109, 112, 99, 111, 101, 115, 58, 32, 32, 32, 0
_str7f8f6e18_19:
	.db 73, 78, 84, 69, 82, 82, 85, 80, 67, 79, 69, 83, 32, 82, 69, 67, 69, 66, 73, 68, 65, 83, 58, 0
_str7f8f6e18_20:
	.db 32, 32, 91, 48, 93, 32, 32, 66, 111, 111, 116, 58, 32, 32, 32, 32, 32, 32, 32, 32, 32, 0
_str7f8f6e18_21:
	.db 32, 32, 91, 55, 93, 32, 32, 83, 121, 115, 99, 97, 108, 108, 115, 58, 32, 32, 32, 32, 32, 0
_str7f8f6e18_22:
	.db 32, 32, 91, 56, 93, 32, 32, 67, 111, 110, 115, 111, 108, 101, 58, 32, 32, 32, 32, 32, 32, 0
_str7f8f6e18_23:
	.db 32, 32, 91, 49, 48, 93, 32, 82, 101, 108, 111, 103, 105, 111, 58, 32, 32, 32, 32, 32, 32, 0
_str7f8f6e18_24:
	.db 77, 69, 84, 82, 73, 67, 65, 83, 32, 80, 79, 82, 32, 80, 82, 79, 67, 69, 83, 83, 79, 58, 0
_str7f8f6e18_25:
	.db 80, 73, 68, 32, 124, 32, 82, 101, 116, 111, 114, 110, 111, 32, 124, 32, 80, 114, 101, 101, 109, 112, 32, 124, 32, 80, 114, 111, 110, 116, 111, 40, 118, 47, 116, 41, 32, 124, 32, 0
_str7f8f6e18_26:
	.db 66, 108, 111, 113, 40, 118, 47, 116, 41, 32, 124, 32, 69, 120, 101, 99, 40, 118, 47, 116, 41, 32, 124, 32, 82, 101, 115, 112, 46, 77, 101, 100, 0
_str7f8f6e18_27:
	.db 45, 45, 45, 45, 43, 45, 45, 45, 45, 45, 45, 45, 45, 45, 43, 45, 45, 45, 45, 45, 45, 45, 45, 43, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 43, 45, 0
_str7f8f6e18_28:
	.db 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 43, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 43, 45, 45, 45, 45, 45, 45, 45, 45, 45, 0
_str7f8f6e18_29:
	.db 32, 124, 32, 0
_str7f8f6e18_30:
	.db 32, 124, 32, 0
_str7f8f6e18_31:
	.db 32, 124, 32, 0
_str7f8f6e18_32:
	.db 32, 124, 32, 0
_str7f8f6e18_33:
	.db 32, 124, 32, 0
_str7f8f6e18_34:
	.db 32, 124, 32, 0
_str7f8f6e18_35:
	.db 32, 32, 82, 69, 76, 65, 84, 79, 82, 73, 79, 32, 68, 69, 32, 69, 88, 69, 67, 85, 67, 65, 79, 32, 68, 79, 32, 83, 79, 0
_str7f8f6e18_36:
	.db 69, 115, 99, 97, 108, 111, 110, 97, 100, 111, 114, 58, 32, 0
_str7f8f6e18_37:
	.db 83, 73, 77, 80, 76, 69, 83, 32, 40, 67, 111, 111, 112, 101, 114, 97, 116, 105, 118, 111, 41, 0
_str7f8f6e18_38:
	.db 67, 73, 82, 67, 85, 76, 65, 82, 32, 40, 82, 111, 117, 110, 100, 45, 82, 111, 98, 105, 110, 41, 0
_str7f8f6e18_39:
	.db 80, 82, 73, 79, 82, 73, 68, 65, 68, 69, 32, 68, 73, 78, 65, 77, 73, 67, 65, 0
_str7f8f6e18_40:
	.db 81, 117, 97, 110, 116, 117, 109, 58, 32, 0
_str7f8f6e18_41:
	.db 32, 116, 105, 113, 117, 101, 115, 32, 40, 0
_str7f8f6e18_42:
	.db 32, 105, 110, 115, 116, 41, 0
_str7f8f6e18_43:
	.db 77, 69, 84, 82, 73, 67, 65, 83, 32, 71, 69, 82, 65, 73, 83, 32, 68, 79, 32, 83, 73, 83, 84, 69, 77, 65, 58, 0
_str7f8f6e18_44:
	.db 32, 32, 84, 111, 116, 97, 108, 32, 112, 114, 111, 99, 32, 99, 114, 105, 97, 100, 111, 115, 58, 32, 0
_str7f8f6e18_45:
	.db 32, 32, 84, 101, 109, 112, 111, 32, 116, 111, 116, 97, 108, 32, 101, 120, 101, 99, 58, 32, 32, 32, 0
_str7f8f6e18_46:
	.db 32, 116, 105, 113, 117, 101, 115, 32, 100, 101, 32, 114, 101, 108, 111, 103, 105, 111, 0
_str7f8f6e18_47:
	.db 32, 32, 84, 101, 109, 112, 111, 32, 111, 99, 105, 111, 115, 111, 58, 32, 32, 32, 32, 32, 32, 32, 0
_str7f8f6e18_48:
	.db 32, 116, 105, 113, 117, 101, 115, 32, 100, 101, 32, 114, 101, 108, 111, 103, 105, 111, 0
_str7f8f6e18_49:
	.db 32, 32, 84, 111, 116, 97, 108, 32, 112, 114, 101, 101, 109, 112, 99, 111, 101, 115, 58, 32, 32, 32, 0
_str7f8f6e18_50:
	.db 73, 78, 84, 69, 82, 82, 85, 80, 67, 79, 69, 83, 32, 82, 69, 67, 69, 66, 73, 68, 65, 83, 58, 0
_str7f8f6e18_51:
	.db 32, 32, 91, 48, 93, 32, 32, 66, 111, 111, 116, 58, 32, 32, 32, 32, 32, 32, 32, 32, 32, 0
_str7f8f6e18_52:
	.db 32, 32, 91, 55, 93, 32, 32, 83, 121, 115, 99, 97, 108, 108, 115, 58, 32, 32, 32, 32, 32, 0
_str7f8f6e18_53:
	.db 32, 32, 91, 56, 93, 32, 32, 67, 111, 110, 115, 111, 108, 101, 58, 32, 32, 32, 32, 32, 32, 0
_str7f8f6e18_54:
	.db 32, 32, 91, 49, 48, 93, 32, 82, 101, 108, 111, 103, 105, 111, 58, 32, 32, 32, 32, 32, 32, 0
_str7f8f6e18_55:
	.db 77, 69, 84, 82, 73, 67, 65, 83, 32, 80, 79, 82, 32, 80, 82, 79, 67, 69, 83, 83, 79, 58, 0
_str7f8f6e18_56:
	.db 80, 73, 68, 32, 124, 32, 82, 101, 116, 111, 114, 110, 111, 32, 124, 32, 80, 114, 101, 101, 109, 112, 32, 124, 32, 80, 114, 111, 110, 116, 111, 40, 118, 47, 116, 41, 32, 124, 32, 0
_str7f8f6e18_57:
	.db 66, 108, 111, 113, 40, 118, 47, 116, 41, 32, 124, 32, 69, 120, 101, 99, 40, 118, 47, 116, 41, 32, 124, 32, 82, 101, 115, 112, 46, 77, 101, 100, 0
_str7f8f6e18_58:
	.db 45, 45, 45, 45, 43, 45, 45, 45, 45, 45, 45, 45, 45, 45, 43, 45, 45, 45, 45, 45, 45, 45, 45, 43, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 43, 45, 0
_str7f8f6e18_59:
	.db 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 43, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 43, 45, 45, 45, 45, 45, 45, 45, 45, 45, 0
_str7f8f6e18_60:
	.db 32, 124, 32, 0
_str7f8f6e18_61:
	.db 32, 124, 32, 0
_str7f8f6e18_62:
	.db 32, 124, 32, 0
_str7f8f6e18_63:
	.db 32, 124, 32, 0
_str7f8f6e18_64:
	.db 32, 124, 32, 0
_str7f8f6e18_65:
	.db 32, 124, 32, 0
