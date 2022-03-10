	.file	"resize_v2_golden.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_f2p2_d2p2_v1p0_zicsr2p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	read_rdcycle
	.type	read_rdcycle, @function
read_rdcycle:
 #APP
# 8 "top4_goldenc/../com_lib/platform.h" 1
	rdcycle a0

# 0 "" 2
 #NO_APP
	ret
	.size	read_rdcycle, .-read_rdcycle
	.align	2
	.globl	resize_param_read
	.type	resize_param_read, @function
resize_param_read:
	lw	a5,8(a1)
	lh	a4,14(a1)
	srai	a3,a5,16
	sh	a5,2(a0)
	lui	a5,%hi(src_arr_global)
	addi	a5,a5,%lo(src_arr_global)
	sw	a5,8(a0)
	lui	a5,%hi(out_arr_global)
	addi	a5,a5,%lo(out_arr_global)
	sh	a3,0(a0)
	sh	a4,4(a0)
	sw	a5,12(a0)
	ret
	.size	resize_param_read, .-resize_param_read
	.align	2
	.globl	resize_golden_v2
	.type	resize_golden_v2, @function
resize_golden_v2:
	lhu	t6,0(a0)
	lhu	t4,2(a0)
	beq	t6,zero,.L47
	slli	t1,t4,1
	slli	t1,t1,16
	srli	t1,t1,16
	beq	t1,zero,.L47
	addi	sp,sp,-80
	sw	s9,40(sp)
	lhu	s9,4(a0)
	sw	s0,76(sp)
	sw	s1,72(sp)
	sw	s2,68(sp)
	sw	s3,64(sp)
	sw	s4,60(sp)
	sw	s5,56(sp)
	sw	s6,52(sp)
	sw	s7,48(sp)
	sw	s8,44(sp)
	sw	s10,36(sp)
	sw	s11,32(sp)
	li	a4,1
	lw	s0,8(a0)
	lw	a6,12(a0)
	bne	s9,a4,.L50
	addi	s3,t4,-1
	li	s4,-65536
	slli	s6,s3,16
	slli	s5,t1,6
	li	a0,0
	addi	s4,s4,127
	li	t3,-128
	li	t0,64
	srli	s6,s6,16
	mv	a7,t6
.L27:
	mul	s10,t4,a0
	li	s8,0
	mv	t5,a7
	mul	s9,a0,t1
	add	s2,s6,s10
	add	s2,s0,s2
	slli	s9,s9,1
	add	s9,a6,s9
.L23:
	srai	a5,s8,7
	and	t6,s8,s4
	andi	a5,a5,511
	sub	t6,t3,t6
	add	a2,a5,s10
	andi	t6,t6,0xff
	andi	s1,s8,127
	ble	s3,a5,.L21
	mv	a3,s9
	li	a4,0
	add	a2,s0,a2
	j	.L22
.L31:
	li	a4,64
.L22:
	lb	a5,1(a2)
	lb	s7,0(a2)
	lb	a1,1(s2)
	lb	t2,0(s2)
	sub	a7,t3,a4
	andi	a7,a7,0xff
	mul	s7,s7,a7
	addi	a3,a3,1
	mul	a5,a5,a4
	mul	a1,a1,a4
	add	a5,a5,s7
	srai	a5,a5,7
	mul	a7,t2,a7
	add	a1,a1,a7
	srai	a1,a1,7
	mul	a5,a5,t6
	mul	a1,a1,s1
	add	a5,a5,a1
	srai	a5,a5,7
	sb	a5,-1(a3)
	bne	a4,t0,.L31
	addi	s8,s8,64
	addi	s9,s9,2
	bne	s8,s5,.L23
.L51:
	addi	a0,a0,1
	slli	a0,a0,16
	srli	a0,a0,16
	mv	a7,t5
	bgtu	t5,a0,.L27
.L4:
	lw	s0,76(sp)
	lw	s1,72(sp)
	lw	s2,68(sp)
	lw	s3,64(sp)
	lw	s4,60(sp)
	lw	s5,56(sp)
	lw	s6,52(sp)
	lw	s7,48(sp)
	lw	s8,44(sp)
	lw	s9,40(sp)
	lw	s10,36(sp)
	lw	s11,32(sp)
	addi	sp,sp,80
	jr	ra
.L21:
	addi	a1,a5,1
	add	a1,a1,s10
	mv	t2,s9
	li	s7,0
	li	a7,0
	add	a2,s0,a2
	add	a1,s0,a1
	sw	t5,8(sp)
	j	.L25
.L30:
	li	s7,64
.L25:
	lb	a5,1(a2)
	lb	t5,0(a2)
	lb	a4,1(a1)
	lb	s11,0(a1)
	sub	a3,t3,a7
	andi	a3,a3,0xff
	mul	a5,a5,a7
	addi	t2,t2,1
	mul	a4,a4,a7
	li	a7,64
	mul	t5,t5,a3
	mul	a3,s11,a3
	add	a5,a5,t5
	srai	a5,a5,7
	add	a4,a4,a3
	srai	a4,a4,7
	mul	a5,a5,t6
	mul	a4,a4,s1
	add	a5,a5,a4
	srai	a5,a5,7
	sb	a5,-1(t2)
	bne	s7,t0,.L30
	addi	s8,s8,64
	lw	t5,8(sp)
	addi	s9,s9,2
	bne	s8,s5,.L23
	j	.L51
