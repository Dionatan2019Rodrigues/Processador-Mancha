; ===== código gerado por mcc =====
.text
_f_so_print_str:
	push bp
	ld bp, sp
_L7f8e6e18_4:
	ld r0, (bp+4)
	ld r1, r0
	ldb r0, (r1)
	and r0, 255
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ne, _L7f8e6e18_6
	ld r0, 0
	jmp _L7f8e6e18_7
_L7f8e6e18_6:
	ld r0, 1
_L7f8e6e18_7:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_5
	ld r0, (bp+4)
	ld r1, r0
	ldb r0, (r1)
	and r0, 255
	push r0
	call _f_so_escreve
	add sp, 2
	ld r0, (bp+4)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+4)
	jmp _L7f8e6e18_4
_L7f8e6e18_5:
	ld sp, bp
	pop bp
	ret
_f_so_puts:
	push bp
	ld bp, sp
	ld r0, (bp+4)
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, 10
	push r0
	call _f_so_escreve
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_so_nova_linha:
	push bp
	ld bp, sp
	ld r0, 10
	push r0
	call _f_so_escreve
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_so_print_dec:
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
	jmpc lt, _L7f8e6e18_23
	ld r0, 0
	jmp _L7f8e6e18_24
_L7f8e6e18_23:
	ld r0, 1
_L7f8e6e18_24:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_25
	ld r0, 1
	st r0, (bp+-12)
	ld r0, (bp+4)
	xor r0, -1
	add r0, 1
	st r0, (bp+4)
_L7f8e6e18_25:
	ld r0, (bp+4)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8e6e18_26
	ld r0, 0
	jmp _L7f8e6e18_27
_L7f8e6e18_26:
	ld r0, 1
_L7f8e6e18_27:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_28
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
_L7f8e6e18_28:
_L7f8e6e18_29:
	ld r0, (bp+4)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8e6e18_31
	ld r0, 0
	jmp _L7f8e6e18_32
_L7f8e6e18_31:
	ld r0, 1
_L7f8e6e18_32:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_30
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
	jmp _L7f8e6e18_29
_L7f8e6e18_30:
	ld r0, (bp+-12)
	cmp r0, 0
	jmpc eq, _L7f8e6e18_33
	ld r0, 45
	push r0
	call _f_so_escreve
	add sp, 2
_L7f8e6e18_33:
_L7f8e6e18_34:
	ld r0, (bp+-10)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7f8e6e18_36
	ld r0, 0
	jmp _L7f8e6e18_37
_L7f8e6e18_36:
	ld r0, 1
_L7f8e6e18_37:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_35
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
	call _f_so_escreve
	add sp, 2
	jmp _L7f8e6e18_34
_L7f8e6e18_35:
	ld sp, bp
	pop bp
	ret
_f_atraso_curto:
	push bp
	ld bp, sp
	sub sp, 2
	ld r0, 0
	st r0, (bp+-2)
_L7f8e6e18_42:
	ld r0, (bp+-2)
	push r0
	ld r0, 300
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8e6e18_44
	ld r0, 0
	jmp _L7f8e6e18_45
_L7f8e6e18_44:
	ld r0, 1
_L7f8e6e18_45:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_43
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8e6e18_42
_L7f8e6e18_43:
	ld sp, bp
	pop bp
	ret
_f_atraso_medio:
	push bp
	ld bp, sp
	sub sp, 2
	ld r0, 0
	st r0, (bp+-2)
_L7f8e6e18_50:
	ld r0, (bp+-2)
	push r0
	ld r0, 800
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8e6e18_52
	ld r0, 0
	jmp _L7f8e6e18_53
_L7f8e6e18_52:
	ld r0, 1
_L7f8e6e18_53:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_51
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8e6e18_50
_L7f8e6e18_51:
	ld sp, bp
	pop bp
	ret
