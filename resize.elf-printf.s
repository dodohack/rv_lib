	.file	"printf.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_f2p2_d2p2_v1p0_zicsr2p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"0123456789ABCDEF"
	.align	2
.LC1:
	.string	"0123456789abcdef"
	.text
	.align	2
	.type	outnum, @function
outnum:
	addi	sp,sp,-80
	lui	a3,%hi(.LC0)
	li	a5,17
	addi	a4,sp,8
	addi	a3,a3,%lo(.LC0)
.L2:
	vsetvli	a6,a5,e8,m1,ta,mu
	vle8.v	v24,(a3)
	sub	a5,a5,a6
	vse8.v	v24,(a4)
	add	a3,a3,a6
	add	a4,a4,a6
	bne	a5,zero,.L2
	lui	a6,%hi(.LC1)
	li	a5,17
	addi	a4,sp,28
	addi	a6,a6,%lo(.LC1)
.L3:
	vsetvli	a3,a5,e8,m1,ta,mu
	vle8.v	v24,(a6)
	sub	a5,a5,a3
	vse8.v	v24,(a4)
	add	a6,a6,a3
	add	a4,a4,a3
	bne	a5,zero,.L3
	li	a5,10
	lw	t1,24(a2)
	beq	a1,a5,.L58
	addi	a3,sp,8
	beq	t1,zero,.L59
.L7:
	addi	a6,sp,48
	mv	a5,a6
	li	t1,15
.L10:
	andi	a4,a0,15
	add	a4,a3,a4
	lbu	a7,0(a4)
	mv	a1,a0
	mv	a4,a5
	sb	a7,0(a5)
	srli	a0,a0,4
	addi	a5,a5,1
	bgtu	a1,t1,.L10
.L11:
	sb	zero,0(a5)
	lbu	a5,48(sp)
	beq	a5,zero,.L37
.L64:
	mv	a5,a6
.L13:
	lbu	a3,1(a5)
	addi	a5,a5,1
	bne	a3,zero,.L13
	sub	a5,a5,a6
.L12:
	lw	a3,16(a2)
	sw	a5,0(a2)
	lw	a1,20(a2)
	beq	a3,zero,.L14
	bne	a1,zero,.L15
	lw	a3,4(a2)
	blt	a5,a3,.L16
.L14:
	bltu	a4,a6,.L1
.L18:
	mv	a5,a4
	li	a0,10
	li	a7,-799539200
	li	t1,13
.L21:
	lw	a1,28(a2)
	sub	a3,a4,a5
	addi	a5,a5,-1
	ble	a1,a3,.L27
	lbu	a3,1(a5)
	beq	a3,a0,.L60
	sw	a3,0(a7)
	bgeu	a5,a6,.L21
.L27:
	lw	a5,16(a2)
	beq	a5,zero,.L1
	lw	a5,20(a2)
	beq	a5,zero,.L1
	lw	a5,0(a2)
.L32:
	lw	a4,4(a2)
	ble	a4,a5,.L1
	lbu	a3,12(a2)
	li	a2,10
	beq	a3,a2,.L61
	li	a2,-799539200
.L30:
	sw	a3,0(a2)
	addi	a5,a5,1
	bne	a4,a5,.L30
.L1:
	addi	sp,sp,80
	jr	ra
.L60:
	sw	t1,0(a7)
	sw	a0,0(a7)
	bgeu	a5,a6,.L21
	j	.L27
.L59:
	addi	a3,sp,28
	j	.L7
.L15:
	bgeu	a4,a6,.L18
	j	.L32
.L58:
	blt	a0,zero,.L62
	addi	a5,sp,28
	bne	t1,zero,.L63
.L6:
	addi	a6,sp,48
	mv	a4,a6
	li	a1,10
	li	t4,9
.L8:
	remu	a3,a0,a1
	mv	t3,a4
	addi	a4,a4,1
	mv	a7,a0
	add	a3,a5,a3
	lbu	a3,0(a3)
	divu	a0,a0,a1
	sb	a3,-1(a4)
	bgtu	a7,t4,.L8
	beq	t1,zero,.L36
	li	a3,45
	addi	a5,t3,2
	sb	a3,0(a4)
	sb	zero,0(a5)
	lbu	a5,48(sp)
	bne	a5,zero,.L64
.L37:
	li	a5,0
	j	.L12
.L16:
	lbu	a1,12(a2)
	li	a0,10
	beq	a1,a0,.L65
	li	a0,-799539200
