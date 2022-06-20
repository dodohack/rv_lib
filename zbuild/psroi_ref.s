	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10"
	.option	nopic
	.file	"psroi_ref.c"
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
	.globl	global_arr_init                 # -- Begin function global_arr_init
	.p2align	2
	.type	global_arr_init,@function
global_arr_init:                        # @global_arr_init
# %bb.0:                                # %entry
	li	a0, 0
	vsetvli	a1, zero, e8, m4, ta, mu
	vid.v	v8
	lui	a1, 88
	addi	a1, a1, 192
	li	a2, 63
	lui	a3, %hi(src_arr_global)
	addi	a3, a3, %lo(src_arr_global)
.LBB1_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	sub	a4, a1, a0
	vsetvli	a4, a4, e8, m4, ta, mu
	vand.vx	v12, v8, a2
	add	a5, a0, a3
	vse8.v	v12, (a5)
	add	a0, a0, a4
	vsetvli	a5, zero, e8, m4, ta, mu
	vadd.vx	v8, v8, a4
	bne	a0, a1, .LBB1_1
# %bb.2:                                # %vector.body58.preheader
	li	a0, 0
	li	a6, 150
	lui	a2, %hi(rois_arr_global)
	addi	a2, a2, %lo(rois_arr_global)
	vsetvli	a3, zero, e16, m4, ta, mu
	vmv.v.i	v8, 1
	li	a3, 16
	vmv.v.i	v12, 11
	vmv.v.i	v16, 2
	vmv.v.x	v20, a3
.LBB1_3:                                # %vector.body58
                                        # =>This Inner Loop Header: Depth=1
	sub	a4, a6, a0
	vsetvli	a4, a4, e16, m4, ta, mu
	slli	a5, a0, 4
	add	a5, a5, a2
	vsse16.v	v8, (a5), a3
	addi	a1, a5, 2
	vsse16.v	v8, (a1), a3
	addi	a1, a5, 4
	vsse16.v	v12, (a1), a3
	addi	a1, a5, 6
	vsse16.v	v12, (a1), a3
	addi	a1, a5, 8
	vsse16.v	v16, (a1), a3
	addi	a1, a5, 10
	vsse16.v	v16, (a1), a3
	addi	a1, a5, 12
	vsse16.v	v20, (a1), a3
	addi	a1, a5, 14
	add	a0, a0, a4
	vsse16.v	v20, (a1), a3
	bne	a0, a6, .LBB1_3
# %bb.4:                                # %for.cond.cleanup4
	ret
.Lfunc_end1:
	.size	global_arr_init, .Lfunc_end1-global_arr_init
                                        # -- End function
	.globl	psroi_param_read                # -- Begin function psroi_param_read
	.p2align	2
	.type	psroi_param_read,@function
psroi_param_read:                       # @psroi_param_read
# %bb.0:                                # %entry
	lw	a2, 8(a1)
	sw	a2, 12(a0)
	lw	a2, 12(a1)
	sw	a2, 16(a0)
	lw	a2, 16(a1)
	sw	a2, 20(a0)
	lw	a2, 20(a1)
	sw	a2, 24(a0)
	lw	a2, 24(a1)
	sw	a2, 28(a0)
	lw	a2, 28(a1)
	sw	a2, 32(a0)
	lw	a1, 32(a1)
	srli	a2, a1, 16
	sb	a2, 36(a0)
	sb	a1, 37(a0)
	lui	a1, %hi(src_arr_global)
	addi	a1, a1, %lo(src_arr_global)
	sw	a1, 0(a0)
	lui	a1, %hi(rois_arr_global)
	addi	a1, a1, %lo(rois_arr_global)
	sw	a1, 4(a0)
	lui	a1, %hi(out_arr_global)
	addi	a1, a1, %lo(out_arr_global)
	sw	a1, 8(a0)
	ret
.Lfunc_end2:
	.size	psroi_param_read, .Lfunc_end2-psroi_param_read
                                        # -- End function
	.globl	psroi_align_golden              # -- Begin function psroi_align_golden
	.p2align	2
	.type	psroi_align_golden,@function