_f_proc_computacao_a:
	push bp
	ld bp, sp
	sub sp, 2
	ld r0, _str7f8e6e18_4
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, 0
	st r0, (bp+-2)
_L7f8e6e18_58:
	ld r0, (bp+-2)
	push r0
	ld r0, 5
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8e6e18_60
	ld r0, 0
	jmp _L7f8e6e18_61
_L7f8e6e18_60:
	ld r0, 1
_L7f8e6e18_61:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_59
	ld r0, _str7f8e6e18_5
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-2)
	push r0
	call _f_so_print_dec
	add sp, 2
	ld r0, _str7f8e6e18_6
	push r0
	call _f_so_print_str
	add sp, 2
	call _f_atraso_medio
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8e6e18_58
_L7f8e6e18_59:
	call _f_so_nova_linha
	ld r0, _str7f8e6e18_7
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, 0
	push r0
	call _f_so_mata_proc
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_proc_computacao_b:
	push bp
	ld bp, sp
	sub sp, 2
	ld r0, _str7f8e6e18_12
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, 0
	st r0, (bp+-2)
_L7f8e6e18_66:
	ld r0, (bp+-2)
	push r0
	ld r0, 5
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc lt, _L7f8e6e18_68
	ld r0, 0
	jmp _L7f8e6e18_69
_L7f8e6e18_68:
	ld r0, 1
_L7f8e6e18_69:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_67
	ld r0, _str7f8e6e18_13
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-2)
	push r0
	call _f_so_print_dec
	add sp, 2
	ld r0, _str7f8e6e18_14
	push r0
	call _f_so_print_str
	add sp, 2
	call _f_atraso_curto
	ld r0, (bp+-2)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+-2)
	jmp _L7f8e6e18_66
_L7f8e6e18_67:
	call _f_so_nova_linha
	ld r0, _str7f8e6e18_15
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, 0
	push r0
	call _f_so_mata_proc
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_proc_io:
	push bp
	ld bp, sp
	sub sp, 2
	ld r0, _str7f8e6e18_19
	push r0
	call _f_so_puts
	add sp, 2
	call _f_so_le
	st r0, (bp+-2)
	ld r0, _str7f8e6e18_20
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-2)
	push r0
	call _f_so_escreve
	add sp, 2
	ld r0, _str7f8e6e18_21
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, 0
	push r0
	call _f_so_mata_proc
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_proc_init:
	push bp
	ld bp, sp
	sub sp, 8
	call _f_so_nova_linha
	ld r0, _str7f8e6e18_48
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, _str7f8e6e18_49
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, _str7f8e6e18_50
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, _str7f8e6e18_51
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, _str7f8e6e18_52
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, _f_proc_computacao_a
	push r0
	call _f_so_cria_proc
	add sp, 2
	st r0, (bp+-2)
	ld r0, _str7f8e6e18_53
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-2)
	push r0
	call _f_so_print_dec
	add sp, 2
	call _f_so_nova_linha
	ld r0, _str7f8e6e18_54
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, _f_proc_computacao_b
	push r0
	call _f_so_cria_proc
	add sp, 2
	st r0, (bp+-4)
	ld r0, _str7f8e6e18_55
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-4)
	push r0
	call _f_so_print_dec
	add sp, 2
	call _f_so_nova_linha
	ld r0, _str7f8e6e18_56
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, _f_proc_io
	push r0
	call _f_so_cria_proc
	add sp, 2
	st r0, (bp+-6)
	ld r0, _str7f8e6e18_57
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-6)
	push r0
	call _f_so_print_dec
	add sp, 2
	call _f_so_nova_linha
	ld r0, _str7f8e6e18_58
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-2)
	push r0
	call _f_so_print_dec
	add sp, 2
	ld r0, _str7f8e6e18_59
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, (bp+-2)
	push r0
	call _f_so_espera_proc
	add sp, 2
	st r0, (bp+-8)
	ld r0, _str7f8e6e18_60
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-2)
	push r0
	call _f_so_print_dec
	add sp, 2
	ld r0, _str7f8e6e18_61
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, _str7f8e6e18_62
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-4)
	push r0
	call _f_so_print_dec
	add sp, 2
	ld r0, _str7f8e6e18_63
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, (bp+-4)
	push r0
	call _f_so_espera_proc
	add sp, 2
	st r0, (bp+-8)
	ld r0, _str7f8e6e18_64
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-4)
	push r0
	call _f_so_print_dec
	add sp, 2
	ld r0, _str7f8e6e18_65
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, _str7f8e6e18_66
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-6)
	push r0
	call _f_so_print_dec
	add sp, 2
	ld r0, _str7f8e6e18_67
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, (bp+-6)
	push r0
	call _f_so_espera_proc
	add sp, 2
	st r0, (bp+-8)
	ld r0, _str7f8e6e18_68
	push r0
	call _f_so_print_str
	add sp, 2
	ld r0, (bp+-6)
	push r0
	call _f_so_print_dec
	add sp, 2
	ld r0, _str7f8e6e18_69
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, 1
	push r0
	call _f_so_espera_proc
	add sp, 2
	st r0, (bp+-8)
	ld r0, (bp+-8)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8e6e18_76
	ld r0, 0
	jmp _L7f8e6e18_77
