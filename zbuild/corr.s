	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10"
	.option	nopic
	.file	"correlation_v1_golden.c"
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
	.globl	correlation_param_read          # -- Begin function correlation_param_read
	.p2align	2
	.type	correlation_param_read,@function
correlation_param_read:                 # @correlation_param_read
# %bb.0:                                # %entry
	lh	a2, 10(a1)
	sw	a2, 0(a0)
	lhu	a2, 8(a1)
	sw	a2, 4(a0)
	lh	a2, 14(a1)
	sw	a2, 8(a0)
	lhu	a2, 12(a1)
	sw	a2, 12(a0)
	lhu	a1, 16(a1)
	sw	a1, 16(a0)
	lui	a1, %hi(src0_arr_global)
	addi	a1, a1, %lo(src0_arr_global)
	sw	a1, 20(a0)
	lui	a1, %hi(src1_arr_global)
	addi	a1, a1, %lo(src1_arr_global)
	sw	a1, 24(a0)
	lui	a1, %hi(out_arr_global)
	addi	a1, a1, %lo(out_arr_global)
	sw	a1, 28(a0)
	ret
.Lfunc_end1:
	.size	correlation_param_read, .Lfunc_end1-correlation_param_read
                                        # -- End function
	.globl	correlation_golden              # -- Begin function correlation_golden
	.p2align	2
	.type	correlation_golden,@function
correlation_golden:                     # @correlation_golden
# %bb.0:                                # %entry
	addi	sp, sp, -32
	sw	s0, 28(sp)                      # 4-byte Folded Spill
	sw	s1, 24(sp)                      # 4-byte Folded Spill
	sw	s2, 20(sp)                      # 4-byte Folded Spill
	sw	s3, 16(sp)                      # 4-byte Folded Spill
	sw	s4, 12(sp)                      # 4-byte Folded Spill
	sw	s5, 8(sp)                       # 4-byte Folded Spill
	lw	a7, 4(a0)
	beqz	a7, .LBB2_2
# %bb.1:                                # %for.cond6.preheader.lr.ph
	lw	t5, 8(a0)
	lw	s2, 12(a0)
	seqz	a1, t5
	seqz	a2, s2
	or	a1, a1, a2
	beqz	a1, .LBB2_3
.LBB2_2:                                # %for.cond.cleanup
	lw	s0, 28(sp)                      # 4-byte Folded Reload
	lw	s1, 24(sp)                      # 4-byte Folded Reload
	lw	s2, 20(sp)                      # 4-byte Folded Reload
	lw	s3, 16(sp)                      # 4-byte Folded Reload
	lw	s4, 12(sp)                      # 4-byte Folded Reload
	lw	s5, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.LBB2_3:                                # %for.cond6.preheader.lr.ph.split.us.split.us
	lw	a1, 0(a0)
	lw	t6, 28(a0)
	mul	s5, t5, a7
	beqz	a1, .LBB2_14
# %bb.4:                                # %for.cond6.preheader.us.us.us.preheader
	lw	a6, 20(a0)
	lw	t2, 24(a0)
	lw	t3, 16(a0)
	li	t0, 0
	j	.LBB2_6
.LBB2_5:                                # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us.us.us.us
                                        #   in Loop: Header=BB2_6 Depth=1
	addi	t0, t0, 1
	beq	t0, a7, .LBB2_2
.LBB2_6:                                # %for.cond6.preheader.us.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_8 Depth 2
                                        #       Child Loop BB2_11 Depth 3
                                        #         Child Loop BB2_13 Depth 4
	li	t4, 0
	mul	t1, t5, t0
	j	.LBB2_8
.LBB2_7:                                # %for.cond10.for.cond.cleanup12_crit_edge.split.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_8 Depth=2
	addi	t4, t4, 1
	beq	t4, t5, .LBB2_5
.LBB2_8:                                # %for.cond10.preheader.us.us.us.us.us
                                        #   Parent Loop BB2_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_11 Depth 3
                                        #         Child Loop BB2_13 Depth 4
	li	s4, 0
	add	s3, t1, t4
	add	a3, a6, s3
	j	.LBB2_11