psroi_align_golden:                     # @psroi_align_golden
# %bb.0:                                # %entry
	addi	sp, sp, -128
	sw	ra, 124(sp)                     # 4-byte Folded Spill
	sw	s0, 120(sp)                     # 4-byte Folded Spill
	sw	s1, 116(sp)                     # 4-byte Folded Spill
	sw	s2, 112(sp)                     # 4-byte Folded Spill
	sw	s3, 108(sp)                     # 4-byte Folded Spill
	sw	s4, 104(sp)                     # 4-byte Folded Spill
	sw	s5, 100(sp)                     # 4-byte Folded Spill
	sw	s6, 96(sp)                      # 4-byte Folded Spill
	sw	s7, 92(sp)                      # 4-byte Folded Spill
	sw	s8, 88(sp)                      # 4-byte Folded Spill
	sw	s9, 84(sp)                      # 4-byte Folded Spill
	sw	s10, 80(sp)                     # 4-byte Folded Spill
	sw	s11, 76(sp)                     # 4-byte Folded Spill
	sw	a5, 64(sp)                      # 4-byte Folded Spill
	sw	a2, 72(sp)                      # 4-byte Folded Spill
	sw	a1, 44(sp)                      # 4-byte Folded Spill
	sw	a0, 40(sp)                      # 4-byte Folded Spill
	beqz	a3, .LBB3_50
# %bb.1:                                # %for.body.lr.ph
	mv	t4, a7
	beqz	a7, .LBB3_50
# %bb.2:                                # %for.body.lr.ph.split.us
	lw	a0, 136(sp)
	divu	a2, a4, a6
	mul	a1, a2, a6
	sub	a1, a4, a1
	li	t3, 1
	andi	a4, a0, 255
	lui	a0, 16
	addi	t1, a0, -1
	sw	a1, 32(sp)                      # 4-byte Folded Spill
	and	a7, a1, t1
	sw	a2, 36(sp)                      # 4-byte Folded Spill
	and	t2, a2, t1
	beqz	a4, .LBB3_29
# %bb.3:                                # %for.body.us.us.preheader
	lw	a0, 140(sp)
	li	t5, 0
	lw	t6, 132(sp)
	lw	a1, 128(sp)
	andi	s0, a0, 255
	sll	s8, t3, a0
	li	a2, 256
	divu	a5, a2, a6
	sw	a5, 20(sp)                      # 4-byte Folded Spill
	lw	a5, 64(sp)                      # 4-byte Folded Reload
	divu	a2, a2, a5
	sw	a2, 16(sp)                      # 4-byte Folded Spill
	slli	a2, a4, 1
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	slli	a2, a1, 16
	srai	s5, a2, 16
	addi	s6, s5, -1
	sll	s7, s6, a0
	slli	a2, t6, 16
	srai	a2, a2, 16
	addi	s1, a2, -1
	sll	s9, s1, a0
	mul	a0, t6, a1
	sw	a0, 52(sp)                      # 4-byte Folded Spill
	sw	a3, 28(sp)                      # 4-byte Folded Spill
	sw	t4, 60(sp)                      # 4-byte Folded Spill
	sw	t1, 24(sp)                      # 4-byte Folded Spill
	sw	t2, 56(sp)                      # 4-byte Folded Spill
	j	.LBB3_5
.LBB3_4:                                # %for.cond56.for.cond.cleanup59_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB3_5 Depth=1
	lw	t5, 48(sp)                      # 4-byte Folded Reload
	addi	t5, t5, 1
	lw	a3, 28(sp)                      # 4-byte Folded Reload
	lw	t1, 24(sp)                      # 4-byte Folded Reload
	beq	t5, a3, .LBB3_50
.LBB3_5:                                # %for.body.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_11 Depth 2
                                        #       Child Loop BB3_13 Depth 3
                                        #         Child Loop BB3_25 Depth 4
                                        #         Child Loop BB3_22 Depth 4
	slli	a0, t5, 3
	lw	a1, 44(sp)                      # 4-byte Folded Reload
	add	a3, a1, a0
	lh	t0, 0(a3)
	lh	a1, 4(a3)
	sub	a1, a1, t0
	and	a2, a1, t1
	mv	a1, s8
	blt	a2, s8, .LBB3_7