_L7f8e6e18_76:
	ld r0, 1
_L7f8e6e18_77:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_78
	ld r0, _str7f8e6e18_70
	push r0
	call _f_so_puts
	add sp, 2
_L7f8e6e18_78:
	ld r0, 99
	push r0
	call _f_so_espera_proc
	add sp, 2
	st r0, (bp+-8)
	ld r0, (bp+-8)
	push r0
	ld r0, 1
	xor r0, -1
	add r0, 1
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7f8e6e18_79
	ld r0, 0
	jmp _L7f8e6e18_80
_L7f8e6e18_79:
	ld r0, 1
_L7f8e6e18_80:
	cmp r0, 0
	jmpc eq, _L7f8e6e18_81
	ld r0, _str7f8e6e18_71
	push r0
	call _f_so_puts
	add sp, 2
_L7f8e6e18_81:
	ld r0, _str7f8e6e18_72
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, _str7f8e6e18_73
	push r0
	call _f_so_puts
	add sp, 2
	ld r0, 0
	push r0
	call _f_so_mata_proc
	add sp, 2
	ld sp, bp
	pop bp
	ret

.data

; ----- literais de string -----
_str7f8e6e18_0:
	.db 91, 80, 82, 79, 67, 32, 65, 93, 32, 73, 110, 105, 99, 105, 97, 100, 111, 32, 40, 116, 97, 114, 101, 102, 97, 32, 99, 111, 109, 112, 117, 116, 97, 99, 105, 111, 110, 97, 108, 41, 0
_str7f8e6e18_1:
	.db 91, 65, 58, 0
_str7f8e6e18_2:
	.db 93, 32, 0
_str7f8e6e18_3:
	.db 91, 80, 82, 79, 67, 32, 65, 93, 32, 67, 111, 110, 99, 108, 117, 105, 100, 111, 32, 99, 111, 109, 32, 115, 117, 99, 101, 115, 115, 111, 0
_str7f8e6e18_4:
	.db 91, 80, 82, 79, 67, 32, 65, 93, 32, 73, 110, 105, 99, 105, 97, 100, 111, 32, 40, 116, 97, 114, 101, 102, 97, 32, 99, 111, 109, 112, 117, 116, 97, 99, 105, 111, 110, 97, 108, 41, 0
_str7f8e6e18_5:
	.db 91, 65, 58, 0
_str7f8e6e18_6:
	.db 93, 32, 0
_str7f8e6e18_7:
	.db 91, 80, 82, 79, 67, 32, 65, 93, 32, 67, 111, 110, 99, 108, 117, 105, 100, 111, 32, 99, 111, 109, 32, 115, 117, 99, 101, 115, 115, 111, 0