.LBB2_9:                                #   in Loop: Header=BB2_11 Depth=3
	li	a4, 0
.LBB2_10:                               # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us
                                        #   in Loop: Header=BB2_11 Depth=3
	mul	a0, s5, s4
	add	a0, a0, s3
	sra	a2, a4, t3
	add	a0, a0, t6
	addi	s4, s4, 1
	sb	a2, 0(a0)
	beq	s4, s2, .LBB2_7
.LBB2_11:                               # %for.body13.us.us.us.us.us.us
                                        #   Parent Loop BB2_6 Depth=1
                                        #     Parent Loop BB2_8 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_13 Depth 4
	bltu	t4, s4, .LBB2_9
# %bb.12:                               # %vector.body.preheader
                                        #   in Loop: Header=BB2_11 Depth=3
	li	s0, 0
	li	a4, 0
	sub	s1, s3, s4
	add	s1, s1, t2
.LBB2_13:                               # %vector.body
                                        #   Parent Loop BB2_6 Depth=1
                                        #     Parent Loop BB2_8 Depth=2
                                        #       Parent Loop BB2_11 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	sub	a0, a1, s0
	vsetvli	a0, a0, e8, m2, ta, mu
	mul	a2, s0, s5
	add	a5, s1, a2
	vlse8.v	v8, (a5), s5
	add	a2, a2, a3
	vlse8.v	v10, (a2), s5
	vmul.vv	v8, v10, v8
	vsetivli	zero, 1, e16, m1, ta, mu
	vmv.s.x	v10, a4
	vsetvli	zero, a0, e8, m2, tu, mu
	vwredsum.vs	v10, v8, v10
	vsetivli	zero, 0, e16, m1, ta, mu
	add	s0, s0, a0
	vmv.x.s	a4, v10
	bne	s0, a1, .LBB2_13
	j	.LBB2_10
.LBB2_14:                               # %for.cond6.preheader.us.us.preheader
	li	t3, 0
	addi	a0, t5, -1
	andi	a1, t5, 3
	sltiu	a6, a0, 3
	andi	t4, t5, -4
	seqz	t0, a1
	addi	a0, a1, -1
	seqz	t1, a0
	addi	a0, a1, -2
	seqz	t2, a0
	vsetvli	a0, zero, e8, m4, ta, mu
	vmv.v.i	v8, 0
	j	.LBB2_16
.LBB2_15:                               # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us137.us
                                        #   in Loop: Header=BB2_16 Depth=1
	addi	t3, t3, 1
	beq	t3, a7, .LBB2_2
.LBB2_16:                               # %for.cond6.preheader.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_18 Depth 2
                                        #       Child Loop BB2_19 Depth 3
                                        #       Child Loop BB2_21 Depth 3
                                        #       Child Loop BB2_23 Depth 3
                                        #       Child Loop BB2_25 Depth 3
                                        #     Child Loop BB2_29 Depth 2
                                        #     Child Loop BB2_32 Depth 2
                                        #     Child Loop BB2_35 Depth 2
	li	a1, 0
	mul	a0, t5, t3
	bnez	a6, .LBB2_27
# %bb.17:                               # %for.cond10.preheader.us.us132.us.preheader
                                        #   in Loop: Header=BB2_16 Depth=1
	li	a1, 0
.LBB2_18:                               # %for.cond10.preheader.us.us132.us
                                        #   Parent Loop BB2_16 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_19 Depth 3
                                        #       Child Loop BB2_21 Depth 3
                                        #       Child Loop BB2_23 Depth 3
                                        #       Child Loop BB2_25 Depth 3
	li	a2, 0
	add	a3, a0, a1
	add	a3, a3, t6
.LBB2_19:                               # %vector.body164
                                        #   Parent Loop BB2_16 Depth=1
                                        #     Parent Loop BB2_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a4, s2, a2
	vsetvli	a4, a4, e8, m4, ta, mu
	mul	a5, a2, s5
	add	a5, a5, a3
	add	a2, a2, a4
	vsse8.v	v8, (a5), s5
	bne	a2, s2, .LBB2_19