.L23:
	sw	a1,0(a0)
	addi	a5,a5,1
	bne	a3,a5,.L23
	bgeu	a4,a6,.L18
	j	.L27
.L63:
	addi	a5,sp,8
	li	t1,0
	j	.L6
.L62:
	neg	a0,a0
	beq	t1,zero,.L33
	addi	a5,sp,8
	li	t1,1
	j	.L6
.L33:
	addi	a5,sp,28
	li	t1,1
	j	.L6
.L65:
	li	a1,-799539200
	li	a7,13
.L22:
	sw	a7,0(a1)
	sw	a0,0(a1)
	addi	a5,a5,1
	bne	a3,a5,.L22
	bgeu	a4,a6,.L18
	j	.L27
.L61:
	li	a3,-799539200
	li	a1,13
.L29:
	sw	a1,0(a3)
	sw	a2,0(a3)
	addi	a5,a5,1
	bne	a4,a5,.L29
	j	.L1
.L36:
	mv	a5,a4
	mv	a4,t3
	j	.L11
	.size	outnum, .-outnum
	.align	2
	.globl	strlen
	.type	strlen, @function
strlen:
	beq	a0,zero,.L70
	lbu	a5,0(a0)
	beq	a5,zero,.L70
	mv	a5,a0
.L69:
	lbu	a4,1(a5)
	addi	a5,a5,1
	bne	a4,zero,.L69
	sub	a0,a5,a0
	ret
.L70:
	li	a0,0
	ret
	.size	strlen, .-strlen
	.align	2
	.globl	uart_putchar
	.type	uart_putchar, @function
uart_putchar:
	li	a5,10
	beq	a0,a5,.L75
	li	a5,-799539200
	sw	a0,0(a5)
	li	a0,0
	ret
.L75:
	li	a5,-799539200
	li	a4,13
	sw	a4,0(a5)
	li	a5,-799539200
	sw	a0,0(a5)
	li	a0,0
	ret
	.size	uart_putchar, .-uart_putchar
	.align	2
	.globl	puts
	.type	puts, @function
puts:
	lbu	a5,0(a0)
	beq	a5,zero,.L77
	li	a3,10
	li	a4,-799539200
	li	a2,13
.L80:
	addi	a0,a0,1
	beq	a5,a3,.L87
	sw	a5,0(a4)
	lbu	a5,0(a0)
	bne	a5,zero,.L80
.L77:
	li	a5,-799539200
	li	a4,13
	sw	a4,0(a5)
	li	a4,10
	sw	a4,0(a5)
	li	a0,0
	ret
.L87:
	sw	a2,0(a4)
	sw	a5,0(a4)
	lbu	a5,0(a0)
	bne	a5,zero,.L80
	li	a5,-799539200
	li	a4,13
	sw	a4,0(a5)
	li	a4,10
	sw	a4,0(a5)
	li	a0,0
	ret
	.size	puts, .-puts
	.align	2
	.globl	putchar
	.type	putchar, @function
putchar:
	andi	a4,a0,0xff
	li	a5,10
	beq	a4,a5,.L90
	andi	a4,a0,255
	li	a5,-799539200
	sw	a4,0(a5)
	ret
.L90:
	li	a5,-799539200
	li	a4,13
	sw	a4,0(a5)
	andi	a4,a0,255
	li	a5,-799539200
	sw	a4,0(a5)
	ret
	.size	putchar, .-putchar
	.align	2
	.globl	uart_printf
	.type	uart_printf, @function
uart_printf:
	lbu	a5,0(a0)
	beq	a5,zero,.L182
	addi	sp,sp,-64
	sw	s0,56(sp)
	sw	s2,48(sp)
	sw	s3,44(sp)
	li	s0,32768
	lui	s2,%hi(.L113)
	lui	s3,%hi(.L107)
	sw	s1,52(sp)
	sw	ra,60(sp)
	sw	s4,40(sp)
	sw	s5,36(sp)
	addi	s0,s0,-1
	li	s1,25
	addi	s2,s2,%lo(.L113)
	addi	s3,s3,%lo(.L107)
	j	.L92
.L189:
	li	a4,10
	beq	a5,a4,.L187
.L94:
	li	a4,-799539200
	sw	a5,0(a4)
	mv	s4,a0
.L95:
	lbu	a5,1(s4)
	addi	a0,s4,1
	beq	a5,zero,.L188
.L92:
	li	a4,37
	bne	a5,a4,.L189
	li	a5,32
	sb	a5,12(sp)
	li	a5,10
	sw	zero,16(sp)
	sw	zero,20(sp)
	sw	s0,8(sp)
	sw	a5,28(sp)
	li	a7,0
	li	a6,9