_str7f8e6e18_8:
	.db 91, 80, 82, 79, 67, 32, 66, 93, 32, 73, 110, 105, 99, 105, 97, 100, 111, 32, 40, 116, 97, 114, 101, 102, 97, 32, 109, 105, 115, 116, 97, 41, 0
_str7f8e6e18_9:
	.db 91, 66, 58, 0
_str7f8e6e18_10:
	.db 93, 32, 0
_str7f8e6e18_11:
	.db 91, 80, 82, 79, 67, 32, 66, 93, 32, 67, 111, 110, 99, 108, 117, 105, 100, 111, 32, 99, 111, 109, 32, 115, 117, 99, 101, 115, 115, 111, 0
_str7f8e6e18_12:
	.db 91, 80, 82, 79, 67, 32, 66, 93, 32, 73, 110, 105, 99, 105, 97, 100, 111, 32, 40, 116, 97, 114, 101, 102, 97, 32, 109, 105, 115, 116, 97, 41, 0
_str7f8e6e18_13:
	.db 91, 66, 58, 0
_str7f8e6e18_14:
	.db 93, 32, 0
_str7f8e6e18_15:
	.db 91, 80, 82, 79, 67, 32, 66, 93, 32, 67, 111, 110, 99, 108, 117, 105, 100, 111, 32, 99, 111, 109, 32, 115, 117, 99, 101, 115, 115, 111, 0
_str7f8e6e18_16:
	.db 91, 80, 82, 79, 67, 32, 73, 79, 93, 32, 73, 110, 105, 99, 105, 97, 100, 111, 32, 40, 83, 79, 95, 76, 69, 41, 0
_str7f8e6e18_17:
	.db 91, 80, 82, 79, 67, 32, 73, 79, 93, 32, 67, 97, 114, 97, 99, 116, 101, 114, 101, 58, 32, 39, 0
_str7f8e6e18_18:
	.db 39, 0
_str7f8e6e18_19:
	.db 91, 80, 82, 79, 67, 32, 73, 79, 93, 32, 73, 110, 105, 99, 105, 97, 100, 111, 32, 40, 83, 79, 95, 76, 69, 41, 0
_str7f8e6e18_20:
	.db 91, 80, 82, 79, 67, 32, 73, 79, 93, 32, 67, 97, 114, 97, 99, 116, 101, 114, 101, 58, 32, 39, 0
_str7f8e6e18_21:
	.db 39, 0
_str7f8e6e18_22:
	.db 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 0
_str7f8e6e18_23:
	.db 91, 73, 78, 73, 84, 93, 32, 73, 110, 105, 99, 105, 97, 108, 105, 122, 97, 110, 100, 111, 32, 83, 79, 32, 77, 97, 110, 99, 104, 97, 0
_str7f8e6e18_24:
	.db 91, 73, 78, 73, 84, 93, 32, 77, 111, 100, 111, 32, 117, 115, 117, 97, 114, 105, 111, 32, 40, 83, 61, 48, 44, 32, 73, 61, 48, 41, 0
_str7f8e6e18_25:
	.db 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 0
_str7f8e6e18_26:
	.db 91, 73, 78, 73, 84, 93, 32, 67, 114, 105, 97, 110, 100, 111, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 65, 46, 46, 46, 0
_str7f8e6e18_27:
	.db 91, 73, 78, 73, 84, 93, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 65, 32, 80, 73, 68, 58, 32, 0
_str7f8e6e18_28:
	.db 91, 73, 78, 73, 84, 93, 32, 67, 114, 105, 97, 110, 100, 111, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 66, 46, 46, 46, 0
_str7f8e6e18_29:
	.db 91, 73, 78, 73, 84, 93, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 66, 32, 80, 73, 68, 58, 32, 0
