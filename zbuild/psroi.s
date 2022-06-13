	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10"
	.option	nopic
	.file	"psroi_v1_golden.c"
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
	.globl	bilinear_interpolate            # -- Begin function bilinear_interpolate
	.p2align	2
	.type	bilinear_interpolate,@function
bilinear_interpolate:                   # @bilinear_interpolate
# %bb.0:                                # %entry
	sra	a6, a3, a5
	slt	a6, a6, a1
	sra	a7, a4, a5
	slt	a7, a7, a2
	and	a7, a6, a7
	li	a6, 0
	beqz	a7, .LBB3_18
# %bb.1:                                # %if.end
	blez	a3, .LBB3_5
# %bb.2:                                # %if.end
	lui	a6, 16
	addi	a6, a6, -1
	and	a7, a3, a6
	blez	a4, .LBB3_6
.LBB3_3:                                # %if.end
	srl	t0, a7, a5
	addi	a1, a1, -1
	blt	t0, a1, .LBB3_7
.LBB3_4:                                # %if.end
	mv	a7, a1
	and	t2, a4, a6
	mv	t1, a1
	bge	a1, t0, .LBB3_8
	j	.LBB3_9
.LBB3_5:                                # %if.end
	li	a3, 0
	lui	a6, 16
	addi	a6, a6, -1
	and	a7, a3, a6
	bgtz	a4, .LBB3_3
.LBB3_6:                                # %if.end
	li	a4, 0
	srl	t0, a7, a5
	addi	a1, a1, -1
	bge	t0, a1, .LBB3_4
.LBB3_7:
	addi	a7, t0, 1
	and	t2, a4, a6
	mv	t1, a1
	blt	a1, t0, .LBB3_9
.LBB3_8:                                # %if.end
	mv	t1, t0
.LBB3_9:                                # %if.end
	srl	t3, t2, a5
	bge	t0, a1, .LBB3_12
# %bb.10:                               # %if.end
	addi	a1, a2, -1
	blt	t3, a1, .LBB3_13
.LBB3_11:                               # %if.end
	mv	t0, a1
	mv	t2, a1
	bge	a1, t3, .LBB3_14
	j	.LBB3_15
.LBB3_12:                               # %if.end
	sll	a3, a1, a5
	addi	a1, a2, -1
	bge	t3, a1, .LBB3_11
.LBB3_13:
	addi	t0, t3, 1
	mv	t2, a1
	blt	a1, t3, .LBB3_15
.LBB3_14:                               # %if.end
	mv	t2, t3
.LBB3_15:                               # %if.end
	blt	t3, a1, .LBB3_17
# %bb.16:                               # %if.end
	sll	a4, a1, a5
.LBB3_17:                               # %if.end
	sll	a1, t1, a5
	sub	t5, a3, a1
	sll	a3, t2, a5
	sub	a3, a4, a3
	li	a4, 1
	sll	a4, a4, a5
	sub	t3, a4, t5
	sub	t4, a4, a3
	mul	a4, t1, a2
	add	a1, a4, t2
	add	a1, a1, a0
	lbu	t1, 0(a1)
	add	a4, a4, t0
	add	a4, a4, a0
	lbu	t6, 0(a4)
	mul	a2, a7, a2
	add	a1, a2, t2
	add	a1, a1, a0
	lbu	a7, 0(a1)
	add	a2, a2, t0
	add	a0, a0, a2
	lbu	a0, 0(a0)
	mul	a2, t3, t4
	and	a2, a2, a6
	srl	a2, a2, a5
	mul	a4, t3, a3
	and	a4, a4, a6
	srl	a4, a4, a5
	mul	a1, t4, t5
	and	a1, a1, a6
	srl	a1, a1, a5
	mul	a3, t5, a3
	and	a3, a3, a6
	srl	a3, a3, a5
	mul	a0, a3, a0
	mul	a1, a1, a7
	mul	a3, a4, t6
	mul	a2, a2, t1
	add	a2, a2, a3
	add	a1, a1, a2
	add	a0, a0, a1
	and	a0, a0, a6
	srl	a6, a0, a5
.LBB3_18:                               # %cleanup
	mv	a0, a6
	ret
.Lfunc_end3:
	.size	bilinear_interpolate, .Lfunc_end3-bilinear_interpolate
                                        # -- End function
	.globl	psroi_align_golden              # -- Begin function psroi_align_golden
	.p2align	2
	.type	psroi_align_golden,@function