.L96:
	lbu	a5,1(a0)
	addi	s4,a0,1
	addi	a4,a5,-48
	andi	a3,a4,0xff
	bleu	a3,a6,.L190
	addi	a4,a5,-65
	andi	a4,a4,0xff
	bgtu	a4,s1,.L104
	addi	a4,a5,-67
	andi	a4,a4,0xff
	li	a3,21
	bgtu	a4,a3,.L105
	slli	a4,a4,2
	add	a4,a4,s3
	lw	a4,0(a4)
	jr	a4
	.section	.rodata
	.align	2
	.align	2
.L107:
	.word	.L149
	.word	.L108
	.word	.L105
	.word	.L105
	.word	.L105
	.word	.L105
	.word	.L105
	.word	.L105
	.word	.L105
	.word	.L115
	.word	.L105
	.word	.L105
	.word	.L105
	.word	.L106
	.word	.L105
	.word	.L105
	.word	.L147
	.word	.L105
	.word	.L108
	.word	.L105
	.word	.L105
	.word	.L106
	.text
.L190:
	beq	a7,zero,.L99
	li	a2,0
	li	t3,9
.L100:
	lbu	a5,1(s4)
	slli	a3,a2,2
	add	a3,a3,a2
	slli	a3,a3,1
	add	a2,a4,a3
	addi	a4,a5,-48
	andi	a5,a4,0xff
	mv	a0,s4
	addi	s4,s4,1
	bleu	a5,t3,.L100
	sw	a2,8(sp)
	j	.L96
.L104:
	addi	a5,a5,-37
	andi	a5,a5,0xff
	li	a4,83
	bgtu	a5,a4,.L111
	slli	a5,a5,2
	add	a5,a5,s2
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L113:
	.word	.L118
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L117
	.word	.L150
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L116
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L151
	.word	.L114
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L115
	.word	.L111
	.word	.L111
	.word	.L111
	.word	.L112
	.word	.L111
	.word	.L111
	.word	.L152
	.word	.L111
	.word	.L114
	.word	.L111
	.word	.L111
	.word	.L112
	.text
.L187:
	li	a4,-799539200
	li	a3,13
	sw	a3,0(a4)
	j	.L94
.L99:
	li	a3,48
	bne	a5,a3,.L102
	sb	a5,12(sp)
.L102:
	li	a2,0
	li	t3,9
.L103:
	lbu	a5,1(s4)
	slli	a3,a2,2
	add	a3,a3,a2
	slli	a3,a3,1
	add	a2,a4,a3
	addi	a4,a5,-48
	andi	a5,a4,0xff
	mv	a0,s4
	addi	s4,s4,1
	bleu	a5,t3,.L103
	li	a5,1
	sw	a2,4(sp)
	sw	a5,16(sp)
	j	.L96
.L188:
	lw	ra,60(sp)
	lw	s0,56(sp)
	lw	s1,52(sp)
	lw	s2,48(sp)
	lw	s3,44(sp)
	lw	s4,40(sp)
	lw	s5,36(sp)
	li	a0,0
	addi	sp,sp,64
	jr	ra
.L105:
	li	a5,1
	sw	a5,24(sp)
	j	.L95
.L108:
	li	a4,1
	sw	a4,24(sp)
	addi	s5,a1,4
.L120:
	lw	a0,0(a1)
	mv	a2,sp
	li	a1,10
	call	outnum
	mv	a1,s5
	j	.L95
.L118:
	sw	zero,24(sp)
	li	a5,-799539200
	li	a4,37
	sw	a4,0(a5)
	j	.L95
.L116:
	li	a5,-799539200
	li	a4,92
	sw	a4,0(a5)
	addi	a0,a0,2
	j	.L96
.L117:
	li	a5,1
	sw	a5,20(sp)
	mv	a0,s4
	j	.L96
.L111:
	sw	zero,24(sp)
	j	.L95
.L115:
	mv	a0,s4
	j	.L96
.L182:
	li	a0,0
	ret
.L106:
	li	a5,1
	sw	a5,24(sp)
	addi	s5,a1,4
.L123:
	lw	a0,0(a1)
	li	a5,8
	li	a1,16
	mv	a2,sp
	sw	a5,28(sp)
	call	outnum
	mv	a1,s5
	j	.L95
.L114:
	sw	zero,24(sp)
	addi	s5,a1,4
	j	.L120
.L112:
	sw	zero,24(sp)
	addi	s5,a1,4
	j	.L123