_str7f8e6e18_30:
	.db 91, 73, 78, 73, 84, 93, 32, 67, 114, 105, 97, 110, 100, 111, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 73, 79, 46, 46, 46, 0
_str7f8e6e18_31:
	.db 91, 73, 78, 73, 84, 93, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 73, 79, 32, 80, 73, 68, 58, 32, 0
_str7f8e6e18_32:
	.db 91, 73, 78, 73, 84, 93, 32, 69, 115, 112, 101, 114, 97, 110, 100, 111, 32, 80, 73, 68, 32, 0
_str7f8e6e18_33:
	.db 46, 46, 46, 0
_str7f8e6e18_34:
	.db 91, 73, 78, 73, 84, 93, 32, 82, 101, 116, 111, 109, 97, 100, 111, 33, 32, 80, 73, 68, 32, 0
_str7f8e6e18_35:
	.db 32, 97, 99, 97, 98, 111, 117, 46, 0
_str7f8e6e18_36:
	.db 91, 73, 78, 73, 84, 93, 32, 69, 115, 112, 101, 114, 97, 110, 100, 111, 32, 80, 73, 68, 32, 0
_str7f8e6e18_37:
	.db 46, 46, 46, 0
_str7f8e6e18_38:
	.db 91, 73, 78, 73, 84, 93, 32, 82, 101, 116, 111, 109, 97, 100, 111, 33, 32, 80, 73, 68, 32, 0
_str7f8e6e18_39:
	.db 32, 97, 99, 97, 98, 111, 117, 46, 0
_str7f8e6e18_40:
	.db 91, 73, 78, 73, 84, 93, 32, 69, 115, 112, 101, 114, 97, 110, 100, 111, 32, 80, 73, 68, 32, 0
_str7f8e6e18_41:
	.db 46, 46, 46, 0
_str7f8e6e18_42:
	.db 91, 73, 78, 73, 84, 93, 32, 82, 101, 116, 111, 109, 97, 100, 111, 33, 32, 80, 73, 68, 32, 0
_str7f8e6e18_43:
	.db 32, 97, 99, 97, 98, 111, 117, 46, 0
_str7f8e6e18_44:
	.db 91, 73, 78, 73, 84, 93, 32, 69, 115, 112, 101, 114, 97, 32, 115, 101, 108, 102, 58, 32, 101, 114, 114, 111, 32, 45, 49, 32, 40, 79, 75, 41, 0
_str7f8e6e18_45:
	.db 91, 73, 78, 73, 84, 93, 32, 69, 115, 112, 101, 114, 97, 32, 105, 110, 101, 120, 105, 115, 116, 58, 32, 101, 114, 114, 111, 32, 45, 49, 32, 40, 79, 75, 41, 0
_str7f8e6e18_46:
	.db 91, 73, 78, 73, 84, 93, 32, 70, 105, 108, 104, 111, 115, 32, 99, 111, 110, 99, 108, 117, 105, 100, 111, 115, 46, 0
_str7f8e6e18_47:
	.db 91, 73, 78, 73, 84, 93, 32, 70, 105, 110, 97, 108, 105, 122, 97, 110, 100, 111, 32, 105, 110, 105, 116, 46, 46, 46, 0
_str7f8e6e18_48:
	.db 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 0
_str7f8e6e18_49:
	.db 91, 73, 78, 73, 84, 93, 32, 73, 110, 105, 99, 105, 97, 108, 105, 122, 97, 110, 100, 111, 32, 83, 79, 32, 77, 97, 110, 99, 104, 97, 0
_str7f8e6e18_50:
	.db 91, 73, 78, 73, 84, 93, 32, 77, 111, 100, 111, 32, 117, 115, 117, 97, 114, 105, 111, 32, 40, 83, 61, 48, 44, 32, 73, 61, 48, 41, 0
_str7f8e6e18_51:
	.db 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 0