# %bb.6:                                # %for.body.us.us
                                        #   in Loop: Header=BB3_5 Depth=1
	mv	a1, a2
.LBB3_7:                                # %for.body.us.us
                                        #   in Loop: Header=BB3_5 Depth=1
	lh	a2, 2(a3)
	lh	a3, 6(a3)
	sub	a3, a3, a2
	and	a5, a3, t1
	mv	a3, s8
	blt	a5, s8, .LBB3_9
# %bb.8:                                # %for.body.us.us
                                        #   in Loop: Header=BB3_5 Depth=1
	mv	a3, a5
.LBB3_9:                                # %for.body.us.us
                                        #   in Loop: Header=BB3_5 Depth=1
	li	s11, 0
	lw	a0, 20(sp)                      # 4-byte Folded Reload
	mul	a1, a1, a0
	slli	a1, a1, 16
	srli	a1, a1, 24
	lw	a0, 16(sp)                      # 4-byte Folded Reload
	mul	a3, a3, a0
	slli	a3, a3, 16
	srli	a3, a3, 24
	lw	a0, 12(sp)                      # 4-byte Folded Reload
	divu	a5, a1, a0
	divu	ra, a3, a0
	lw	a0, 36(sp)                      # 4-byte Folded Reload
	mul	a3, a3, a0
	add	t1, a3, a2
	sw	t5, 48(sp)                      # 4-byte Folded Spill
	mul	a0, t5, t4
	sw	a0, 68(sp)                      # 4-byte Folded Spill
	add	a2, a5, t0
	slli	a0, a5, 1
	lw	a3, 32(sp)                      # 4-byte Folded Reload
	mul	a1, a1, a3
	add	t0, a2, a1
	lw	s2, 40(sp)                      # 4-byte Folded Reload
	j	.LBB3_11
.LBB3_10:                               # %for.cond70.for.cond.cleanup73_crit_edge.us.us.us
                                        #   in Loop: Header=BB3_11 Depth=2
	lw	t2, 56(sp)                      # 4-byte Folded Reload
	add	a1, s10, t2
	mv	a6, t4
	mul	a1, a1, t4
	add	a1, a1, a7
	srli	a2, s3, 2
	slli	a1, a1, 1
	lw	a3, 72(sp)                      # 4-byte Folded Reload
	add	a1, a1, a3
	sh	a2, 0(a1)
	addi	s11, s11, 1
	lw	a1, 52(sp)                      # 4-byte Folded Reload
	add	s2, s2, a1
	lw	t4, 60(sp)                      # 4-byte Folded Reload
	beq	s11, t4, .LBB3_4
.LBB3_11:                               # %for.body60.us.us.us
                                        #   Parent Loop BB3_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_13 Depth 3
                                        #         Child Loop BB3_25 Depth 4
                                        #         Child Loop BB3_22 Depth 4
	mv	t4, a6
	li	t3, 0
	li	s3, 0
	lw	a1, 68(sp)                      # 4-byte Folded Reload
	add	a1, a1, s11
	lw	a2, 64(sp)                      # 4-byte Folded Reload
	mul	s10, a1, a2
	j	.LBB3_13
.LBB3_12:                               # %for.cond84.for.cond.cleanup87_crit_edge.us.us.us
                                        #   in Loop: Header=BB3_13 Depth=3
	addi	t3, t3, 1
	beq	t3, a4, .LBB3_10
.LBB3_13:                               # %for.body74.us.us.us
                                        #   Parent Loop BB3_5 Depth=1
                                        #     Parent Loop BB3_11 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB3_25 Depth 4
                                        #         Child Loop BB3_22 Depth 4
	slli	a1, t3, 1
	ori	a1, a1, 1
	mul	a1, a1, ra
	add	a1, a1, t1
	slli	a1, a1, 16
	srai	a5, a1, 16
	vsetvli	a1, zero, e16, m2, ta, mu
	mv	a2, a5
	bgtz	a5, .LBB3_15
# %bb.14:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB3_13 Depth=3
	li	a2, 0
.LBB3_15:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB3_13 Depth=3
	slli	a1, a2, 16
	srli	a1, a1, 16
	srl	a3, a1, s0
	blt	a3, s6, .LBB3_17