# %bb.20:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us121.us.us
                                        #   in Loop: Header=BB2_18 Depth=2
	li	a2, 0
	ori	a3, a1, 1
	add	a3, a3, a0
	add	a3, a3, t6
.LBB2_21:                               # %vector.body164.1
                                        #   Parent Loop BB2_16 Depth=1
                                        #     Parent Loop BB2_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a4, s2, a2
	vsetvli	a4, a4, e8, m4, ta, mu
	mul	a5, a2, s5
	add	a5, a5, a3
	add	a2, a2, a4
	vsse8.v	v8, (a5), s5
	bne	a2, s2, .LBB2_21
# %bb.22:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us121.us.us.1
                                        #   in Loop: Header=BB2_18 Depth=2
	li	a2, 0
	ori	a3, a1, 2
	add	a3, a3, a0
	add	a3, a3, t6
.LBB2_23:                               # %vector.body164.2
                                        #   Parent Loop BB2_16 Depth=1
                                        #     Parent Loop BB2_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a4, s2, a2
	vsetvli	a4, a4, e8, m4, ta, mu
	mul	a5, a2, s5
	add	a5, a5, a3
	add	a2, a2, a4
	vsse8.v	v8, (a5), s5
	bne	a2, s2, .LBB2_23
# %bb.24:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us121.us.us.2
                                        #   in Loop: Header=BB2_18 Depth=2
	li	a2, 0
	ori	a3, a1, 3
	add	a3, a3, a0
	add	a3, a3, t6
.LBB2_25:                               # %vector.body164.3
                                        #   Parent Loop BB2_16 Depth=1
                                        #     Parent Loop BB2_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a4, s2, a2
	vsetvli	a4, a4, e8, m4, ta, mu
	mul	a5, a2, s5
	add	a5, a5, a3
	add	a2, a2, a4
	vsse8.v	v8, (a5), s5
	bne	a2, s2, .LBB2_25
# %bb.26:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us121.us.us.3
                                        #   in Loop: Header=BB2_18 Depth=2
	addi	a1, a1, 4
	bne	a1, t4, .LBB2_18
.LBB2_27:                               # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us137.us.unr-lcssa
                                        #   in Loop: Header=BB2_16 Depth=1
	bnez	t0, .LBB2_15
# %bb.28:                               # %for.cond10.preheader.us.us132.us.epil
                                        #   in Loop: Header=BB2_16 Depth=1
	li	a2, 0
	add	a0, a0, a1
	add	a0, a0, t6
.LBB2_29:                               # %vector.body164.epil
                                        #   Parent Loop BB2_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a1, s2, a2
	vsetvli	a1, a1, e8, m4, ta, mu
	mul	a3, a2, s5
	add	a3, a3, a0
	add	a2, a2, a1
	vsse8.v	v8, (a3), s5
	bne	a2, s2, .LBB2_29
# %bb.30:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us121.us.us.epil
                                        #   in Loop: Header=BB2_16 Depth=1
	bnez	t1, .LBB2_15
# %bb.31:                               # %for.cond10.preheader.us.us132.us.epil.1
                                        #   in Loop: Header=BB2_16 Depth=1
	li	a1, 0
	addi	a2, a0, 1
.LBB2_32:                               # %vector.body164.epil.1
                                        #   Parent Loop BB2_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a3, s2, a1
	vsetvli	a3, a3, e8, m4, ta, mu
	mul	a4, a1, s5
	add	a4, a4, a2
	add	a1, a1, a3
	vsse8.v	v8, (a4), s5
	bne	a1, s2, .LBB2_32
# %bb.33:                               # %for.cond10.for.cond.cleanup12_crit_edge.split.us121.us.us.epil.1
                                        #   in Loop: Header=BB2_16 Depth=1
	bnez	t2, .LBB2_15