psroi_align_golden:                     # @psroi_align_golden
# %bb.0:                                # %entry
	addi	sp, sp, -160
	sw	ra, 156(sp)                     # 4-byte Folded Spill
	sw	s0, 152(sp)                     # 4-byte Folded Spill
	sw	s1, 148(sp)                     # 4-byte Folded Spill
	sw	s2, 144(sp)                     # 4-byte Folded Spill
	sw	s3, 140(sp)                     # 4-byte Folded Spill
	sw	s4, 136(sp)                     # 4-byte Folded Spill
	sw	s5, 132(sp)                     # 4-byte Folded Spill
	sw	s6, 128(sp)                     # 4-byte Folded Spill
	sw	s7, 124(sp)                     # 4-byte Folded Spill
	sw	s8, 120(sp)                     # 4-byte Folded Spill
	sw	s9, 116(sp)                     # 4-byte Folded Spill
	sw	s10, 112(sp)                    # 4-byte Folded Spill
	sw	s11, 108(sp)                    # 4-byte Folded Spill
	csrr	t0, vlenb
	slli	t0, t0, 2
	sub	sp, sp, t0
	sw	a5, 80(sp)                      # 4-byte Folded Spill
	sw	a2, 88(sp)                      # 4-byte Folded Spill
	sw	a1, 52(sp)                      # 4-byte Folded Spill
	sw	a0, 48(sp)                      # 4-byte Folded Spill
	beqz	a3, .LBB4_44
# %bb.1:                                # %for.body.lr.ph
	beqz	a7, .LBB4_44
# %bb.2:                                # %for.body.lr.ph.split.us
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	a0, a0, sp
	lw	a0, 168(a0)
	divu	a2, a4, a6
	mul	a1, a2, a6
	sub	a1, a4, a1
	li	t3, 1
	andi	a4, a0, 255
	lui	a0, 16
	addi	t0, a0, -1
	sw	a1, 40(sp)                      # 4-byte Folded Spill
	and	a1, a1, t0
	sw	a2, 44(sp)                      # 4-byte Folded Spill
	and	a0, a2, t0
	beqz	a4, .LBB4_24
# %bb.3:                                # %for.body.us.us.preheader
	sw	a0, 64(sp)                      # 4-byte Folded Spill
	sw	a1, 68(sp)                      # 4-byte Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	a0, a0, sp
	lw	a0, 172(a0)
	li	t2, 0
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, a1, sp
	lw	t6, 164(a1)
	csrr	a1, vlenb
	slli	a1, a1, 2
	add	a1, a1, sp
	lw	a1, 160(a1)
	andi	s0, a0, 255
	sll	s9, t3, a0
	li	a2, 256
	divu	a5, a2, a6
	sw	a5, 28(sp)                      # 4-byte Folded Spill
	lw	a5, 80(sp)                      # 4-byte Folded Reload
	divu	a2, a2, a5
	sw	a2, 24(sp)                      # 4-byte Folded Spill
	slli	a2, a4, 1
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	slli	a2, a1, 16
	srai	s5, a2, 16
	addi	s6, s5, -1
	sll	s7, s6, a0
	slli	a2, t6, 16
	srai	s8, a2, 16
	addi	s1, s8, -1
	sll	s10, s1, a0
	mul	a0, t6, a1
	sw	a0, 60(sp)                      # 4-byte Folded Spill
	vsetvli	a0, zero, e16, m2, ta, mu
	vid.v	v10
	vsetvli	zero, zero, e32, m4, ta, mu
	vmv.v.x	v16, s1
	vmv.v.i	v24, 0
	sw	a7, 76(sp)                      # 4-byte Folded Spill
	sw	a3, 36(sp)                      # 4-byte Folded Spill
	sw	a6, 72(sp)                      # 4-byte Folded Spill
	sw	t0, 32(sp)                      # 4-byte Folded Spill
	addi	a0, sp, 96
	vs4r.v	v24, (a0)                       # Unknown-size Folded Spill
	j	.LBB4_5
.LBB4_4:                                # %for.cond56.for.cond.cleanup59_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	lw	t2, 56(sp)                      # 4-byte Folded Reload
	addi	t2, t2, 1
	lw	a3, 36(sp)                      # 4-byte Folded Reload
	lw	t0, 32(sp)                      # 4-byte Folded Reload
	beq	t2, a3, .LBB4_44
