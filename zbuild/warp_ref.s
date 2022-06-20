	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10"
	.option	nopic
	.file	"warp_ref.c"
	.globl	read_rdcycle                    # -- Begin function read_rdcycle
	.p2align	2
	.type	read_rdcycle,@function
read_rdcycle:                           # @read_rdcycle
# %bb.0:                                # %entry
	#APP
	csrr	a0, mcycle

	#NO_APP
	ret
.Lfunc_end0:
	.size	read_rdcycle, .Lfunc_end0-read_rdcycle
                                        # -- End function
	.globl	warp_param_read                 # -- Begin function warp_param_read
	.p2align	2
	.type	warp_param_read,@function
warp_param_read:                        # @warp_param_read
# %bb.0:                                # %entry
	lui	a2, %hi(src_arr_global)
	addi	a2, a2, %lo(src_arr_global)
	sw	a2, 0(a0)
	lui	a2, %hi(offset_arr_global)
	addi	a2, a2, %lo(offset_arr_global)
	sw	a2, 4(a0)
	lui	a2, %hi(out_arr_global)
	addi	a2, a2, %lo(out_arr_global)
	sw	a2, 8(a0)
	lh	a2, 10(a1)
	sw	a2, 12(a0)
	lhu	a2, 8(a1)
	sw	a2, 16(a0)
	lh	a2, 14(a1)
	sw	a2, 20(a0)
	lhu	a1, 12(a1)
	sw	a1, 24(a0)
	ret
.Lfunc_end1:
	.size	warp_param_read, .Lfunc_end1-warp_param_read
                                        # -- End function
	.globl	warp_golden                     # -- Begin function warp_golden
	.p2align	2
	.type	warp_golden,@function
warp_golden:                            # @warp_golden
# %bb.0:                                # %entry
	addi	sp, sp, -32
	sw	s0, 28(sp)                      # 4-byte Folded Spill
	sw	s1, 24(sp)                      # 4-byte Folded Spill
	sw	s2, 20(sp)                      # 4-byte Folded Spill
	sw	s3, 16(sp)                      # 4-byte Folded Spill
	sw	s4, 12(sp)                      # 4-byte Folded Spill
	sw	s5, 8(sp)                       # 4-byte Folded Spill
	sw	s6, 4(sp)                       # 4-byte Folded Spill
	sw	s7, 0(sp)                       # 4-byte Folded Spill
	lw	a7, 16(a0)
	beqz	a7, .LBB2_21
# %bb.1:                                # %for.cond5.preheader.lr.ph
	lw	t1, 20(a0)
	beqz	t1, .LBB2_21
# %bb.2:                                # %for.cond5.preheader.lr.ph.split.us
	lw	a4, 12(a0)
	li	a6, 1
	beqz	a4, .LBB2_12
# %bb.3:                                # %for.cond5.preheader.us.us.preheader
	li	t0, 0
	lw	s2, 24(a0)
	lw	a2, 0(a0)
	lw	t2, 4(a0)
	lw	t6, 8(a0)
	mul	a1, t1, a7
	mul	a0, a1, a4
	addi	t3, a0, 1
	sll	a6, a6, s2
	j	.LBB2_5
.LBB2_4:                                # %for.cond5.for.cond.cleanup7_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB2_5 Depth=1
	addi	t0, t0, 1
	beq	t0, a7, .LBB2_21
.LBB2_5:                                # %for.cond5.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_7 Depth 2
                                        #       Child Loop BB2_11 Depth 3
                                        #       Child Loop BB2_9 Depth 3
	li	t5, 0
	mul	t4, t0, t1
	j	.LBB2_7
.LBB2_6:                                # %for.cond9.for.cond.cleanup11_crit_edge.us.us.us
                                        #   in Loop: Header=BB2_7 Depth=2
	addi	t5, t5, 1
	beq	t5, t1, .LBB2_4
.LBB2_7:                                # %for.body8.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_11 Depth 3
                                        #       Child Loop BB2_9 Depth 3
	add	a5, t5, t4
	slli	a0, a5, 1
	add	a0, a0, t2
	lh	a3, 0(a0)
	sra	s3, a3, s2
	vsetvli	s4, zero, e32, m8, ta, mu
	vid.v	v8
	add	s5, t3, s3
	sll	s0, s3, s2
	sub	s7, a3, s0
	sub	s6, a6, s7
	li	a3, 0
	bne	t5, s3, .LBB2_10