# %bb.16:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB3_13 Depth=3
	mv	a6, s6
	mv	a1, s6
	bge	s6, a3, .LBB3_18
	j	.LBB3_19
.LBB3_17:                               #   in Loop: Header=BB3_13 Depth=3
	addi	a6, a3, 1
	mv	a1, s6
	blt	s6, a3, .LBB3_19
.LBB3_18:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB3_13 Depth=3
	mv	a1, a3
.LBB3_19:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB3_13 Depth=3
	bge	a3, s6, .LBB3_23
# %bb.20:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB3_13 Depth=3
	sra	a3, a5, s0
	bge	a3, s5, .LBB3_24
.LBB3_21:                               # %for.body88.us.us.us.us.preheader
                                        #   in Loop: Header=BB3_13 Depth=3
	li	s4, 0
	sll	a3, a1, s0
	sub	t5, a2, a3
	sub	t2, s8, t5
	mul	a2, a1, t6
	mul	a5, a6, t6
	vid.v	v10
.LBB3_22:                               # %for.body88.us.us.us.us
                                        #   Parent Loop BB3_5 Depth=1
                                        #     Parent Loop BB3_11 Depth=2
                                        #       Parent Loop BB3_13 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	sub	a1, a4, s4
	vsetvli	a6, a1, e16, m2, ta, mu
	vmul.vx	v8, v10, a0
	vadd.vx	v12, v8, t0
	vsra.vx	v14, v12, s0
	vmslt.vx	v8, v14, t6
	vmax.vx	v12, v12, zero
	vsra.vx	v14, v12, s0
	vmslt.vx	v9, v14, s1
	vmnand.mm	v0, v9, v9
	vadd.vi	v16, v14, 1
	vmerge.vxm	v16, v16, s1, v0
	vmerge.vxm	v14, v14, s1, v0
	vmerge.vxm	v12, v12, s9, v0
	vsll.vx	v18, v14, s0
	vsub.vv	v12, v12, v18
	vrsub.vx	v18, v12, s8
	vwadd.vx	v20, v14, a2
	vsetvli	zero, a6, e8, m1, ta, mu
	vloxei32.v	v9, (s2), v20
	vwaddu.vx	v20, v9, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vwadd.vx	v24, v16, a2
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei32.v	v9, (s2), v24
	vwaddu.vx	v22, v9, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vwadd.vx	v24, v14, a5
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei32.v	v9, (s2), v24
	vwaddu.vx	v14, v9, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vwadd.vx	v24, v16, a5
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei32.v	v9, (s2), v24
	vwaddu.vx	v16, v9, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vmul.vx	v24, v18, t2
	vsrl.vx	v24, v24, s0
	vmul.vx	v26, v12, t2
	vsrl.vx	v26, v26, s0
	vmul.vx	v18, v18, t5
	vsrl.vx	v18, v18, s0
	vmul.vx	v12, v12, t5
	vsrl.vx	v12, v12, s0
	vwmulu.vv	v28, v24, v20
	vwmulu.vv	v0, v26, v22
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vv	v20, v28, v0
	vsetvli	zero, zero, e16, m2, ta, mu
	vwmulu.vv	v24, v18, v14
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vv	v20, v20, v24
	vsetvli	zero, zero, e16, m2, ta, mu
	vwmulu.vv	v24, v12, v16
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vv	v12, v20, v24
	vsrl.vx	v12, v12, s0
	vsetvli	zero, a6, e32, m1, ta, mu
	vmv.s.x	v9, zero
	vsetvli	zero, a6, e32, m4, tu, mu
	vmv1r.v	v0, v8
	vredsum.vs	v9, v12, v9, v0.t
	vmv.x.s	a1, v9
	add	s3, s3, a1
	vsetvli	zero, zero, e16, m2, ta, mu
	add	s4, s4, a6
	vadd.vx	v10, v10, a6
	blt	s4, a4, .LBB3_22
	j	.LBB3_12
.LBB3_23:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB3_13 Depth=3
	mv	a2, s7
	sra	a3, a5, s0
	blt	a3, s5, .LBB3_21