.LBB4_5:                                # %for.body.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_11 Depth 2
                                        #       Child Loop BB4_13 Depth 3
                                        #         Child Loop BB4_23 Depth 4
	slli	a0, t2, 3
	lw	a1, 52(sp)                      # 4-byte Folded Reload
	add	a1, a1, a0
	lh	a2, 0(a1)
	lh	a0, 4(a1)
	sub	a0, a0, a2
	and	a5, a0, t0
	mv	a0, s9
	blt	a5, s9, .LBB4_7
# %bb.6:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	mv	a0, a5
.LBB4_7:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	lh	a3, 2(a1)
	lh	a1, 6(a1)
	sub	a1, a1, a3
	and	a5, a1, t0
	mv	a1, s9
	blt	a5, s9, .LBB4_9
# %bb.8:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	mv	a1, a5
.LBB4_9:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	li	ra, 0
	lw	a5, 28(sp)                      # 4-byte Folded Reload
	mul	a0, a0, a5
	slli	a0, a0, 16
	srli	a0, a0, 24
	lw	a5, 24(sp)                      # 4-byte Folded Reload
	mul	a1, a1, a5
	slli	a1, a1, 16
	srli	a1, a1, 24
	lw	a5, 20(sp)                      # 4-byte Folded Reload
	divu	t1, a0, a5
	divu	s11, a1, a5
	lw	a5, 44(sp)                      # 4-byte Folded Reload
	mul	a1, a1, a5
	add	t0, a1, a3
	sw	t2, 56(sp)                      # 4-byte Folded Spill
	mul	a1, t2, a7
	sw	a1, 84(sp)                      # 4-byte Folded Spill
	lw	a1, 40(sp)                      # 4-byte Folded Reload
	mul	a0, a0, a1
	add	s2, a0, a2
	lw	s3, 48(sp)                      # 4-byte Folded Reload
	j	.LBB4_11
.LBB4_10:                               # %for.cond70.for.cond.cleanup73_crit_edge.us.us.us
                                        #   in Loop: Header=BB4_11 Depth=2
	lw	a0, 64(sp)                      # 4-byte Folded Reload
	add	a0, a0, a7
	lw	a6, 72(sp)                      # 4-byte Folded Reload
	mul	a0, a0, a6
	lw	a1, 68(sp)                      # 4-byte Folded Reload
	add	a0, a0, a1
	srli	a1, s4, 2
	slli	a0, a0, 1
	lw	a2, 88(sp)                      # 4-byte Folded Reload
	add	a0, a0, a2
	sh	a1, 0(a0)
	addi	ra, ra, 1
	lw	a0, 60(sp)                      # 4-byte Folded Reload
	add	s3, s3, a0
	lw	a7, 76(sp)                      # 4-byte Folded Reload
	beq	ra, a7, .LBB4_4
.LBB4_11:                               # %for.body60.us.us.us
                                        #   Parent Loop BB4_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_13 Depth 3
                                        #         Child Loop BB4_23 Depth 4
	li	t3, 0
	li	s4, 0
	lw	a0, 84(sp)                      # 4-byte Folded Reload
	add	a0, a0, ra
	lw	a1, 80(sp)                      # 4-byte Folded Reload
	mul	a7, a0, a1
	j	.LBB4_13
.LBB4_12:                               # %for.cond84.for.cond.cleanup87_crit_edge.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	addi	t3, t3, 1
	beq	t3, a4, .LBB4_10
.LBB4_13:                               # %for.body74.us.us.us
                                        #   Parent Loop BB4_5 Depth=1
                                        #     Parent Loop BB4_11 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB4_23 Depth 4
	slli	a0, t3, 1
	ori	a0, a0, 1
	mul	a0, a0, s11
	add	a0, a0, t0
	slli	a0, a0, 16
	srai	a5, a0, 16
	mv	a2, a5
	bgtz	a5, .LBB4_15
# %bb.14:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	li	a2, 0
.LBB4_15:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	slli	a0, a2, 16
	srli	a0, a0, 16
	srl	a3, a0, s0
	blt	a3, s6, .LBB4_17
# %bb.16:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	mv	a0, s6
	mv	a1, s6
	bge	s6, a3, .LBB4_18
	j	.LBB4_19
.LBB4_17:                               #   in Loop: Header=BB4_13 Depth=3
	addi	a0, a3, 1
	mv	a1, s6
	blt	s6, a3, .LBB4_19