_str7f8e6e18_52:
	.db 91, 73, 78, 73, 84, 93, 32, 67, 114, 105, 97, 110, 100, 111, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 65, 46, 46, 46, 0
_str7f8e6e18_53:
	.db 91, 73, 78, 73, 84, 93, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 65, 32, 80, 73, 68, 58, 32, 0
_str7f8e6e18_54:
	.db 91, 73, 78, 73, 84, 93, 32, 67, 114, 105, 97, 110, 100, 111, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 66, 46, 46, 46, 0
_str7f8e6e18_55:
	.db 91, 73, 78, 73, 84, 93, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 66, 32, 80, 73, 68, 58, 32, 0
_str7f8e6e18_56:
	.db 91, 73, 78, 73, 84, 93, 32, 67, 114, 105, 97, 110, 100, 111, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 73, 79, 46, 46, 46, 0
_str7f8e6e18_57:
	.db 91, 73, 78, 73, 84, 93, 32, 80, 114, 111, 99, 101, 115, 115, 111, 32, 73, 79, 32, 80, 73, 68, 58, 32, 0
_str7f8e6e18_58:
	.db 91, 73, 78, 73, 84, 93, 32, 69, 115, 112, 101, 114, 97, 110, 100, 111, 32, 80, 73, 68, 32, 0
_str7f8e6e18_59:
	.db 46, 46, 46, 0
_str7f8e6e18_60:
	.db 91, 73, 78, 73, 84, 93, 32, 82, 101, 116, 111, 109, 97, 100, 111, 33, 32, 80, 73, 68, 32, 0
_str7f8e6e18_61:
	.db 32, 97, 99, 97, 98, 111, 117, 46, 0
_str7f8e6e18_62:
	.db 91, 73, 78, 73, 84, 93, 32, 69, 115, 112, 101, 114, 97, 110, 100, 111, 32, 80, 73, 68, 32, 0
_str7f8e6e18_63:
	.db 46, 46, 46, 0
_str7f8e6e18_64:
	.db 91, 73, 78, 73, 84, 93, 32, 82, 101, 116, 111, 109, 97, 100, 111, 33, 32, 80, 73, 68, 32, 0
_str7f8e6e18_65:
	.db 32, 97, 99, 97, 98, 111, 117, 46, 0
_str7f8e6e18_66:
	.db 91, 73, 78, 73, 84, 93, 32, 69, 115, 112, 101, 114, 97, 110, 100, 111, 32, 80, 73, 68, 32, 0
_str7f8e6e18_67:
	.db 46, 46, 46, 0
_str7f8e6e18_68:
	.db 91, 73, 78, 73, 84, 93, 32, 82, 101, 116, 111, 109, 97, 100, 111, 33, 32, 80, 73, 68, 32, 0
_str7f8e6e18_69:
	.db 32, 97, 99, 97, 98, 111, 117, 46, 0
_str7f8e6e18_70:
	.db 91, 73, 78, 73, 84, 93, 32, 69, 115, 112, 101, 114, 97, 32, 115, 101, 108, 102, 58, 32, 101, 114, 114, 111, 32, 45, 49, 32, 40, 79, 75, 41, 0
_str7f8e6e18_71:
	.db 91, 73, 78, 73, 84, 93, 32, 69, 115, 112, 101, 114, 97, 32, 105, 110, 101, 120, 105, 115, 116, 58, 32, 101, 114, 114, 111, 32, 45, 49, 32, 40, 79, 75, 41, 0
_str7f8e6e18_72:
	.db 91, 73, 78, 73, 84, 93, 32, 70, 105, 108, 104, 111, 115, 32, 99, 111, 110, 99, 108, 117, 105, 100, 111, 115, 46, 0
_str7f8e6e18_73:
	.db 91, 73, 78, 73, 84, 93, 32, 70, 105, 110, 97, 108, 105, 122, 97, 110, 100, 111, 32, 105, 110, 105, 116, 46, 46, 46, 0
