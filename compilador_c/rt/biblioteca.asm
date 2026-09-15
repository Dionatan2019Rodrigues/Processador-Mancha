; ===== código gerado por mcc =====
.text
_f_putchar:
	push bp
	ld bp, sp
	ld r0, (bp+4)
	push r0
	ld r0, 1
	push r0
	call _f_mancha_out
	add sp, 4
	ld r0, (bp+4)
	ld sp, bp
	pop bp
	ret
	ld sp, bp
	pop bp
	ret
_f_getchar:
	push bp
	ld bp, sp
	sub sp, 2
	ld r0, 2
	push r0
	call _f_mancha_in
	add sp, 2
	st r0, (bp+-2)
_L7612a8e7_4:
	ld r0, (bp+-2)
	push r0
	ld r0, 2
	ld r1, r0
	pop r0
	and r0, r1
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7612a8e7_6
	ld r0, 0
	jmp _L7612a8e7_7
_L7612a8e7_6:
	ld r0, 1
_L7612a8e7_7:
	cmp r0, 0
	jmpc eq, _L7612a8e7_5
	ld r0, 2
	push r0
	call _f_mancha_in
	add sp, 2
	st r0, (bp+-2)
	jmp _L7612a8e7_4
_L7612a8e7_5:
	ld r0, 1
	push r0
	call _f_mancha_in
	add sp, 2
	ld sp, bp
	pop bp
	ret
	ld sp, bp
	pop bp
	ret
_f_puts:
	push bp
	ld bp, sp
_L7612a8e7_12:
	ld r0, (bp+4)
	ld r1, r0
	ldb r0, (r1)
	and r0, 255
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ne, _L7612a8e7_14
	ld r0, 0
	jmp _L7612a8e7_15
_L7612a8e7_14:
	ld r0, 1
_L7612a8e7_15:
	cmp r0, 0
	jmpc eq, _L7612a8e7_13
	ld r0, (bp+4)
	ld r1, r0
	ldb r0, (r1)
	and r0, 255
	push r0
	call _f_putchar
	add sp, 2
	ld r0, (bp+4)
	push r0
	ld r0, 1
	ld r1, r0
	pop r0
	add r0, r1
	st r0, (bp+4)
	jmp _L7612a8e7_12
_L7612a8e7_13:
	ld r0, 10
	push r0
	call _f_putchar
	add sp, 2
	ld sp, bp
	pop bp
	ret
_f_print_int:
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
	jmpc lt, _L7612a8e7_31
	ld r0, 0
	jmp _L7612a8e7_32
_L7612a8e7_31:
	ld r0, 1
_L7612a8e7_32:
	cmp r0, 0
	jmpc eq, _L7612a8e7_33
	ld r0, 1
	st r0, (bp+-12)
	ld r0, (bp+4)
	xor r0, -1
	add r0, 1
	st r0, (bp+4)
_L7612a8e7_33:
	ld r0, (bp+4)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc eq, _L7612a8e7_34
	ld r0, 0
	jmp _L7612a8e7_35
_L7612a8e7_34:
	ld r0, 1
_L7612a8e7_35:
	cmp r0, 0
	jmpc eq, _L7612a8e7_36
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
_L7612a8e7_36:
_L7612a8e7_37:
	ld r0, (bp+4)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7612a8e7_39
	ld r0, 0
	jmp _L7612a8e7_40
_L7612a8e7_39:
	ld r0, 1
_L7612a8e7_40:
	cmp r0, 0
	jmpc eq, _L7612a8e7_38
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
	jmp _L7612a8e7_37
_L7612a8e7_38:
	ld r0, (bp+-12)
	cmp r0, 0
	jmpc eq, _L7612a8e7_41
	ld r0, 45
	push r0
	call _f_putchar
	add sp, 2
_L7612a8e7_41:
_L7612a8e7_42:
	ld r0, (bp+-10)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc gt, _L7612a8e7_44
	ld r0, 0
	jmp _L7612a8e7_45
_L7612a8e7_44:
	ld r0, 1
_L7612a8e7_45:
	cmp r0, 0
	jmpc eq, _L7612a8e7_43
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
	call _f_putchar
	add sp, 2
	jmp _L7612a8e7_42
_L7612a8e7_43:
	ld sp, bp
	pop bp
	ret
_f_print_hex:
	push bp
	ld bp, sp
	sub sp, 6
	ld r0, _str7612a8e7_1
	st r0, (bp+-2)
	ld r0, 12
	st r0, (bp+-4)
_L7612a8e7_50:
	ld r0, (bp+-4)
	push r0
	ld r0, 0
	ld r1, r0
	pop r0
	cmp r0, r1
	jmpc ge, _L7612a8e7_52
	ld r0, 0
	jmp _L7612a8e7_53
_L7612a8e7_52:
	ld r0, 1
_L7612a8e7_53:
	cmp r0, 0
	jmpc eq, _L7612a8e7_51
	ld r0, (bp+4)
	push r0
	ld r0, (bp+-4)
	ld r1, r0
	pop r0
	shr r0, r1
	push r0
	ld r0, 15
	ld r1, r0
	pop r0
	and r0, r1
	st r0, (bp+-6)
	ld r0, (bp+-2)
	push r0
	ld r0, (bp+-6)
	mul r0, 1
	pop r1
	add r1, r0
	ldb r0, (r1)
	and r0, 255
	push r0
	call _f_putchar
	add sp, 2
	ld r0, (bp+-4)
	push r0
	ld r0, 4
	ld r1, r0
	pop r0
	sub r0, r1
	st r0, (bp+-4)
	jmp _L7612a8e7_50
_L7612a8e7_51:
	ld sp, bp
	pop bp
	ret

.data

; ----- literais de string -----
_str7612a8e7_0:
	.db 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70, 0
_str7612a8e7_1:
	.db 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70, 0