.LBB3_24:                               # %for.body88.us212.us.us.preheader
                                        #   in Loop: Header=BB3_13 Depth=3
	li	a1, 0
.LBB3_25:                               # %for.body88.us212.us.us
                                        #   Parent Loop BB3_5 Depth=1
                                        #     Parent Loop BB3_11 Depth=2
                                        #       Parent Loop BB3_13 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	sub	a2, a4, a1
	vsetvli	a2, a2, e16, m2, ta, mu
	add	a1, a1, a2
	bge	a1, a4, .LBB3_12
# %bb.26:                               # %for.body88.us212.us.us.1
                                        #   in Loop: Header=BB3_25 Depth=4
	sub	a2, a4, a1
	vsetvli	a2, a2, e16, m2, ta, mu
	add	a1, a1, a2
	bge	a1, a4, .LBB3_12
# %bb.27:                               # %for.body88.us212.us.us.2
                                        #   in Loop: Header=BB3_25 Depth=4
	sub	a2, a4, a1
	vsetvli	a2, a2, e16, m2, ta, mu
	add	a1, a1, a2
	bge	a1, a4, .LBB3_12
# %bb.28:                               # %for.body88.us212.us.us.3
                                        #   in Loop: Header=BB3_25 Depth=4
	sub	a2, a4, a1
	vsetvli	a2, a2, e16, m2, ta, mu
	add	a1, a1, a2
	blt	a1, a4, .LBB3_25
	j	.LBB3_12
.LBB3_29:                               # %for.body.us.preheader
	mul	a0, t2, a6
	add	t2, a0, a7
	mul	a0, t4, a6
	lw	a2, 64(sp)                      # 4-byte Folded Reload
	mul	a1, a0, a2
	mul	a0, a6, a2
	slli	a0, a0, 1
	addi	a2, a3, -1
	andi	t0, a3, 3
	li	a4, 3
	vsetvli	s1, zero, e16, m8, ta, mu
	vmv.v.i	v8, 0
	bgeu	a2, a4, .LBB3_31
# %bb.30:
	li	a4, 0
	j	.LBB3_41
.LBB3_31:                               # %for.body.us.preheader.new
	li	a4, 0
	andi	t1, a3, -4
.LBB3_32:                               # %vector.ph
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_33 Depth 2
                                        #     Child Loop BB3_35 Depth 2
                                        #     Child Loop BB3_37 Depth 2
                                        #     Child Loop BB3_39 Depth 2
	li	a2, 0
	mul	s1, a1, a4
	add	s1, s1, t2
	slli	s1, s1, 1
	lw	a5, 72(sp)                      # 4-byte Folded Reload
	add	s1, s1, a5
.LBB3_33:                               # %vector.body
                                        #   Parent Loop BB3_32 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a5, t4, a2
	vsetvli	a5, a5, e16, m8, ta, mu
	mul	s0, a2, a0
	add	s0, s0, s1
	add	a2, a2, a5
	vsse16.v	v8, (s0), a0
	bne	a2, t4, .LBB3_33
# %bb.34:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us237
                                        #   in Loop: Header=BB3_32 Depth=1
	li	a2, 0
	ori	a5, a4, 1
	mul	a5, a1, a5
	add	a5, a5, t2
	slli	a5, a5, 1
	lw	s1, 72(sp)                      # 4-byte Folded Reload
	add	s1, s1, a5
.LBB3_35:                               # %vector.body.1
                                        #   Parent Loop BB3_32 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a5, t4, a2
	vsetvli	a5, a5, e16, m8, ta, mu
	mul	s0, a2, a0
	add	s0, s0, s1
	add	a2, a2, a5
	vsse16.v	v8, (s0), a0
	bne	a2, t4, .LBB3_35
# %bb.36:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us237.1
                                        #   in Loop: Header=BB3_32 Depth=1
	li	a2, 0
	ori	a5, a4, 2
	mul	a5, a1, a5
	add	a5, a5, t2
	slli	a5, a5, 1
	lw	s1, 72(sp)                      # 4-byte Folded Reload
	add	s1, s1, a5