.LBB4_18:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	mv	a1, a3
.LBB4_19:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	bge	a3, s6, .LBB4_21
# %bb.20:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	sra	a3, a5, s0
	bge	a3, s5, .LBB4_12
	j	.LBB4_22
.LBB4_21:                               # %for.body74.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	mv	a2, s7
	sra	a3, a5, s0
	bge	a3, s5, .LBB4_12
.LBB4_22:                               # %vector.ph
                                        #   in Loop: Header=BB4_13 Depth=3
	li	t5, 0
	sll	a3, a1, s0
	sub	t2, a2, a3
	sub	a2, s9, t2
	mul	a5, a1, s8
	mul	a6, a0, s8
	vmv2r.v	v20, v10
.LBB4_23:                               # %vector.body
                                        #   Parent Loop BB4_5 Depth=1
                                        #     Parent Loop BB4_11 Depth=2
                                        #       Parent Loop BB4_13 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	sub	a0, a4, t5
	vsetvli	t4, a0, e16, m2, ta, mu
	vadd.vv	v8, v20, v20
	vor.vi	v8, v8, 1
	vsetvli	a0, zero, e16, m2, ta, mu
	vmv.v.x	v22, s2
	vsetvli	zero, t4, e16, m2, ta, mu
	vmacc.vx	v22, t1, v8
	vsra.vx	v24, v22, s0
	vmslt.vx	v8, v24, t6
	vmv1r.v	v0, v8
	vmax.vx	v22, v22, zero, v0.t
	vsrl.vx	v24, v22, s0, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vzext.vf2	v4, v24, v0.t
	vmslt.vx	v9, v4, s1, v0.t
	vsetvli	a0, zero, e8, m1, ta, mu
	vmand.mm	v9, v8, v9
	vsetvli	zero, t4, e32, m4, ta, mu
	vmnand.mm	v9, v9, v9
	vadd.vi	v24, v4, 1, v0.t
	vmv1r.v	v0, v9
	vmerge.vxm	v28, v24, s1, v0
	vmv1r.v	v0, v8
	vmin.vv	v4, v16, v4, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vmv1r.v	v0, v9
	vmerge.vxm	v22, v22, s10, v0
	vsetvli	zero, zero, e32, m4, ta, mu
	vmv1r.v	v0, v8
	vsll.vx	v24, v4, s0, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vncvt.x.x.w	v2, v24, v0.t
	vsub.vv	v22, v22, v2, v0.t
	vrsub.vx	v26, v22, s9, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vx	v12, v4, a5, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vluxei32.v	v9, (s3), v12, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vmv1r.v	v0, v8
	vzext.vf2	v24, v9, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vx	v12, v28, a5, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vluxei32.v	v9, (s3), v12, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vzext.vf2	v2, v9, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vx	v12, v4, a6, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vluxei32.v	v9, (s3), v12, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vzext.vf2	v12, v9, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vx	v28, v28, a6, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vluxei32.v	v9, (s3), v28, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vzext.vf2	v14, v9, v0.t
	vmul.vx	v28, v26, a2, v0.t
	vsrl.vx	v28, v28, s0, v0.t
	vmul.vx	v30, v22, a2, v0.t
	vsrl.vx	v30, v30, s0, v0.t
	vmul.vx	v26, v26, t2, v0.t
	vsrl.vx	v26, v26, s0, v0.t
	vmul.vx	v22, v22, t2, v0.t
	vsrl.vx	v22, v22, s0, v0.t
	vmul.vv	v14, v22, v14, v0.t
	vmul.vv	v12, v26, v12, v0.t
	vmul.vv	v22, v30, v2, v0.t
	vmul.vv	v24, v28, v24, v0.t
	vadd.vv	v22, v22, v24, v0.t
	vadd.vv	v12, v22, v12, v0.t
	vadd.vv	v12, v12, v14, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vzext.vf2	v24, v12, v0.t
	vsrl.vx	v12, v24, s0, v0.t
	addi	a0, sp, 96
	vl4re8.v	v24, (a0)                       # Unknown-size Folded Reload
	vsetvli	a0, zero, e32, m4, ta, mu
	vmerge.vvm	v12, v24, v12, v0
	vmv.s.x	v8, s4
	vsetvli	zero, t4, e32, m4, tu, mu
	vredsum.vs	v8, v12, v8
	vmv.x.s	s4, v8
	add	t5, t5, t4
	vsetvli	a0, zero, e16, m2, ta, mu
	vadd.vx	v20, v20, t4
	bne	t5, a4, .LBB4_23
	j	.LBB4_12