# %bb.34:                               # %for.cond10.preheader.us.us132.us.epil.2
                                        #   in Loop: Header=BB2_16 Depth=1
	li	a1, 0
	addi	a0, a0, 2
.LBB2_35:                               # %vector.body164.epil.2
                                        #   Parent Loop BB2_16 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a2, s2, a1
	vsetvli	a2, a2, e8, m4, ta, mu
	mul	a3, a1, s5
	add	a3, a3, a0
	add	a1, a1, a2
	vsse8.v	v8, (a3), s5
	bne	a1, s2, .LBB2_35
	j	.LBB2_15
.Lfunc_end2:
	.size	correlation_golden, .Lfunc_end2-correlation_golden
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %for.cond6.preheader.lr.ph.split.us.split.us.i
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	sw	s1, 52(sp)                      # 4-byte Folded Spill
	sw	s2, 48(sp)                      # 4-byte Folded Spill
	sw	s3, 44(sp)                      # 4-byte Folded Spill
	sw	s4, 40(sp)                      # 4-byte Folded Spill
	sw	s5, 36(sp)                      # 4-byte Folded Spill
	sw	s6, 32(sp)                      # 4-byte Folded Spill
	sw	s7, 28(sp)                      # 4-byte Folded Spill
	sw	s8, 24(sp)                      # 4-byte Folded Spill
	sw	s9, 20(sp)                      # 4-byte Folded Spill
	sw	s10, 16(sp)                     # 4-byte Folded Spill
	sw	s11, 12(sp)                     # 4-byte Folded Spill
	li	a1, 0
	lui	a0, 7
	addi	a0, a0, 896
	sw	a0, 8(sp)                       # 4-byte Folded Spill
	lui	a0, 5
	addi	t2, a0, -768
	lui	a0, 2
	addi	a4, a0, 1664
	#APP
	csrr	a0, mcycle

	#NO_APP
	sw	a0, 0(sp)                       # 4-byte Folded Spill
	lui	a0, %hi(src0_arr_global)
	addi	s2, a0, %lo(src0_arr_global)
	lui	a0, %hi(src1_arr_global)
	addi	s10, a0, %lo(src1_arr_global)
	li	t1, 58
	lui	a0, %hi(out_arr_global)
	addi	s11, a0, %lo(out_arr_global)
	lui	a0, 10
	addi	s3, a0, -1536
	j	.LBB3_2
.LBB3_1:                                # %for.cond6.for.cond.cleanup8_crit_edge.split.us.split.us.us.us.us.i
                                        #   in Loop: Header=BB3_2 Depth=1
	lw	a1, 4(sp)                       # 4-byte Folded Reload
	addi	a1, a1, 1
	li	a0, 112
	beq	a1, a0, .LBB3_22
.LBB3_2:                                # %for.cond6.preheader.us.us.us.i
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_7 Depth 2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_11 Depth 3
                                        #       Child Loop BB3_14 Depth 3
                                        #       Child Loop BB3_17 Depth 3
                                        #       Child Loop BB3_21 Depth 3
	li	t0, 0
	sw	a1, 4(sp)                       # 4-byte Folded Spill
	li	a0, 88
	mul	s8, a1, a0
	addi	s4, s8, -1
	addi	s5, s8, -2
	addi	s6, s8, -3
	addi	s7, s8, -4
	j	.LBB3_7
.LBB3_3:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.1.thread
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a0, s1, s11
	sb	zero, 0(a0)
	add	a6, t4, t2
.LBB3_4:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.2.thread
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a0, a6, s11
	sb	zero, 0(a0)
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	add	a1, t4, a0
.LBB3_5:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.3.thread
                                        #   in Loop: Header=BB3_7 Depth=2
	li	a0, 0
	add	a1, a1, s11
	sb	zero, 0(a1)
.LBB3_6:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.4
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a1, s9, s3
	addi	t0, t0, 1
	sb	a0, 0(a1)
	li	a0, 88
	beq	t0, a0, .LBB3_1