.L149:
	li	a4,1
.L110:
	lw	a5,0(a1)
	sw	a4,24(sp)
	li	a4,10
	andi	a3,a5,0xff
	addi	a1,a1,4
	beq	a3,a4,.L191
.L145:
	andi	a5,a5,255
	li	a4,-799539200
	sw	a5,0(a4)
	j	.L95
.L147:
	li	a5,1
.L109:
	lw	a3,0(a1)
	sw	a5,24(sp)
	addi	t1,a1,4
	beq	a3,zero,.L153
	lbu	a5,0(a3)
	beq	a5,zero,.L153
	mv	a5,a3
.L127:
	lbu	a4,1(a5)
	addi	a5,a5,1
	bne	a4,zero,.L127
	sub	a5,a5,a3
.L125:
	lw	a4,16(sp)
	sw	a5,0(sp)
	beq	a4,zero,.L131
	lw	a4,20(sp)
	bne	a4,zero,.L131
	lw	a4,4(sp)
	bge	a5,a4,.L131
	lbu	a2,12(sp)
	li	a1,10
	beq	a2,a1,.L192
	li	a1,-799539200
.L135:
	sw	a2,0(a1)
	addi	a5,a5,1
	bne	a4,a5,.L135
.L131:
	lbu	a4,0(a3)
	beq	a4,zero,.L130
	lw	a2,8(sp)
	mv	a5,a3
	li	a6,10
	addi	a1,a2,-1
	add	a3,a3,a2
	add	a1,a5,a1
	li	a0,-799539200
	li	a7,13
.L133:
	sub	a2,a1,a5
	sw	a2,8(sp)
	beq	a5,a3,.L193
.L139:
	addi	a5,a5,1
	beq	a4,a6,.L194
	sw	a4,0(a0)
	lbu	a4,0(a5)
	bne	a4,zero,.L133
.L130:
	li	a5,0
.L141:
	lw	a4,16(sp)
	sw	a5,0(sp)
	mv	a1,t1
	beq	a4,zero,.L95
	lw	a4,20(sp)
	beq	a4,zero,.L142
	lw	a4,4(sp)
	ble	a4,a5,.L142
	lbu	a3,12(sp)
	li	a2,10
	beq	a3,a2,.L195
	li	a2,-799539200
.L144:
	sw	a3,0(a2)
	addi	a5,a5,1
	bne	a4,a5,.L144
.L142:
	mv	a1,t1
	j	.L95
.L152:
	li	a5,0
	j	.L109
.L150:
	mv	a0,s4
	li	a7,1
	j	.L96
.L151:
	li	a4,0
	j	.L110
.L194:
	sw	a7,0(a0)
	sw	a4,0(a0)
	lbu	a4,0(a5)
	beq	a4,zero,.L130
	sub	a2,a1,a5
	sw	a2,8(sp)
	bne	a5,a3,.L139
.L193:
	mv	a5,a3
.L140:
	lbu	a4,1(a5)
	addi	a5,a5,1
	bne	a4,zero,.L140
	sub	a5,a5,a3
	j	.L141
.L153:
	li	a5,0
	j	.L125
.L191:
	li	a4,-799539200
	li	a3,13
	sw	a3,0(a4)
	j	.L145
.L192:
	li	a2,-799539200
	li	a0,13
.L134:
	sw	a0,0(a2)
	sw	a1,0(a2)
	addi	a5,a5,1
	bne	a4,a5,.L134
	j	.L131
.L195:
	li	a3,-799539200
	li	a1,13
.L143:
	sw	a1,0(a3)
	sw	a2,0(a3)
	addi	a5,a5,1
	bne	a4,a5,.L143
	mv	a1,t1
	j	.L95
	.size	uart_printf, .-uart_printf
	.align	2
	.globl	printf
	.type	printf, @function
printf:
	addi	sp,sp,-64
	sw	ra,28(sp)
	sw	a1,36(sp)
	sw	a2,40(sp)
	sw	a3,44(sp)
	sw	a4,48(sp)
	sw	a5,52(sp)
	sw	a6,56(sp)
	sw	a7,60(sp)
	beq	a0,zero,.L198
	addi	a1,sp,36
	sw	a1,12(sp)
	call	uart_printf
	lw	ra,28(sp)
	addi	sp,sp,64
	jr	ra
.L198:
	lw	ra,28(sp)
	li	a0,0
	addi	sp,sp,64
	jr	ra
	.size	printf, .-printf
	.ident	"GCC: (GNU) 12.0.1 20220214 (experimental)"
