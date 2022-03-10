	.file	"warp_v1_golden.c"
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
	.globl	warp_param_read
	.type	warp_param_read, @function
warp_param_read:
	lw	a5,12(a1)
	li	a3,65536
	addi	a3,a3,-1
	srai	a2,a5,16
	and	a5,a5,a3
	lw	a4,8(a1)
	sw	a5,12(a0)
	lui	a5,%hi(src_arr_global)
	addi	a5,a5,%lo(src_arr_global)
	sw	a5,16(a0)
	lui	a5,%hi(offset_arr_global)
	addi	a5,a5,%lo(offset_arr_global)
	sw	a5,20(a0)
	lui	a5,%hi(out_arr_global)
	srai	a1,a4,16
	addi	a5,a5,%lo(out_arr_global)
	and	a4,a4,a3
	sw	a1,0(a0)
	sw	a4,4(a0)
	sw	a2,8(a0)
	sw	a5,24(a0)
	ret
	.size	warp_param_read, .-warp_param_read
	.align	2
	.globl	warp_golden
	.type	warp_golden, @function
warp_golden:
	lw	t6,0(a0)
	addi	sp,sp,-64
	sw	s4,44(sp)
	sw	s0,60(sp)
	sw	s1,56(sp)
	sw	s2,52(sp)
	sw	s3,48(sp)
	sw	s5,40(sp)
	sw	s6,36(sp)
	sw	s7,32(sp)
	sw	s8,28(sp)
	sw	s9,24(sp)
	sw	s10,20(sp)
	sw	s11,16(sp)
	lw	s4,4(a0)
	lw	t0,8(a0)
	lw	t1,12(a0)
	beq	t6,zero,.L4
	mul	s2,t6,s4
	li	s3,1
	sll	s3,s3,t1
	slli	s3,s3,16
	srli	s3,s3,16
	mul	s2,s2,t0
	beq	s4,zero,.L4
	beq	t0,zero,.L4
	lw	s5,24(a0)
	lw	s0,16(a0)
	lw	s7,20(a0)
	li	a5,0
	slli	s6,t0,1
	sw	t6,12(sp)
	sw	s4,8(sp)
	mul	t3,s4,t0
	mv	a4,a5
	mv	t5,s5
.L7:
	mv	a7,s7
	mv	s1,t5
	li	t2,0
	mv	s8,s7
.L13:
	sub	s9,s1,s5
	mv	t6,a7
	li	a5,0
	addi	s10,s9,-1
	j	.L11
.L32:
	sub	s4,a1,a0
	slli	s4,s4,16
	add	s11,s0,a2
	srai	s4,s4,16
	li	a6,0
	bgeu	a2,s2,.L9
	lb	a2,0(s11)
	sub	a3,s7,a3
	mul	a2,a2,s4
	blt	t4,zero,.L30
.L14:
	add	a3,s0,a3
	sub	a1,s3,a1
	lb	a6,0(a3)
	add	a0,a0,a1
	slli	a0,a0,16
	srai	a0,a0,16
	mul	a6,a6,a0
	add	a6,a6,a2
	sra	a6,a6,t1
	slli	a6,a6,24
	srai	a6,a6,24
.L9:
	add	a3,s1,a5
	sb	a6,0(a3)
	addi	a5,a5,1
	addi	t6,t6,2
	beq	t0,a5,.L31
.L11:
	lh	a1,0(t6)
	add	a2,s10,a5
	add	s7,s9,a5
	sra	a3,a1,t1
	sub	t4,a5,a3
	addi	a6,t4,-1
	sll	a0,a3,t1
	slli	a6,a6,16
	slli	t4,t4,16
	slli	a1,a1,16
	slli	a0,a0,16
	srai	a6,a6,16
	sub	a2,a2,a3
	srai	t4,t4,16
	srli	a1,a1,16
	srli	a0,a0,16
	bge	a6,zero,.L32
	sub	a3,s7,a3
	addi	a2,a3,-1
	li	a6,0
	bne	t4,zero,.L9
	bgeu	a2,s2,.L9
	li	a2,0
	j	.L14
.L30:
	sra	a2,a2,t1
	slli	a6,a2,24
	add	a3,s1,a5
	srai	a6,a6,24
	sb	a6,0(a3)
	addi	a5,a5,1
	addi	t6,t6,2
	bne	t0,a5,.L11
.L31:
	lw	a5,8(sp)
	addi	t2,t2,1
	add	s1,s1,t0
	add	a7,a7,s6
	bne	a5,t2,.L13
	lw	a5,12(sp)
	addi	a4,a4,1
	mv	s7,s8
	add	t5,t5,t3
	bne	a5,a4,.L7
.L4:
	lw	s0,60(sp)
	lw	s1,56(sp)
	lw	s2,52(sp)
	lw	s3,48(sp)
	lw	s4,44(sp)
	lw	s5,40(sp)
	lw	s6,36(sp)
	lw	s7,32(sp)
	lw	s8,28(sp)
	lw	s9,24(sp)
	lw	s10,20(sp)
	lw	s11,16(sp)
	addi	sp,sp,64
	jr	ra
	.size	warp_golden, .-warp_golden
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"warp_58x112x88 running cycles : %d.\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	li	a5,58
	sw	a5,4(sp)
	li	a5,112
	sw	a5,8(sp)
	li	a5,88
	sw	a5,12(sp)
	li	a5,8
	sw	a5,16(sp)
	lui	a5,%hi(src_arr_global)
	addi	a5,a5,%lo(src_arr_global)
	sw	a5,20(sp)
	lui	a5,%hi(offset_arr_global)
	addi	a5,a5,%lo(offset_arr_global)
	sw	a5,24(sp)
	lui	a5,%hi(out_arr_global)
	addi	a5,a5,%lo(out_arr_global)
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	a5,28(sp)
 #APP
# 8 "top4_goldenc/../com_lib/platform.h" 1
	rdcycle s0

# 0 "" 2
 #NO_APP
	addi	a0,sp,4
	call	warp_golden
 #APP
# 8 "top4_goldenc/../com_lib/platform.h" 1
	rdcycle a1

# 0 "" 2
 #NO_APP
	lui	a0,%hi(.LC0)
	sub	a1,a1,s0
	addi	a0,a0,%lo(.LC0)
	call	printf
	lw	ra,44(sp)
	lw	s0,40(sp)
	li	a0,0
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.globl	out_arr_global
	.globl	offset_arr_global
	.globl	src_arr_global
	.data
	.align	2
	.type	offset_arr_global, @object
	.size	offset_arr_global, 19712
offset_arr_global:
	.half	256
	.zero	19710
	.type	src_arr_global, @object
	.size	src_arr_global, 571648
src_arr_global:
	.string	"\002"
	.zero	571646
	.bss
	.align	2
	.type	out_arr_global, @object
	.size	out_arr_global, 571648
out_arr_global:
	.zero	571648
	.ident	"GCC: (GNU) 12.0.1 20220214 (experimental)"