.LBB3_7:                                # %for.body20.us104.us.us.us.us.us.i.preheader
                                        #   Parent Loop BB3_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_8 Depth 3
                                        #       Child Loop BB3_11 Depth 3
                                        #       Child Loop BB3_14 Depth 3
                                        #       Child Loop BB3_17 Depth 3
                                        #       Child Loop BB3_21 Depth 3
	li	s1, 0
	li	a1, 0
	add	t4, s8, t0
	add	a3, t4, s2
	add	a0, t4, s10
	add	t6, s4, t0
	add	a7, s5, t0
	add	a6, s6, t0
	add	a2, s7, t0
	add	ra, a2, s10
.LBB3_8:                                # %vector.body149
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a2, t1, s1
	vsetvli	a2, a2, e8, m2, ta, mu
	mul	s0, s1, a4
	add	a5, a0, s0
	vlse8.v	v8, (a5), a4
	add	a5, a3, s0
	vlse8.v	v10, (a5), a4
	vmul.vv	v8, v10, v8
	vsetivli	zero, 1, e8, m1, ta, mu
	vmv.s.x	v10, a1
	vsetvli	zero, a2, e8, m2, tu, mu
	vredsum.vs	v10, v8, v10
	add	s1, s1, a2
	vmv.x.s	a1, v10
	bne	s1, t1, .LBB3_8
# %bb.9:                                # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i
                                        #   in Loop: Header=BB3_7 Depth=2
	add	s9, t4, s11
	sb	a1, 0(s9)
	add	s1, t4, a4
	beqz	t0, .LBB3_3
# %bb.10:                               # %vector.body120.preheader
                                        #   in Loop: Header=BB3_7 Depth=2
	li	t3, 0
	li	t5, 0
	add	t6, t6, s10
	add	a1, a7, s10
	add	a7, a6, s10
.LBB3_11:                               # %vector.body120
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a0, t1, t3
	vsetvli	a0, a0, e8, m2, ta, mu
	mul	a2, t3, a4
	add	a5, t6, a2
	vlse8.v	v8, (a5), a4
	add	a2, a2, a3
	vlse8.v	v10, (a2), a4
	vmul.vv	v8, v10, v8
	vsetivli	zero, 1, e8, m1, ta, mu
	vmv.s.x	v10, t5
	vsetvli	zero, a0, e8, m2, tu, mu
	vredsum.vs	v10, v8, v10
	add	t3, t3, a0
	vmv.x.s	t5, v10
	bne	t3, t1, .LBB3_11
# %bb.12:                               # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.1
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a0, s1, s11
	sb	t5, 0(a0)
	add	a6, t4, t2
	li	a0, 2
	bltu	t0, a0, .LBB3_4
# %bb.13:                               # %vector.body91.preheader
                                        #   in Loop: Header=BB3_7 Depth=2
	li	s1, 0
	li	a0, 0
.LBB3_14:                               # %vector.body91
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a2, t1, s1
	vsetvli	a2, a2, e8, m2, ta, mu
	mul	a5, s1, a4
	add	s0, a1, a5
	vlse8.v	v8, (s0), a4
	add	a5, a5, a3
	vlse8.v	v10, (a5), a4
	vmul.vv	v8, v10, v8
	vsetivli	zero, 1, e8, m1, ta, mu
	vmv.s.x	v10, a0
	vsetvli	zero, a2, e8, m2, tu, mu
	vredsum.vs	v10, v8, v10
	add	s1, s1, a2
	vmv.x.s	a0, v10
	bne	s1, t1, .LBB3_14
# %bb.15:                               # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.2
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a1, a6, s11
	sb	a0, 0(a1)
	lw	a0, 8(sp)                       # 4-byte Folded Reload
	add	a1, t4, a0
	li	a0, 3
	bltu	t0, a0, .LBB3_5
# %bb.16:                               # %vector.body62.preheader
                                        #   in Loop: Header=BB3_7 Depth=2
	li	a2, 0
	li	a0, 0