.LBB4_24:                               # %for.body.us.preheader
	mul	a0, a0, a6
	add	t2, a0, a1
	mul	a0, a7, a6
	lw	a1, 80(sp)                      # 4-byte Folded Reload
	mul	a4, a0, a1
	mul	a0, a6, a1
	slli	a0, a0, 1
	addi	a1, a3, -1
	andi	t1, a3, 3
	li	a2, 3
	vsetvli	a5, zero, e16, m8, ta, mu
	vmv.v.i	v8, 0
	li	a5, 0
	bltu	a1, a2, .LBB4_35
# %bb.25:                               # %for.body.us.preheader.new
	andi	t0, a3, -4
.LBB4_26:                               # %vector.ph312
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_27 Depth 2
                                        #     Child Loop BB4_29 Depth 2
                                        #     Child Loop BB4_31 Depth 2
                                        #     Child Loop BB4_33 Depth 2
	li	s0, 0
	mul	a1, a4, a5
	add	a1, a1, t2
	slli	a1, a1, 1
	lw	a2, 88(sp)                      # 4-byte Folded Reload
	add	a1, a1, a2
.LBB4_27:                               # %vector.body311
                                        #   Parent Loop BB4_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	s1, a7, s0
	vsetvli	s1, s1, e16, m8, ta, mu
	mul	a2, s0, a0
	add	a2, a2, a1
	add	s0, s0, s1
	vsse16.v	v8, (a2), a0
	bne	s0, a7, .LBB4_27
# %bb.28:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us226
                                        #   in Loop: Header=BB4_26 Depth=1
	li	s0, 0
	ori	a1, a5, 1
	mul	a1, a4, a1
	add	a1, a1, t2
	slli	a1, a1, 1
	lw	a2, 88(sp)                      # 4-byte Folded Reload
	add	a1, a1, a2
.LBB4_29:                               # %vector.body311.1
                                        #   Parent Loop BB4_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a2, a7, s0
	vsetvli	a2, a2, e16, m8, ta, mu
	mul	s1, s0, a0
	add	s1, s1, a1
	add	s0, s0, a2
	vsse16.v	v8, (s1), a0
	bne	s0, a7, .LBB4_29
# %bb.30:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us226.1
                                        #   in Loop: Header=BB4_26 Depth=1
	li	s0, 0
	ori	a1, a5, 2
	mul	a1, a4, a1
	add	a1, a1, t2
	slli	a1, a1, 1
	lw	a2, 88(sp)                      # 4-byte Folded Reload
	add	a1, a1, a2
.LBB4_31:                               # %vector.body311.2
                                        #   Parent Loop BB4_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a2, a7, s0
	vsetvli	a2, a2, e16, m8, ta, mu
	mul	s1, s0, a0
	add	s1, s1, a1
	add	s0, s0, a2
	vsse16.v	v8, (s1), a0
	bne	s0, a7, .LBB4_31
# %bb.32:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us226.2
                                        #   in Loop: Header=BB4_26 Depth=1
	li	s0, 0
	ori	a1, a5, 3
	mul	a1, a4, a1
	add	a1, a1, t2
	slli	a1, a1, 1
	lw	a2, 88(sp)                      # 4-byte Folded Reload
	add	a1, a1, a2
.LBB4_33:                               # %vector.body311.3
                                        #   Parent Loop BB4_26 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	sub	a2, a7, s0
	vsetvli	a2, a2, e16, m8, ta, mu
	mul	s1, s0, a0
	add	s1, s1, a1
	add	s0, s0, a2
	vsse16.v	v8, (s1), a0
	bne	s0, a7, .LBB4_33
# %bb.34:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us226.3
                                        #   in Loop: Header=BB4_26 Depth=1
	addi	a5, a5, 4
	bne	a5, t0, .LBB4_26
.LBB4_35:                               # %for.cond.cleanup.loopexit.unr-lcssa
	beqz	t1, .LBB4_44
# %bb.36:                               # %vector.ph312.epil
	li	a2, 0
	mul	a1, a4, a5
	add	a1, a1, t2
	slli	a1, a1, 1
	lw	s1, 88(sp)                      # 4-byte Folded Reload
	add	a1, a1, s1