.LBB3_37:                               # %vector.body.2
                                        #   Parent Loop BB3_32 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a5, t4, a2
	vsetvli	a5, a5, e16, m8, ta, mu
	mul	s0, a2, a0
	add	s0, s0, s1
	add	a2, a2, a5
	vsse16.v	v8, (s0), a0
	bne	a2, t4, .LBB3_37
# %bb.38:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us237.2
                                        #   in Loop: Header=BB3_32 Depth=1
	li	a2, 0
	ori	a5, a4, 3
	mul	a5, a1, a5
	add	a5, a5, t2
	slli	a5, a5, 1
	lw	s1, 72(sp)                      # 4-byte Folded Reload
	add	s1, s1, a5
.LBB3_39:                               # %vector.body.3
                                        #   Parent Loop BB3_32 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a5, t4, a2
	vsetvli	a5, a5, e16, m8, ta, mu
	mul	s0, a2, a0
	add	s0, s0, s1
	add	a2, a2, a5
	vsse16.v	v8, (s0), a0
	bne	a2, t4, .LBB3_39
# %bb.40:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us237.3
                                        #   in Loop: Header=BB3_32 Depth=1
	addi	a4, a4, 4
	bne	a4, t1, .LBB3_32
.LBB3_41:                               # %for.cond.cleanup.loopexit.unr-lcssa
	beqz	t0, .LBB3_50
# %bb.42:                               # %vector.ph.epil
	li	a2, 0
	mul	a5, a1, a4
	add	a5, a5, t2
	slli	a5, a5, 1
	lw	s1, 72(sp)                      # 4-byte Folded Reload
	add	s1, s1, a5
.LBB3_43:                               # %vector.body.epil
                                        # =>This Inner Loop Header: Depth=1
	sub	a5, t4, a2
	vsetvli	a5, a5, e16, m8, ta, mu
	mul	s0, a2, a0
	add	s0, s0, s1
	add	a2, a2, a5
	vsse16.v	v8, (s0), a0
	bne	a2, t4, .LBB3_43
# %bb.44:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us237.epil
	beq	t0, t3, .LBB3_50
# %bb.45:                               # %vector.ph.epil.1
	li	a2, 0
	addi	a5, a4, 1
	mul	a5, a1, a5
	add	a5, a5, t2
	slli	a5, a5, 1
	lw	s1, 72(sp)                      # 4-byte Folded Reload
	add	s1, s1, a5
.LBB3_46:                               # %vector.body.epil.1
                                        # =>This Inner Loop Header: Depth=1
	sub	a5, t4, a2
	vsetvli	a5, a5, e16, m8, ta, mu
	mul	s0, a2, a0
	add	s0, s0, s1
	add	a2, a2, a5
	vsse16.v	v8, (s0), a0
	bne	a2, t4, .LBB3_46
# %bb.47:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us237.epil.1
	li	a2, 2
	beq	t0, a2, .LBB3_50
# %bb.48:                               # %vector.ph.epil.2
	li	a2, 0
	addi	a4, a4, 2
	mul	a3, a1, a4
	add	a1, t2, a3
	slli	a1, a1, 1
	lw	a3, 72(sp)                      # 4-byte Folded Reload
	add	a1, a1, a3
.LBB3_49:                               # %vector.body.epil.2
                                        # =>This Inner Loop Header: Depth=1
	sub	a3, t4, a2
	vsetvli	a3, a3, e16, m8, ta, mu
	mul	a4, a2, a0
	add	a4, a4, a1
	add	a2, a2, a3
	vsse16.v	v8, (a4), a0
	bne	a2, t4, .LBB3_49
