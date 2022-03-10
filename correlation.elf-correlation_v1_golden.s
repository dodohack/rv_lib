	.file	"correlation_v1_golden.c"
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
	.globl	correlation_param_read
	.type	correlation_param_read, @function
correlation_param_read:
	lw	a3,8(a1)
	lw	a4,12(a1)
	lw	a2,16(a1)
	li	a5,65536
	addi	a5,a5,-1
	srai	a6,a3,16
	srai	a1,a4,16
	and	a3,a3,a5
	and	a4,a4,a5
	and	a2,a2,a5
	lui	a5,%hi(src0_arr_global)
	addi	a5,a5,%lo(src0_arr_global)
	sw	a5,20(a0)
	lui	a5,%hi(src1_arr_global)
	addi	a5,a5,%lo(src1_arr_global)
	sw	a5,24(a0)
	lui	a5,%hi(out_arr_global)
	addi	a5,a5,%lo(out_arr_global)
	sw	a6,0(a0)
	sw	a3,4(a0)
	sw	a1,8(a0)
	sw	a4,12(a0)
	sw	a2,16(a0)
	sw	a5,28(a0)
	ret
	.size	correlation_param_read, .-correlation_param_read
	.align	2
	.globl	correlation_golden
	.type	correlation_golden, @function
correlation_golden:
	addi	sp,sp,-32
	sw	s2,20(sp)
	lw	s2,12(a0)
	sw	s0,28(sp)
	sw	s1,24(sp)
	sw	s3,16(sp)
	sw	s4,12(sp)
	lw	s0,4(a0)
	lw	a7,8(a0)
	beq	s2,zero,.L4
	mul	t0,s0,a7
	beq	s0,zero,.L4
	beq	a7,zero,.L4
	csrr	a1,vlenb
	srai	a1,a1,2
	lw	a6,0(a0)
	lw	t4,16(a0)
	lw	s4,20(a0)
	lw	s1,28(a0)
	lw	s3,24(a0)
	mul	a1,t0,a1
	li	t3,0
.L7:
	mv	t6,s4
	sub	t5,s3,t3
	mv	t1,s1
	li	t2,0
.L13:
	li	a2,0
.L11:
	li	a5,0
	beq	a6,zero,.L8
	bgtu	t3,a2,.L9
	vsetvli	a5,zero,e32,m1,ta,mu
	add	a3,a2,t6
	add	a4,t5,a2
	mv	a5,a6
	vid.v	v25
	vmul.vx	v25,v25,t0
	vsetvli	zero,zero,e16,mf2,ta,mu
	vmv.v.i	v24,0
.L10:
	vsetvli	a0,a5,e8,mf4,ta,mu
	sub	a5,a5,a0
	vluxei32.v	v27,(a3),v25
	vluxei32.v	v26,(a4),v25
	add	a3,a3,a1
	add	a4,a4,a1
	vwmacc.vv	v24,v27,v26
	bne	a5,zero,.L10
	vsetvli	a5,zero,e16,m1,ta,mu
	vmv.v.i	v28,0
	vsetvli	a5,zero,e16,mf2,ta,mu
	vredsum.vs	v28,v24,v28
	vmv.x.s	a5,v28
	slli	a5,a5,16
	srai	a5,a5,16
.L9:
	sra	a5,a5,t4
	slli	a5,a5,24
	srai	a5,a5,24
.L8:
	add	a4,t1,a2
	sb	a5,0(a4)
	addi	a2,a2,1
	bne	a7,a2,.L11
	addi	t2,t2,1
	add	t1,t1,a7
	add	t6,t6,a7
	add	t5,t5,a7
	bne	s0,t2,.L13
	addi	t3,t3,1
	add	s1,s1,t0
	bne	s2,t3,.L7
.L4:
	lw	s0,28(sp)
	lw	s1,24(sp)
	lw	s2,20(sp)
	lw	s3,16(sp)
	lw	s4,12(sp)
	addi	sp,sp,32
	jr	ra
	.size	correlation_golden, .-correlation_golden
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC0:
	.string	"correlation_58x112x88_test running cycles : %d.\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	li	a5,58
	sw	a5,0(sp)
	li	a5,112
	sw	a5,4(sp)
	li	a5,88
	sw	a5,8(sp)
	li	a5,5
	sw	a5,12(sp)
	lui	a5,%hi(src0_arr_global)
	addi	a5,a5,%lo(src0_arr_global)
	sw	a5,20(sp)
	lui	a5,%hi(src1_arr_global)
	addi	a5,a5,%lo(src1_arr_global)
	sw	a5,24(sp)
	lui	a5,%hi(out_arr_global)
	addi	a5,a5,%lo(out_arr_global)
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	a5,28(sp)
	sw	zero,16(sp)
 #APP
# 8 "top4_goldenc/../com_lib/platform.h" 1
	rdcycle s0

# 0 "" 2
 #NO_APP
	mv	a0,sp
	call	correlation_golden
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
	.globl	src1_arr_global
	.globl	src0_arr_global
	.data
	.align	2
	.type	src1_arr_global, @object
	.size	src1_arr_global, 571648
src1_arr_global:
	.string	"\001"
	.zero	571646
	.type	src0_arr_global, @object
	.size	src0_arr_global, 571648
src0_arr_global:
	.string	"\001"
	.zero	571646
	.bss
	.align	2
	.type	out_arr_global, @object
	.size	out_arr_global, 49280
out_arr_global:
	.zero	49280
	.ident	"GCC: (GNU) 12.0.1 20220214 (experimental)"