.L50:
	slli	s7,s9,1
	addi	s3,t4,-1
	slli	s7,s7,16
	slli	a5,s3,16
	srli	s7,s7,16
	mul	a0,t4,s9
	srli	a5,a5,16
	addi	s2,s9,-1
	li	t0,-65536
	slli	s6,s2,16
	slli	s10,t1,6
	slli	s5,s7,6
	li	s8,0
	li	a2,0
	li	t3,0
	mul	t5,s7,t1
	addi	t0,t0,127
	li	t2,-128
	srli	s6,s6,16
	sw	a6,28(sp)
	mv	a1,a0
	mul	a4,a5,s9
.L20:
	lw	a5,28(sp)
	add	s1,a4,s8
	li	s4,0
	add	s11,a5,a2
	sw	t3,12(sp)
	sw	a4,16(sp)
	sw	t6,20(sp)
	sw	a2,24(sp)
.L29:
	beq	s7,zero,.L19
	srai	a5,s4,7
	andi	a5,a5,511
	mul	a0,a5,s9
	and	t4,s4,t0
	sub	t4,t2,t4
	andi	t4,t4,0xff
	andi	t6,s4,127
	add	a0,a0,s8
	bge	a5,s3,.L9
	mv	t1,s11
	li	a2,0
	add	a0,s0,a0
.L12:
	srai	a6,a2,7
	and	a3,a2,t0
	andi	a6,a6,511
	sub	a3,t2,a3
	add	a4,s0,a6
	andi	t3,a2,127
	andi	a3,a3,0xff
	add	a5,a0,a6
	add	a4,a4,s1
	addi	a2,a2,64
	mv	a7,s6
	bgt	s2,a6,.L11
	addi	a7,a6,1
.L11:
	add	a6,s0,a7
	add	a6,a6,s1
	add	a7,a0,a7
	lb	a5,0(a5)
	lb	a7,0(a7)
	lb	a4,0(a4)
	lb	a6,0(a6)
	mul	a5,a5,a3
	addi	t1,t1,1
	mul	a7,a7,t3
	mul	a4,a4,a3
	add	a5,a5,a7
	srai	a5,a5,7
	mul	a6,a6,t3
	add	a4,a4,a6
	srai	a4,a4,7
	mul	a5,a5,t4
	mul	a4,a4,t6
	add	a5,a5,a4
	srai	a5,a5,7
	sb	a5,-1(t1)
	bne	s5,a2,.L12
.L19:
	addi	s4,s4,64
	add	s11,s11,s7
	bne	s4,s10,.L29
	lw	t3,12(sp)
	lw	a2,24(sp)
	lw	t6,20(sp)
	addi	a5,t3,1
	slli	t3,a5,16
	srli	t3,t3,16
	lw	a4,16(sp)
	add	a2,a2,t5
	add	s8,s8,a1
	bne	t6,t3,.L20
	j	.L4
.L9:
	addi	t1,a5,1
	mul	t1,t1,s9
	mv	t3,s11
	li	a2,0
	add	a0,s0,a0
	sw	s9,8(sp)
	add	t1,t1,s8
.L16:
	srai	a6,a2,7
	andi	a6,a6,511
	and	a3,a2,t0
	sub	a3,t2,a3
	add	a4,s0,a6
	andi	s9,a2,127
	andi	a3,a3,0xff
	add	a5,a0,a6
	add	a4,a4,t1
	addi	a2,a2,64
	addi	a7,a6,1
	ble	s2,a6,.L15
	mv	a7,s6
.L15:
	add	a6,s0,a7
	add	a6,a6,t1
	add	a7,a0,a7
	lb	a5,0(a5)
	lb	a7,0(a7)
	lb	a4,0(a4)
	lb	a6,0(a6)
	mul	a5,a5,a3
	addi	t3,t3,1
	mul	a7,a7,s9
	mul	a4,a4,a3
	add	a5,a5,a7
	srai	a5,a5,7
	mul	a6,a6,s9
	add	a4,a4,a6
	srai	a4,a4,7
	mul	a5,a5,t4
	mul	a4,a4,t6
	add	a5,a5,a4
	srai	a5,a5,7
	sb	a5,-1(t3)
	bne	s5,a2,.L16
	lw	s9,8(sp)
	j	.L19
.L47:
	ret
	.size	resize_golden_v2, .-resize_golden_v2
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"resize_1x112x88 running cycles : %d.\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	li	a5,7340032
	addi	sp,sp,-32
	addi	a5,a5,1
	sw	a5,0(sp)
	li	a5,88
	sh	a5,4(sp)
	lui	a5,%hi(src_arr_global)
	addi	a5,a5,%lo(src_arr_global)
	sw	a5,8(sp)
	lui	a5,%hi(out_arr_global)
	addi	a5,a5,%lo(out_arr_global)
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	a5,12(sp)
 #APP
# 8 "top4_goldenc/../com_lib/platform.h" 1
	rdcycle s0

# 0 "" 2
 #NO_APP
	mv	a0,sp
	call	resize_golden_v2
 #APP
# 8 "top4_goldenc/../com_lib/platform.h" 1
	rdcycle a1

# 0 "" 2
 #NO_APP
	lui	a0,%hi(.LC0)
	sub	a1,a1,s0
	addi	a0,a0,%lo(.LC0)
	call	printf
	lw	ra,28(sp)
	lw	s0,24(sp)
	li	a0,0
	addi	sp,sp,32
	jr	ra
	.size	main, .-main
	.globl	out_arr_global
	.globl	src_arr_global
	.data
	.align	2
	.type	src_arr_global, @object
	.size	src_arr_global, 9856
src_arr_global:
	.string	"\002"
	.zero	9854
	.bss
	.align	2
	.type	out_arr_global, @object
	.size	out_arr_global, 39424
out_arr_global:
	.zero	39424
	.ident	"GCC: (GNU) 12.0.1 20220214 (experimental)"