.LBB3_50:                               # %for.cond.cleanup
	lw	ra, 124(sp)                     # 4-byte Folded Reload
	lw	s0, 120(sp)                     # 4-byte Folded Reload
	lw	s1, 116(sp)                     # 4-byte Folded Reload
	lw	s2, 112(sp)                     # 4-byte Folded Reload
	lw	s3, 108(sp)                     # 4-byte Folded Reload
	lw	s4, 104(sp)                     # 4-byte Folded Reload
	lw	s5, 100(sp)                     # 4-byte Folded Reload
	lw	s6, 96(sp)                      # 4-byte Folded Reload
	lw	s7, 92(sp)                      # 4-byte Folded Reload
	lw	s8, 88(sp)                      # 4-byte Folded Reload
	lw	s9, 84(sp)                      # 4-byte Folded Reload
	lw	s10, 80(sp)                     # 4-byte Folded Reload
	lw	s11, 76(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 128
	ret
.Lfunc_end3:
	.size	psroi_align_golden, .Lfunc_end3-psroi_align_golden
                                        # -- End function
	.globl	psroi_pooling_align_golden      # -- Begin function psroi_pooling_align_golden
	.p2align	2
	.type	psroi_pooling_align_golden,@function
psroi_pooling_align_golden:             # @psroi_pooling_align_golden
# %bb.0:                                # %entry
	addi	sp, sp, -80
	sw	ra, 76(sp)                      # 4-byte Folded Spill
	sw	s0, 72(sp)                      # 4-byte Folded Spill
	sw	s1, 68(sp)                      # 4-byte Folded Spill
	sw	s2, 64(sp)                      # 4-byte Folded Spill
	sw	s3, 60(sp)                      # 4-byte Folded Spill
	sw	s4, 56(sp)                      # 4-byte Folded Spill
	sw	s5, 52(sp)                      # 4-byte Folded Spill
	sw	s6, 48(sp)                      # 4-byte Folded Spill
	sw	s7, 44(sp)                      # 4-byte Folded Spill
	sw	s8, 40(sp)                      # 4-byte Folded Spill
	sw	s9, 36(sp)                      # 4-byte Folded Spill
	sw	s10, 32(sp)                     # 4-byte Folded Spill
	sw	s11, 28(sp)                     # 4-byte Folded Spill
	lw	s8, 16(a0)
	lw	s4, 20(a0)
	mul	s5, s4, s8
	beqz	s5, .LBB4_3
# %bb.1:                                # %for.body.lr.ph
	lw	a2, 4(a0)
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	lw	a2, 8(a0)
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	lw	s6, 12(a0)
	lw	s7, 24(a0)
	lw	s9, 28(a0)
	lw	s10, 32(a0)
	lbu	s11, 36(a0)
	lbu	s2, 37(a0)
	lw	s0, 0(a0)
	li	s1, 0
	mul	a0, s9, s7
	mul	s3, a0, s10
.LBB4_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	sw	s2, 12(sp)
	sw	s11, 8(sp)
	sw	s10, 4(sp)
	sw	s9, 0(sp)
	mv	a0, s0
	lw	a1, 24(sp)                      # 4-byte Folded Reload
	lw	a2, 20(sp)                      # 4-byte Folded Reload
	mv	a3, s6
	mv	a4, s1
	mv	a5, s8
	mv	a6, s4
	mv	a7, s7
	call	psroi_align_golden
	addi	s1, s1, 1
	add	s0, s0, s3
	bne	s5, s1, .LBB4_2
.LBB4_3:                                # %for.cond.cleanup
	lw	ra, 76(sp)                      # 4-byte Folded Reload
	lw	s0, 72(sp)                      # 4-byte Folded Reload
	lw	s1, 68(sp)                      # 4-byte Folded Reload
	lw	s2, 64(sp)                      # 4-byte Folded Reload
	lw	s3, 60(sp)                      # 4-byte Folded Reload
	lw	s4, 56(sp)                      # 4-byte Folded Reload
	lw	s5, 52(sp)                      # 4-byte Folded Reload
	lw	s6, 48(sp)                      # 4-byte Folded Reload
	lw	s7, 44(sp)                      # 4-byte Folded Reload
	lw	s8, 40(sp)                      # 4-byte Folded Reload
	lw	s9, 36(sp)                      # 4-byte Folded Reload
	lw	s10, 32(sp)                     # 4-byte Folded Reload
	lw	s11, 28(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 80
	ret
.Lfunc_end4:
	.size	psroi_pooling_align_golden, .Lfunc_end4-psroi_pooling_align_golden
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
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
	li	a0, 0
	vsetvli	a1, zero, e8, m4, ta, mu
	vid.v	v8
	lui	a1, 88
	addi	a1, a1, 192
	li	a2, 63
	lui	a3, %hi(src_arr_global)
	addi	s0, a3, %lo(src_arr_global)
.LBB5_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	sub	a3, a1, a0
	vsetvli	a3, a3, e8, m4, ta, mu
	vand.vx	v12, v8, a2
	add	a4, a0, s0
	vse8.v	v12, (a4)
	add	a0, a0, a3
	vsetvli	a4, zero, e8, m4, ta, mu
	vadd.vx	v8, v8, a3
	bne	a0, a1, .LBB5_1
# %bb.2:                                # %vector.body58.preheader
	li	a0, 0
	li	a1, 150
	lui	a2, %hi(rois_arr_global)
	addi	s2, a2, %lo(rois_arr_global)
	vsetvli	a2, zero, e16, m4, ta, mu
	vmv.v.i	v8, 1
	li	a2, 16
	vmv.v.i	v12, 11
	vmv.v.i	v16, 2
	vmv.v.x	v20, a2
.LBB5_3:                                # %vector.body58
                                        # =>This Inner Loop Header: Depth=1
	sub	a3, a1, a0
	vsetvli	a3, a3, e16, m4, ta, mu
	slli	a4, a0, 4
	add	a4, a4, s2
	vsse16.v	v8, (a4), a2
	addi	a5, a4, 2
	vsse16.v	v8, (a5), a2
	addi	a5, a4, 4
	vsse16.v	v12, (a5), a2
	addi	a5, a4, 6
	vsse16.v	v12, (a5), a2
	addi	a5, a4, 8
	vsse16.v	v16, (a5), a2
	addi	a5, a4, 10
	vsse16.v	v16, (a5), a2
	addi	a5, a4, 12
	vsse16.v	v20, (a5), a2
	addi	a4, a4, 14
	add	a0, a0, a3
	vsse16.v	v20, (a4), a2
	bne	a0, a1, .LBB5_3
# %bb.4:                                # %for.body.lr.ph.i
	li	s1, 0
	#APP
	csrr	s4, mcycle

	#NO_APP
	li	s5, 2
	li	s6, 40
	li	s7, 23
	lui	a0, %hi(out_arr_global)
	addi	s3, a0, %lo(out_arr_global)
	lui	a0, 2
	addi	s8, a0, -832
	li	s9, 49
.LBB5_5:                                # %for.body.i23
                                        # =>This Inner Loop Header: Depth=1
	sw	zero, 12(sp)
	sw	s5, 8(sp)
	sw	s6, 4(sp)
	li	a3, 300
	li	a5, 7
	li	a6, 7
	li	a7, 8
	sw	s7, 0(sp)
	mv	a0, s0
	mv	a1, s2
	mv	a2, s3
	mv	a4, s1
	call	psroi_align_golden
	addi	s1, s1, 1
	add	s0, s0, s8
	bne	s1, s9, .LBB5_5
# %bb.6:                                # %psroi_pooling_align_golden.exit
	#APP
	csrr	a0, mcycle

	#NO_APP
	sub	a1, a0, s4
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
	addi	sp, sp, 64
	ret
.Lfunc_end5:
	.size	main, .Lfunc_end5-main
                                        # -- End function
	.type	src_arr_global,@object          # @src_arr_global
	.data
	.globl	src_arr_global
	.p2align	2
src_arr_global:
	.byte	8                               # 0x8
	.zero	360639
	.size	src_arr_global, 360640

	.type	rois_arr_global,@object         # @rois_arr_global
	.bss
	.globl	rois_arr_global
	.p2align	2
rois_arr_global:
	.zero	2400
	.size	rois_arr_global, 2400

	.type	out_arr_global,@object          # @out_arr_global
	.globl	out_arr_global
	.p2align	2
out_arr_global:
	.zero	235200
	.size	out_arr_global, 235200

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.4,"aMS",@progbits,1
	.p2align	2
.L.str:
	.asciz	"psroi_23x40x392x300 running cycles : %d.\n"
	.size	.L.str, 42

	.ident	"Terapines LTD zcc version 2.0.0 (https://www.terapines.com d82a1442dfd98f60f08014f36ba57878ee901dfd)"
	.section	".note.GNU-stack","",@progbits