.LBB4_37:                               # %vector.body311.epil
                                        # =>This Inner Loop Header: Depth=1
	sub	s1, a7, a2
	vsetvli	s1, s1, e16, m8, ta, mu
	mul	s0, a2, a0
	add	s0, s0, a1
	add	a2, a2, s1
	vsse16.v	v8, (s0), a0
	bne	a2, a7, .LBB4_37
# %bb.38:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us226.epil
	beq	t1, t3, .LBB4_44
# %bb.39:                               # %vector.ph312.epil.1
	li	a1, 0
	addi	a2, a5, 1
	mul	a2, a4, a2
	add	a2, a2, t2
	slli	a2, a2, 1
	lw	s1, 88(sp)                      # 4-byte Folded Reload
	add	a2, a2, s1
.LBB4_40:                               # %vector.body311.epil.1
                                        # =>This Inner Loop Header: Depth=1
	sub	s1, a7, a1
	vsetvli	s1, s1, e16, m8, ta, mu
	mul	s0, a1, a0
	add	s0, s0, a2
	add	a1, a1, s1
	vsse16.v	v8, (s0), a0
	bne	a1, a7, .LBB4_40
# %bb.41:                               # %for.cond56.for.cond.cleanup59_crit_edge.split.us226.epil.1
	li	a1, 2
	beq	t1, a1, .LBB4_44
# %bb.42:                               # %vector.ph312.epil.2
	li	a1, 0
	addi	a2, a5, 2
	mul	a2, a4, a2
	add	a2, a2, t2
	slli	a2, a2, 1
	lw	a3, 88(sp)                      # 4-byte Folded Reload
	add	a2, a2, a3
.LBB4_43:                               # %vector.body311.epil.2
                                        # =>This Inner Loop Header: Depth=1
	sub	a3, a7, a1
	vsetvli	a3, a3, e16, m8, ta, mu
	mul	a4, a1, a0
	add	a4, a4, a2
	add	a1, a1, a3
	vsse16.v	v8, (a4), a0
	bne	a1, a7, .LBB4_43
.LBB4_44:                               # %for.cond.cleanup
	csrr	a0, vlenb
	slli	a0, a0, 2
	add	sp, sp, a0
	lw	ra, 156(sp)                     # 4-byte Folded Reload
	lw	s0, 152(sp)                     # 4-byte Folded Reload
	lw	s1, 148(sp)                     # 4-byte Folded Reload
	lw	s2, 144(sp)                     # 4-byte Folded Reload
	lw	s3, 140(sp)                     # 4-byte Folded Reload
	lw	s4, 136(sp)                     # 4-byte Folded Reload
	lw	s5, 132(sp)                     # 4-byte Folded Reload
	lw	s6, 128(sp)                     # 4-byte Folded Reload
	lw	s7, 124(sp)                     # 4-byte Folded Reload
	lw	s8, 120(sp)                     # 4-byte Folded Reload
	lw	s9, 116(sp)                     # 4-byte Folded Reload
	lw	s10, 112(sp)                    # 4-byte Folded Reload
	lw	s11, 108(sp)                    # 4-byte Folded Reload
	addi	sp, sp, 160
	ret
.Lfunc_end4:
	.size	psroi_align_golden, .Lfunc_end4-psroi_align_golden
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
	beqz	s5, .LBB5_3
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
.LBB5_2:                                # %for.body
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
	bne	s5, s1, .LBB5_2
.LBB5_3:                                # %for.cond.cleanup
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
.Lfunc_end5:
	.size	psroi_pooling_align_golden, .Lfunc_end5-psroi_pooling_align_golden
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
.LBB6_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	sub	a3, a1, a0
	vsetvli	a3, a3, e8, m4, ta, mu
	vand.vx	v12, v8, a2
	add	a4, a0, s0
	vse8.v	v12, (a4)
	add	a0, a0, a3
	vsetvli	a4, zero, e8, m4, ta, mu
	vadd.vx	v8, v8, a3
	bne	a0, a1, .LBB6_1
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
.LBB6_3:                                # %vector.body58
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
	bne	a0, a1, .LBB6_3
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
.LBB6_5:                                # %for.body.i23
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
	bne	s1, s9, .LBB6_5
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
.Lfunc_end6:
	.size	main, .Lfunc_end6-main
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