.LBB3_17:                               # %vector.body62
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a5, t1, a2
	vsetvli	a5, a5, e8, m2, ta, mu
	mul	s1, a2, a4
	add	s0, a7, s1
	vlse8.v	v8, (s0), a4
	add	s1, s1, a3
	vlse8.v	v10, (s1), a4
	vmul.vv	v8, v10, v8
	vsetivli	zero, 1, e8, m1, ta, mu
	vmv.s.x	v10, a0
	vsetvli	zero, a5, e8, m2, tu, mu
	vredsum.vs	v10, v8, v10
	add	a2, a2, a5
	vmv.x.s	a0, v10
	bne	a2, t1, .LBB3_17
# %bb.18:                               # %for.cond17.for.cond.cleanup19_crit_edge.us.us.us.us.us.us.i.3
                                        #   in Loop: Header=BB3_7 Depth=2
	add	a1, a1, s11
	sb	a0, 0(a1)
	li	a0, 4
	bgeu	t0, a0, .LBB3_20
# %bb.19:                               #   in Loop: Header=BB3_7 Depth=2
	li	a0, 0
	j	.LBB3_6
.LBB3_20:                               # %vector.body.preheader
                                        #   in Loop: Header=BB3_7 Depth=2
	li	a1, 0
	li	a0, 0
.LBB3_21:                               # %vector.body
                                        #   Parent Loop BB3_2 Depth=1
                                        #     Parent Loop BB3_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	sub	a2, t1, a1
	vsetvli	a2, a2, e8, m2, ta, mu
	mul	a5, a1, a4
	add	s1, ra, a5
	vlse8.v	v8, (s1), a4
	add	a5, a5, a3
	vlse8.v	v10, (a5), a4
	vmul.vv	v8, v10, v8
	vsetivli	zero, 1, e8, m1, ta, mu
	vmv.s.x	v10, a0
	vsetvli	zero, a2, e8, m2, tu, mu
	vredsum.vs	v10, v8, v10
	add	a1, a1, a2
	vmv.x.s	a0, v10
	bne	a1, t1, .LBB3_21
	j	.LBB3_6
.LBB3_22:                               # %correlation_golden.exit
	#APP
	csrr	a0, mcycle

	#NO_APP
	lw	a1, 0(sp)                       # 4-byte Folded Reload
	sub	a1, a0, a1
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	lw	s1, 52(sp)                      # 4-byte Folded Reload
	lw	s2, 48(sp)                      # 4-byte Folded Reload
	lw	s3, 44(sp)                      # 4-byte Folded Reload
	lw	s4, 40(sp)                      # 4-byte Folded Reload
	lw	s5, 36(sp)                      # 4-byte Folded Reload
	lw	s6, 32(sp)                      # 4-byte Folded Reload
	lw	s7, 28(sp)                      # 4-byte Folded Reload
	lw	s8, 24(sp)                      # 4-byte Folded Reload
	lw	s9, 20(sp)                      # 4-byte Folded Reload
	lw	s10, 16(sp)                     # 4-byte Folded Reload
	lw	s11, 12(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.type	src0_arr_global,@object         # @src0_arr_global
	.data
	.globl	src0_arr_global
	.p2align	2
src0_arr_global:
	.byte	1                               # 0x1
	.zero	571647
	.size	src0_arr_global, 571648

	.type	src1_arr_global,@object         # @src1_arr_global
	.globl	src1_arr_global
	.p2align	2
src1_arr_global:
	.byte	1                               # 0x1
	.zero	571647
	.size	src1_arr_global, 571648

	.type	out_arr_global,@object          # @out_arr_global
	.bss
	.globl	out_arr_global
	.p2align	2
out_arr_global:
	.zero	49280
	.size	out_arr_global, 49280

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.4,"aMS",@progbits,1
	.p2align	2
.L.str:
	.asciz	"correlation_58x112x88_test running cycles : %d.\n"
	.size	.L.str, 49

	.ident	"Terapines LTD zcc version 2.0.0 (https://www.terapines.com d82a1442dfd98f60f08014f36ba57878ee901dfd)"
	.section	".note.GNU-stack","",@progbits