# %bb.8:                                # %for.body12.us.us.us.us.preheader
                                        #   in Loop: Header=BB2_7 Depth=2
	vsetvli	zero, s4, e16, m4, ta, mu
	vmv.v.i	v16, 0
.LBB2_9:                                # %for.body12.us.us.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        #     Parent Loop BB2_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a0, a4, a3
	vsetvli	a0, a0, e32, m8, ta, mu
	vmul.vx	v24, v8, a1
	mul	s0, a1, a3
	add	s0, s0, a5
	sub	s1, s0, t5
	add	s1, s1, a2
	vlse8.v	v20, (s1), a1
	vadd.vx	v24, v24, a5
	vmsltu.vx	v0, v24, s5
	vsetvli	zero, zero, e8, m2, ta, mu
	vwadd.vx	v24, v20, zero
	vsetvli	zero, zero, e16, m4, ta, mu
	vmerge.vim	v20, v24, 0, v0
	vmul.vx	v24, v16, s7
	vmul.vx	v20, v20, s6
	vadd.vv	v20, v24, v20
	add	s0, s0, t6
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wx	v24, v20, s2
	vsse8.v	v24, (s0), a1
	vsetvli	zero, zero, e32, m8, ta, mu
	add	a3, a3, a0
	vadd.vx	v8, v8, a0
	bltu	a3, a4, .LBB2_9
	j	.LBB2_6
.LBB2_10:                               # %for.body12.us146.us.us.preheader
                                        #   in Loop: Header=BB2_7 Depth=2
	not	s4, s3
.LBB2_11:                               # %for.body12.us146.us.us
                                        #   Parent Loop BB2_5 Depth=1
                                        #     Parent Loop BB2_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a0, a4, a3
	vsetvli	a0, a0, e32, m8, ta, mu
	vmul.vx	v16, v8, a1
	mul	s1, a1, a3
	add	s1, s1, a5
	add	s0, s1, s4
	add	s0, s0, a2
	vlse8.v	v24, (s0), a1
	vadd.vx	v16, v16, a5
	vmsltu.vx	v0, v16, s5
	vsetvli	zero, zero, e8, m2, ta, mu
	vwadd.vx	v16, v24, zero
	vsetvli	zero, zero, e16, m4, ta, mu
	sub	s0, s1, s3
	add	s0, s0, a2
	vlse8.v	v20, (s0), a1
	vmerge.vim	v16, v16, 0, v0
	vsetvli	zero, zero, e8, m2, ta, mu
	vwadd.vx	v24, v20, zero
	vsetvli	zero, zero, e16, m4, ta, mu
	vmerge.vim	v20, v24, 0, v0
	vmul.vx	v16, v16, s7
	vmul.vx	v20, v20, s6
	vadd.vv	v16, v16, v20
	add	s0, t6, s1
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wx	v20, v16, s2
	vsse8.v	v20, (s0), a1
	vsetvli	zero, zero, e32, m8, ta, mu
	add	a3, a3, a0
	vadd.vx	v8, v8, a0
	bltu	a3, a4, .LBB2_11
	j	.LBB2_6
.LBB2_12:                               # %for.cond5.preheader.us.preheader
	addi	t0, t1, -1
	andi	t2, a7, 1
	andi	t3, t1, 3
	bne	a7, a6, .LBB2_22
.LBB2_13:                               # %for.cond.cleanup.loopexit.unr-lcssa
	beqz	t2, .LBB2_21
# %bb.14:                               # %for.cond5.preheader.us.epil
	li	a0, 3
	bltu	t0, a0, .LBB2_17
# %bb.15:                               # %for.cond5.preheader.us.new.epil
	andi	a1, t1, -4
.LBB2_16:                               # %for.body8.us162.epil182
                                        # =>This Inner Loop Header: Depth=1
	vsetvli	a0, zero, e32, m8, ta, mu
	vsetvli	a0, zero, e32, m8, ta, mu
	vsetvli	a0, zero, e32, m8, ta, mu
	addi	a1, a1, -4
	vsetvli	a0, zero, e32, m8, ta, mu
	bnez	a1, .LBB2_16
.LBB2_17:                               # %for.cond5.for.cond.cleanup7_crit_edge.split.us166.unr-lcssa.epil
	beqz	t3, .LBB2_21
# %bb.18:                               # %for.body8.us162.epil.epil
	vsetvli	a0, zero, e32, m8, ta, mu
	beq	t3, a6, .LBB2_21
# %bb.19:                               # %for.body8.us162.epil.1.epil
	li	a0, 2
	vsetvli	a1, zero, e32, m8, ta, mu
	beq	t3, a0, .LBB2_21
# %bb.20:                               # %for.body8.us162.epil.2.epil
	vsetvli	a0, zero, e32, m8, ta, mu
.LBB2_21:                               # %for.cond.cleanup
	lw	s0, 28(sp)                      # 4-byte Folded Reload
	lw	s1, 24(sp)                      # 4-byte Folded Reload
	lw	s2, 20(sp)                      # 4-byte Folded Reload
	lw	s3, 16(sp)                      # 4-byte Folded Reload
	lw	s4, 12(sp)                      # 4-byte Folded Reload
	lw	s5, 8(sp)                       # 4-byte Folded Reload
	lw	s6, 4(sp)                       # 4-byte Folded Reload
	lw	s7, 0(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.LBB2_22:                               # %for.cond5.preheader.us.preheader.new
	li	a3, 0
	andi	a4, a7, -2
	sltiu	a5, t0, 3
	andi	a2, t1, -4
	seqz	s0, t3
	addi	a0, t3, -1
	seqz	a1, a0
	addi	a0, t3, -2
	seqz	a7, a0
	j	.LBB2_24
.LBB2_23:                               # %for.cond5.for.cond.cleanup7_crit_edge.split.us166.1
                                        #   in Loop: Header=BB2_24 Depth=1
	addi	a3, a3, 2
	beq	a3, a4, .LBB2_13
.LBB2_24:                               # %for.cond5.preheader.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_26 Depth 2
                                        #     Child Loop BB2_33 Depth 2
	bnez	a5, .LBB2_27
# %bb.25:                               # %for.body8.us162.preheader
                                        #   in Loop: Header=BB2_24 Depth=1
	mv	s1, a2
.LBB2_26:                               # %for.body8.us162
                                        #   Parent Loop BB2_24 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vsetvli	a0, zero, e32, m8, ta, mu
	vsetvli	a0, zero, e32, m8, ta, mu
	vsetvli	a0, zero, e32, m8, ta, mu
	addi	s1, s1, -4
	vsetvli	a0, zero, e32, m8, ta, mu
	bnez	s1, .LBB2_26
.LBB2_27:                               # %for.cond5.for.cond.cleanup7_crit_edge.split.us166.unr-lcssa
                                        #   in Loop: Header=BB2_24 Depth=1
	bnez	s0, .LBB2_31
# %bb.28:                               # %for.body8.us162.epil
                                        #   in Loop: Header=BB2_24 Depth=1
	vsetvli	a0, zero, e32, m8, ta, mu
	bnez	a1, .LBB2_31
# %bb.29:                               # %for.body8.us162.epil.1
                                        #   in Loop: Header=BB2_24 Depth=1
	vsetvli	a0, zero, e32, m8, ta, mu
	bnez	a7, .LBB2_31
# %bb.30:                               # %for.body8.us162.epil.2
                                        #   in Loop: Header=BB2_24 Depth=1
	vsetvli	a0, zero, e32, m8, ta, mu
.LBB2_31:                               # %for.cond5.for.cond.cleanup7_crit_edge.split.us166
                                        #   in Loop: Header=BB2_24 Depth=1
	bnez	a5, .LBB2_34
# %bb.32:                               # %for.body8.us162.1.preheader
                                        #   in Loop: Header=BB2_24 Depth=1
	mv	a0, a2
.LBB2_33:                               # %for.body8.us162.1
                                        #   Parent Loop BB2_24 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vsetvli	s1, zero, e32, m8, ta, mu
	vsetvli	s1, zero, e32, m8, ta, mu
	vsetvli	s1, zero, e32, m8, ta, mu
	addi	a0, a0, -4
	vsetvli	s1, zero, e32, m8, ta, mu
	bnez	a0, .LBB2_33
.LBB2_34:                               # %for.cond5.for.cond.cleanup7_crit_edge.split.us166.unr-lcssa.1
                                        #   in Loop: Header=BB2_24 Depth=1
	bnez	s0, .LBB2_23
# %bb.35:                               # %for.body8.us162.epil.1190
                                        #   in Loop: Header=BB2_24 Depth=1
	vsetvli	a0, zero, e32, m8, ta, mu
	bnez	a1, .LBB2_23
# %bb.36:                               # %for.body8.us162.epil.1.1
                                        #   in Loop: Header=BB2_24 Depth=1
	vsetvli	a0, zero, e32, m8, ta, mu
	bnez	a7, .LBB2_23
# %bb.37:                               # %for.body8.us162.epil.2.1
                                        #   in Loop: Header=BB2_24 Depth=1
	vsetvli	a0, zero, e32, m8, ta, mu
	j	.LBB2_23
.Lfunc_end2:
	.size	warp_golden, .Lfunc_end2-warp_golden
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %for.cond5.preheader.lr.ph.split.us.i
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	sw	s1, 36(sp)                      # 4-byte Folded Spill
	sw	s2, 32(sp)                      # 4-byte Folded Spill
	sw	s3, 28(sp)                      # 4-byte Folded Spill
	sw	s4, 24(sp)                      # 4-byte Folded Spill
	sw	s5, 20(sp)                      # 4-byte Folded Spill
	sw	s6, 16(sp)                      # 4-byte Folded Spill
	sw	s7, 12(sp)                      # 4-byte Folded Spill
	li	a7, 0
	lui	a0, 2
	addi	a2, a0, 1664
	#APP
	csrr	a6, mcycle

	#NO_APP
	li	t1, 88
	lui	a0, %hi(offset_arr_global)
	addi	t3, a0, %lo(offset_arr_global)
	lui	a0, 140
	addi	t4, a0, -1791
	li	t0, 256
	li	s2, 58
	lui	a0, %hi(src_arr_global)
	addi	a0, a0, %lo(src_arr_global)
	lui	a1, %hi(out_arr_global)
	addi	s3, a1, %lo(out_arr_global)
	li	t2, 112
	j	.LBB3_2
.LBB3_1:                                # %for.cond5.for.cond.cleanup7_crit_edge.split.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	addi	a7, a7, 1
	beq	a7, t2, .LBB3_9
.LBB3_2:                                # %for.cond5.preheader.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_4 Depth 2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_6 Depth 3
	li	t6, 0
	mul	t5, a7, t1
	j	.LBB3_4
.LBB3_3:                                # %for.cond9.for.cond.cleanup11_crit_edge.us.us.us.i
                                        #   in Loop: Header=BB3_4 Depth=2
	addi	t6, t6, 1
	beq	t6, t1, .LBB3_1
.LBB3_4:                                # %for.body8.us.us.us.i
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_6 Depth 3
	add	a5, t6, t5
	slli	a1, a5, 1
	add	a1, a1, t3
	lhu	a1, 0(a1)
	slli	a3, a1, 16
	srai	s4, a3, 24
	vsetvli	a3, zero, e32, m8, ta, mu
	vid.v	v8
	add	s6, s4, t4
	andi	s0, a1, 255
	sub	s7, t0, s0
	bne	t6, s4, .LBB3_7
# %bb.5:                                # %for.body12.us.us.us.us.i.preheader
                                        #   in Loop: Header=BB3_4 Depth=2
	li	a1, 0
	vsetvli	zero, a3, e16, m4, ta, mu
	vmv.v.i	v16, 0
.LBB3_6:                                # %for.body12.us.us.us.us.i
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_4 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a3, s2, a1
	vsetvli	a3, a3, e32, m8, ta, mu
	vmul.vx	v24, v8, a2
	mul	a4, a1, a2
	add	a4, a4, a5
	sub	s1, a4, t6
	add	s1, s1, a0
	vlse8.v	v20, (s1), a2
	vadd.vx	v24, v24, a5
	vmsltu.vx	v0, v24, s6
	vsetvli	zero, zero, e8, m2, ta, mu
	vwadd.vx	v24, v20, zero
	vsetvli	zero, zero, e16, m4, ta, mu
	vmerge.vim	v20, v24, 0, v0
	vmul.vx	v24, v16, s0
	vmul.vx	v20, v20, s7
	vadd.vv	v20, v24, v20
	add	a4, a4, s3
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v24, v20, 8
	vsse8.v	v24, (a4), a2
	vsetvli	zero, zero, e32, m8, ta, mu
	add	a1, a1, a3
	vadd.vx	v8, v8, a3
	bltu	a1, s2, .LBB3_6
	j	.LBB3_3
.LBB3_7:                                # %for.body12.us146.us.us.i.preheader
                                        #   in Loop: Header=BB3_4 Depth=2
	li	a3, 0
	not	s5, s4
.LBB3_8:                                # %for.body12.us146.us.us.i
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_4 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a1, s2, a3
	vsetvli	a1, a1, e32, m8, ta, mu
	vmul.vx	v16, v8, a2
	mul	a4, a3, a2
	add	a4, a4, a5
	add	s1, a4, s5
	add	s1, s1, a0
	vlse8.v	v24, (s1), a2
	vadd.vx	v16, v16, a5
	vmsltu.vx	v0, v16, s6
	vsetvli	zero, zero, e8, m2, ta, mu
	vwadd.vx	v16, v24, zero
	vsetvli	zero, zero, e16, m4, ta, mu
	sub	s1, a4, s4
	add	s1, s1, a0
	vlse8.v	v20, (s1), a2
	vmerge.vim	v16, v16, 0, v0
	vsetvli	zero, zero, e8, m2, ta, mu
	vwadd.vx	v24, v20, zero
	vsetvli	zero, zero, e16, m4, ta, mu
	vmerge.vim	v20, v24, 0, v0
	vmul.vx	v16, v16, s0
	vmul.vx	v20, v20, s7
	vadd.vv	v16, v16, v20
	add	a4, a4, s3
	vsetvli	zero, zero, e8, m2, ta, mu
	vnsra.wi	v20, v16, 8
	vsse8.v	v20, (a4), a2
	vsetvli	zero, zero, e32, m8, ta, mu
	add	a3, a3, a1
	vadd.vx	v8, v8, a1
	bltu	a3, s2, .LBB3_8
	j	.LBB3_3
.LBB3_9:                                # %warp_golden.exit
	#APP
	csrr	a0, mcycle

	#NO_APP
	sub	a1, a0, a6
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	lw	s1, 36(sp)                      # 4-byte Folded Reload
	lw	s2, 32(sp)                      # 4-byte Folded Reload
	lw	s3, 28(sp)                      # 4-byte Folded Reload
	lw	s4, 24(sp)                      # 4-byte Folded Reload
	lw	s5, 20(sp)                      # 4-byte Folded Reload
	lw	s6, 16(sp)                      # 4-byte Folded Reload
	lw	s7, 12(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.type	src_arr_global,@object          # @src_arr_global
	.data
	.globl	src_arr_global
	.p2align	2
src_arr_global:
	.byte	2                               # 0x2
	.zero	571647
	.size	src_arr_global, 571648

	.type	offset_arr_global,@object       # @offset_arr_global
	.globl	offset_arr_global
	.p2align	2
offset_arr_global:
	.half	256                             # 0x100
	.zero	19710
	.size	offset_arr_global, 19712

	.type	out_arr_global,@object          # @out_arr_global
	.bss
	.globl	out_arr_global
	.p2align	2
out_arr_global:
	.zero	571648
	.size	out_arr_global, 571648

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.4,"aMS",@progbits,1
	.p2align	2
.L.str:
	.asciz	"warp_58x112x88 running cycles : %d.\n"
	.size	.L.str, 37

	.ident	"Terapines LTD zcc version 2.0.0 (https://www.terapines.com d82a1442dfd98f60f08014f36ba57878ee901dfd)"
	.section	".note.GNU-stack","",@progbits
