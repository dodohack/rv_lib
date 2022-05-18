	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10_zvlsseg0p10"
	.option	nopic
	.file	"psroi_v1_golden.c"
	.globl	read_rdcycle                    # -- Begin function read_rdcycle
	.p2align	1
	.type	read_rdcycle,@function
read_rdcycle:                           # @read_rdcycle
# %bb.0:                                # %entry
	#APP
	rdcycle	a0

	#NO_APP
	sext.w	a0, a0
	ret
.Lfunc_end0:
	.size	read_rdcycle, .Lfunc_end0-read_rdcycle
                                        # -- End function
	.globl	global_arr_init                 # -- Begin function global_arr_init
	.p2align	1
	.type	global_arr_init,@function
global_arr_init:                        # @global_arr_init
# %bb.0:                                # %entry
	mv	a0, zero
	vsetvli	a1, zero, e8, m1, ta, mu
	vid.v	v25
	lui	a1, 88
	addiw	a1, a1, 192
	addi	a2, zero, 63
	lui	a3, %hi(src_arr_global)
	addi	a3, a3, %lo(src_arr_global)
.LBB1_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	sub	a4, a1, a0
	vsetvli	a4, a4, e8, m1, ta, mu
	vand.vx	v26, v25, a2
	add	a5, a0, a3
	vse8.v	v26, (a5)
	add	a0, a0, a4
	vsetvli	a5, zero, e8, m1, ta, mu
	vadd.vx	v25, v25, a4
	bne	a0, a1, .LBB1_1
# %bb.2:                                # %vector.ph77
	mv	a0, zero
	vsetvli	a1, zero, e64, m4, ta, mu
	vid.v	v28
	addi	a1, zero, 150
	vmset.m	v0
	vsetvli	zero, zero, e16, m1, ta, mu
	addi	a2, zero, 16
	vmv.v.x	v25, a2
	lui	a2, %hi(rois_arr_global)
	addi	a2, a2, %lo(rois_arr_global)
	vmv.v.i	v26, 1
	vmv.v.i	v27, 11
	vmv.v.i	v8, 2
.LBB1_3:                                # %vector.body76
                                        # =>This Inner Loop Header: Depth=1
	sub	a3, a1, a0
	vsetvli	a3, a3, e16, m1, ta, mu
	vsetvli	zero, a3, e64, m4, ta, mu
	vsll.vi	v12, v28, 3
	vsetvli	a4, zero, e64, m4, ta, mu
	vadd.vv	v16, v12, v12
	vsetvli	zero, a3, e16, m1, ta, mu
	vsoxei64.v	v26, (a2), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 1
	vsetvli	a4, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a3, e16, m1, ta, mu
	vsoxei64.v	v26, (a2), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 2
	vsetvli	a4, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a3, e16, m1, ta, mu
	vsoxei64.v	v27, (a2), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 3
	vsetvli	a4, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a3, e16, m1, ta, mu
	vsoxei64.v	v27, (a2), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 4
	vsetvli	a4, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a3, e16, m1, ta, mu
	vsoxei64.v	v8, (a2), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 5
	vsetvli	a4, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a3, e16, m1, ta, mu
	vsoxei64.v	v8, (a2), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 6
	vsetvli	a4, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a3, e16, m1, ta, mu
	vsoxei64.v	v25, (a2), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v12, v12, 7
	vsetvli	a4, zero, e64, m4, ta, mu
	vadd.vv	v12, v12, v12
	vsetvli	zero, a3, e16, m1, ta, mu
	vsoxei64.v	v25, (a2), v12, v0.t
	add	a0, a0, a3
	vsetvli	a4, zero, e64, m4, ta, mu
	vadd.vx	v28, v28, a3
	bne	a0, a1, .LBB1_3
# %bb.4:                                # %for.cond.cleanup4
	ret
.Lfunc_end1:
	.size	global_arr_init, .Lfunc_end1-global_arr_init
                                        # -- End function
	.globl	psroi_param_read                # -- Begin function psroi_param_read
	.p2align	1
	.type	psroi_param_read,@function
psroi_param_read:                       # @psroi_param_read
# %bb.0:                                # %entry
	lw	a2, 8(a1)
	sw	a2, 24(a0)
	lw	a2, 12(a1)
	sw	a2, 28(a0)
	lw	a2, 16(a1)
	sw	a2, 32(a0)
	lw	a2, 20(a1)
	sw	a2, 36(a0)
	lw	a2, 24(a1)
	sw	a2, 40(a0)
	lw	a2, 28(a1)
	sw	a2, 44(a0)
	lw	a1, 32(a1)
	srli	a2, a1, 16
	sb	a2, 48(a0)
	sb	a1, 49(a0)
	lui	a1, %hi(src_arr_global)
	addi	a1, a1, %lo(src_arr_global)
	sd	a1, 0(a0)
	lui	a1, %hi(rois_arr_global)
	addi	a1, a1, %lo(rois_arr_global)
	sd	a1, 8(a0)
	lui	a1, %hi(out_arr_global)
	addi	a1, a1, %lo(out_arr_global)
	sd	a1, 16(a0)
	ret
.Lfunc_end2:
	.size	psroi_param_read, .Lfunc_end2-psroi_param_read
                                        # -- End function
	.globl	bilinear_interpolate            # -- Begin function bilinear_interpolate
	.p2align	1
	.type	bilinear_interpolate,@function
bilinear_interpolate:                   # @bilinear_interpolate
# %bb.0:                                # %entry
	sraw	a6, a3, a5
	bge	a6, a1, .LBB3_9
# %bb.1:                                # %lor.lhs.false
	sraw	a6, a4, a5
	bge	a6, a2, .LBB3_9
# %bb.2:                                # %if.end
	bgtz	a3, .LBB3_4
# %bb.3:                                # %if.end
	mv	a3, zero
.LBB3_4:                                # %if.end
	bgtz	a4, .LBB3_6
# %bb.5:                                # %if.end
	mv	a4, zero
.LBB3_6:                                # %if.end
	lui	a6, 16
	addiw	a6, a6, -1
	and	a7, a3, a6
	srlw	t0, a7, a5
	and	t1, a4, a6
	addi	a7, a1, -1
	srlw	t1, t1, a5
	blt	t0, a7, .LBB3_10
# %bb.7:                                # %if.end
	sllw	a3, a7, a5
	mv	t0, a7
	addi	t2, a2, -1
	bge	t1, t2, .LBB3_11
.LBB3_8:
	addi	t2, t1, 1
	j	.LBB3_12
.LBB3_9:
	mv	a0, zero
	ret
.LBB3_10:
	addi	a7, t0, 1
	addi	t2, a2, -1
	blt	t1, t2, .LBB3_8
.LBB3_11:                               # %if.end
	sllw	a4, t2, a5
	mv	t1, t2
.LBB3_12:                               # %if.end
	sllw	a1, t0, a5
	sub	a1, a3, a1
	sllw	a3, t1, a5
	sub	a3, a4, a3
	and	t3, a1, a6
	addi	a4, zero, 1
	sllw	a4, a4, a5
	sub	t4, a4, a1
	and	a1, a3, a6
	sub	t5, a4, a3
	mul	a4, t0, a2
	addw	a3, a4, t1
	add	a3, a3, a0
	lbu	t0, 0(a3)
	addw	a4, a4, t2
	add	a4, a4, a0
	lbu	t6, 0(a4)
	mul	a2, a7, a2
	addw	a3, a2, t1
	add	a3, a3, a0
	lbu	a7, 0(a3)
	addw	a2, a2, t2
	add	a0, a0, a2
	lbu	a0, 0(a0)
	and	a2, t5, a6
	and	a4, t4, a6
	mul	a3, a2, a4
	srlw	a3, a3, a5
	mul	a4, a4, a1
	srlw	a4, a4, a5
	mul	a2, a2, t3
	srlw	a2, a2, a5
	mul	a1, a1, t3
	srlw	a1, a1, a5
	and	a1, a1, a6
	mul	a0, a1, a0
	and	a1, a2, a6
	mul	a1, a1, a7
	and	a2, a4, a6
	mul	a2, a2, t6
	and	a3, a3, a6
	mul	a3, a3, t0
	add	a2, a2, a3
	add	a1, a1, a2
	add	a0, a0, a1
	srlw	a0, a0, a5
	ret
.Lfunc_end3:
	.size	bilinear_interpolate, .Lfunc_end3-bilinear_interpolate
                                        # -- End function
	.globl	psroi_align_golden              # -- Begin function psroi_align_golden
	.p2align	1
	.type	psroi_align_golden,@function
psroi_align_golden:                     # @psroi_align_golden
# %bb.0:                                # %entry
	addi	sp, sp, -224
	sd	ra, 216(sp)                     # 8-byte Folded Spill
	sd	s0, 208(sp)                     # 8-byte Folded Spill
	sd	s1, 200(sp)                     # 8-byte Folded Spill
	sd	s2, 192(sp)                     # 8-byte Folded Spill
	sd	s3, 184(sp)                     # 8-byte Folded Spill
	sd	s4, 176(sp)                     # 8-byte Folded Spill
	sd	s5, 168(sp)                     # 8-byte Folded Spill
	sd	s6, 160(sp)                     # 8-byte Folded Spill
	sd	s7, 152(sp)                     # 8-byte Folded Spill
	sd	s8, 144(sp)                     # 8-byte Folded Spill
	sd	s9, 136(sp)                     # 8-byte Folded Spill
	sd	s10, 128(sp)                    # 8-byte Folded Spill
	sd	s11, 120(sp)                    # 8-byte Folded Spill
	csrr	t0, vlenb
	addi	t1, zero, 22
	mul	t0, t0, t1
	sub	sp, sp, t0
	sd	a7, 72(sp)                      # 8-byte Folded Spill
	sd	a5, 112(sp)                     # 8-byte Folded Spill
	sd	a2, 104(sp)                     # 8-byte Folded Spill
	sd	a0, 64(sp)                      # 8-byte Folded Spill
	beqz	a3, .LBB4_31
# %bb.1:                                # %for.body.lr.ph
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	beqz	a0, .LBB4_31
# %bb.2:                                # %for.body.lr.ph.split.us
	mv	t4, a6
	mv	t0, a1
	csrr	a0, vlenb
	addi	a1, zero, 22
	mul	a0, a0, a1
	add	a0, a0, sp
	lbu	t1, 240(a0)
	lui	a0, 16
	addiw	t2, a0, -1
	divuw	a0, a4, a6
	mul	a1, a0, a6
	sub	a1, a4, a1
	and	s5, a1, t2
	seqz	a1, t1
	and	s9, a0, t2
	bnez	a1, .LBB4_24
# %bb.3:                                # %for.body.us.us.preheader
	mv	a5, zero
	csrr	a0, vlenb
	addi	a1, zero, 22
	mul	a0, a0, a1
	add	a0, a0, sp
	lbu	a4, 248(a0)
	csrr	a0, vlenb
	addi	a1, zero, 22
	mul	a0, a0, a1
	add	a0, a0, sp
	lw	a0, 232(a0)
	csrr	a1, vlenb
	addi	a2, zero, 22
	mul	a1, a1, a2
	add	a1, a1, sp
	lw	a1, 224(a1)
	addi	a2, zero, 1
	sllw	t5, a2, a4
	slli	a2, t1, 1
	sd	a2, 48(sp)                      # 8-byte Folded Spill
	slli	a2, a1, 48
	srai	s2, a2, 48
	slli	a2, a0, 48
	srai	s1, a2, 48
	addi	s4, s2, -1
	sllw	s3, s4, a4
	addi	s0, s1, -1
	sllw	a2, s0, a4
	mul	a0, a0, a1
	slli	a0, a0, 32
	srli	a0, a0, 32
	sd	a0, 96(sp)                      # 8-byte Folded Spill
	addi	a0, zero, 256
	divuw	a1, a0, t4
	sd	a1, 40(sp)                      # 8-byte Folded Spill
	ld	a1, 112(sp)                     # 8-byte Folded Reload
	divuw	a0, a0, a1
	sd	a0, 32(sp)                      # 8-byte Folded Spill
	slli	a0, a3, 32
	srli	a0, a0, 32
	sd	a0, 24(sp)                      # 8-byte Folded Spill
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	slli	a0, a0, 32
	srli	a0, a0, 32
	sd	a0, 88(sp)                      # 8-byte Folded Spill
	vsetvli	a0, zero, e32, m4, ta, mu
	vid.v	v8
	vmv.v.i	v12, 0
	vsetvli	zero, zero, e16, m2, ta, mu
	vmv.v.i	v16, 0
	vsetvli	zero, zero, e32, m4, ta, mu
	vmv.v.x	v20, s0
	vsetvli	zero, zero, e16, m2, ta, mu
	vmv.v.x	v2, a2
	sd	t0, 56(sp)                      # 8-byte Folded Spill
	csrr	a0, vlenb
	addi	a1, zero, 10
	mul	a0, a0, a1
	add	a0, a0, sp
	addi	a0, a0, 120
	vs4r.v	v8, (a0)                        # Unknown-size Folded Spill
	csrr	a0, vlenb
	addi	a1, zero, 6
	mul	a0, a0, a1
	add	a0, a0, sp
	addi	a0, a0, 120
	vs4r.v	v12, (a0)                       # Unknown-size Folded Spill
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, a0, sp
	addi	a0, a0, 120
	vs4r.v	v20, (a0)                       # Unknown-size Folded Spill
	addi	a0, sp, 120
	vs2r.v	v16, (a0)                       # Unknown-size Folded Spill
	j	.LBB4_5
.LBB4_4:                                # %for.cond70.for.cond.cleanup73_crit_edge.split.us.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	ld	a5, 80(sp)                      # 8-byte Folded Reload
	addi	a5, a5, 1
	ld	t0, 56(sp)                      # 8-byte Folded Reload
	ld	a0, 24(sp)                      # 8-byte Folded Reload
	beq	a5, a0, .LBB4_31
.LBB4_5:                                # %for.body.us.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_11 Depth 2
                                        #       Child Loop BB4_13 Depth 3
                                        #         Child Loop BB4_22 Depth 4
	slli	a3, a5, 2
	slli	a0, a5, 34
	srli	a0, a0, 31
	add	a0, a0, t0
	lhu	a7, 0(a0)
	ori	a1, a3, 2
	slli	a1, a1, 32
	srli	a1, a1, 31
	add	a1, a1, t0
	lhu	a1, 0(a1)
	sub	a1, a1, a7
	blt	t5, a1, .LBB4_7
# %bb.6:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	mv	a1, t5
.LBB4_7:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	ori	a2, a3, 1
	slli	a2, a2, 32
	srli	a2, a2, 31
	add	a2, a2, t0
	lhu	t3, 0(a2)
	ori	a3, a3, 3
	slli	a3, a3, 32
	srli	a3, a3, 31
	add	a3, a3, t0
	lhu	a3, 0(a3)
	sub	a3, a3, t3
	blt	t5, a3, .LBB4_9
# %bb.8:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	mv	a3, t5
.LBB4_9:                                # %for.body.us.us
                                        #   in Loop: Header=BB4_5 Depth=1
	mv	s10, zero
	and	a1, a1, t2
	ld	a0, 40(sp)                      # 8-byte Folded Reload
	mul	a1, a1, a0
	srli	t0, a1, 8
	and	a3, a3, t2
	ld	a0, 32(sp)                      # 8-byte Folded Reload
	mul	a3, a3, a0
	srli	a2, a3, 8
	and	a3, t0, t2
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	divuw	a3, a3, a1
	and	a0, a2, t2
	divuw	s11, a0, a1
	mul	a0, a2, s9
	addw	ra, a0, t3
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	sd	a5, 80(sp)                      # 8-byte Folded Spill
	mulw	s6, a5, a0
	mul	a0, t0, s5
	addw	a0, a0, a7
	ld	s7, 64(sp)                      # 8-byte Folded Reload
	j	.LBB4_11
.LBB4_10:                               # %for.cond84.for.cond.cleanup87_crit_edge.us.us.us
                                        #   in Loop: Header=BB4_11 Depth=2
	add	a1, t6, s9
	mul	a1, a1, t4
	add	a1, a1, s5
	srli	a2, t3, 2
	slli	a1, a1, 32
	srli	a1, a1, 31
	ld	a5, 104(sp)                     # 8-byte Folded Reload
	add	a1, a1, a5
	sh	a2, 0(a1)
	addi	s10, s10, 1
	ld	a1, 96(sp)                      # 8-byte Folded Reload
	add	s7, s7, a1
	ld	a1, 88(sp)                      # 8-byte Folded Reload
	beq	s10, a1, .LBB4_4
.LBB4_11:                               # %for.body74.us.us.us
                                        #   Parent Loop BB4_5 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_13 Depth 3
                                        #         Child Loop BB4_22 Depth 4
	mv	s8, zero
	mv	t3, zero
	add	a1, s6, s10
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	mulw	t6, a1, a2
	j	.LBB4_13
.LBB4_12:                               # %for.cond100.for.cond.cleanup103_crit_edge.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	addiw	s8, s8, 1
	bgeu	s8, t1, .LBB4_10
.LBB4_13:                               # %for.body88.us.us.us
                                        #   Parent Loop BB4_5 Depth=1
                                        #     Parent Loop BB4_11 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB4_22 Depth 4
	slli	a1, s8, 1
	ori	a1, a1, 1
	mulw	a2, a1, s11
	add	a1, ra, a2
	slli	a1, a1, 48
	srai	a1, a1, 48
	bgtz	a1, .LBB4_15
# %bb.14:                               # %for.body88.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	mv	a5, zero
	and	a2, a5, t2
	srlw	a2, a2, a4
	mv	t0, a2
	bge	a2, s4, .LBB4_16
	j	.LBB4_17
.LBB4_15:                               #   in Loop: Header=BB4_13 Depth=3
	addw	a5, ra, a2
	and	a2, a5, t2
	srlw	a2, a2, a4
	mv	t0, a2
	blt	a2, s4, .LBB4_17
.LBB4_16:                               # %for.body88.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	mv	t0, s4
	mv	a5, s3
.LBB4_17:                               # %for.body88.us.us.us
                                        #   in Loop: Header=BB4_13 Depth=3
	sraw	a1, a1, a4
	bge	a1, s2, .LBB4_12
# %bb.18:                               # %vector.ph
                                        #   in Loop: Header=BB4_13 Depth=3
	slt	a1, a2, s4
	bnez	a1, .LBB4_20
# %bb.19:                               # %vector.ph
                                        #   in Loop: Header=BB4_13 Depth=3
	mv	a1, s4
	j	.LBB4_21
.LBB4_20:                               #   in Loop: Header=BB4_13 Depth=3
	slli	a1, a2, 32
	srli	a1, a1, 32
	addi	a1, a1, 1
.LBB4_21:                               # %vector.ph
                                        #   in Loop: Header=BB4_13 Depth=3
	mv	a7, zero
	sllw	a2, t0, a4
	sub	a2, a5, a2
	vsetvli	zero, zero, e32, m4, tu, mu
	vmv4r.v	v4, v12
	vmv.s.x	v4, t3
	sub	a5, t5, a2
	and	t3, a5, t2
	mulw	a1, a1, s1
	mulw	t0, t0, s1
	and	a5, a2, t2
	vmv4r.v	v28, v8
.LBB4_22:                               # %vector.body
                                        #   Parent Loop BB4_5 Depth=1
                                        #     Parent Loop BB4_11 Depth=2
                                        #       Parent Loop BB4_13 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	sd	a0, 16(sp)
	csrr	a0, vlenb
	addi	a2, zero, 18
	mul	a0, a0, a2
	add	a0, a0, sp
	addi	a0, a0, 120
	vs4r.v	v28, (a0)                       # Unknown-size Folded Spill
	csrr	a0, vlenb
	addi	a2, zero, 14
	mul	a0, a0, a2
	add	a0, a0, sp
	addi	a0, a0, 120
	vs4r.v	v4, (a0)                        # Unknown-size Folded Spill
	sub	a2, t1, a7
	slli	a2, a2, 32
	srli	a2, a2, 32
	vsetvli	a6, a2, e32, m4, ta, mu
	csrr	a2, vlenb
	addi	a0, zero, 18
	mul	a2, a2, a0
	ld	a0, 16(sp)
	add	a2, a2, sp
	addi	a2, a2, 120
	vl4re8.v	v28, (a2)                       # Unknown-size Folded Reload
	vsll.vi	v28, v28, 1
	vor.vi	v28, v28, 1
	vsetvli	a2, zero, e32, m4, ta, mu
	vmv.v.x	v8, a0
	vsetvli	zero, a6, e32, m4, ta, mu
	vmacc.vx	v8, a3, v28
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wi	v26, v8, 0
	vwadd.vx	v28, v26, zero
	vsetvli	zero, zero, e32, m4, ta, mu
	vsra.vx	v28, v28, a4
	vmslt.vx	v8, v28, s1
	vsetvli	zero, zero, e16, m2, ta, mu
	vmv1r.v	v0, v8
	vmsgt.vi	v25, v26, 0, v0.t
	vsetvli	a2, zero, e8, m1, ta, mu
	vmand.mm	v0, v8, v25
	vsetvli	zero, a6, e16, m2, ta, mu
	vmerge.vvm	v26, v16, v26, v0
	vmv1r.v	v0, v8
	vwcvtu.x.x.v	v28, v26, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vsrl.vx	v28, v28, a4, v0.t
	vmslt.vx	v25, v28, s0, v0.t
	vsetvli	a2, zero, e8, m1, ta, mu
	vmand.mm	v25, v8, v25
	vsetvli	zero, a6, e32, m4, ta, mu
	vadd.vi	v8, v28, 1, v0.t
	vmv1r.v	v14, v0
	vmv1r.v	v0, v25
	vmerge.vvm	v4, v20, v8, v0
	vmerge.vvm	v8, v20, v28, v0
	vsetvli	zero, zero, e16, m2, ta, mu
	vmerge.vvm	v26, v2, v26, v0
	vsetvli	zero, zero, e32, m4, ta, mu
	vmv1r.v	v0, v14
	vsll.vx	v28, v8, a4, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wi	v12, v28, 0, v0.t
	vsub.vv	v26, v26, v12, v0.t
	vwcvtu.x.x.v	v28, v26, v0.t
	vrsub.vx	v26, v26, t5, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vx	v12, v8, t0, v0.t
	vwcvt.x.x.v	v16, v12, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v25, (s7), v16, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vx	v12, v4, t0, v0.t
	vwcvt.x.x.v	v16, v12, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v24, (s7), v16, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vx	v8, v8, a1, v0.t
	vwcvt.x.x.v	v16, v8, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v1, (s7), v16, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vadd.vx	v8, v4, a1, v0.t
	vwcvt.x.x.v	v16, v8, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei64.v	v4, (s7), v16, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vwcvtu.x.x.v	v12, v26, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vmul.vx	v8, v12, t3, v0.t
	vsrl.vx	v16, v8, a4, v0.t
	vmul.vx	v8, v28, t3, v0.t
	vsrl.vx	v8, v8, a4, v0.t
	vmul.vx	v12, v12, a5, v0.t
	vsrl.vx	v12, v12, a4, v0.t
	vmul.vx	v28, v28, a5, v0.t
	vsrl.vx	v28, v28, a4, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vwcvtu.x.x.v	v26, v4, v0.t
	csrr	a2, vlenb
	sd	a0, 16(sp)
	addi	a0, zero, 14
	mul	a2, a2, a0
	ld	a0, 16(sp)
	add	a2, a2, sp
	addi	a2, a2, 120
	vl4re8.v	v4, (a2)                        # Unknown-size Folded Reload
	vsetvli	zero, zero, e16, m2, ta, mu
	vwcvtu.x.x.v	v20, v26, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vand.vx	v28, v28, t2, v0.t
	vmul.vv	v28, v28, v20, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vwcvtu.x.x.v	v26, v1, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vwcvtu.x.x.v	v20, v26, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vand.vx	v12, v12, t2, v0.t
	vmul.vv	v12, v12, v20, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vwcvtu.x.x.v	v26, v24, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vwcvtu.x.x.v	v20, v26, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vand.vx	v8, v8, t2, v0.t
	vmul.vv	v8, v8, v20, v0.t
	vsetvli	zero, zero, e8, m1, ta, mu
	vwcvtu.x.x.v	v26, v25, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vwcvtu.x.x.v	v20, v26, v0.t
	vsetvli	zero, zero, e32, m4, ta, mu
	vand.vx	v16, v16, t2, v0.t
	vmul.vv	v16, v16, v20, v0.t
	sd	a0, 16(sp)
	csrr	a0, vlenb
	slli	a0, a0, 1
	add	a0, a0, sp
	addi	a0, a0, 120
	vl4re8.v	v20, (a0)                       # Unknown-size Folded Reload
	vadd.vv	v8, v8, v16, v0.t
	addi	a0, sp, 120
	vl2re8.v	v16, (a0)                       # Unknown-size Folded Reload
	vadd.vv	v8, v8, v12, v0.t
	csrr	a0, vlenb
	addi	a2, zero, 6
	mul	a0, a0, a2
	add	a0, a0, sp
	addi	a0, a0, 120
	vl4re8.v	v12, (a0)                       # Unknown-size Folded Reload
	vadd.vv	v28, v8, v28, v0.t
	csrr	a0, vlenb
	addi	a2, zero, 10
	mul	a0, a0, a2
	add	a0, a0, sp
	addi	a0, a0, 120
	vl4re8.v	v8, (a0)                        # Unknown-size Folded Reload
	vsrl.vx	v28, v28, a4, v0.t
	vsetvli	a2, zero, e32, m4, ta, mu
	vmerge.vvm	v28, v12, v28, v0
	vsetvli	zero, a6, e32, m4, ta, mu
	vadd.vv	v28, v28, v4
	vsetvli	a2, zero, e32, m4, ta, mu
	vmsltu.vx	v0, v8, a6
	vmerge.vvm	v4, v4, v28, v0
	csrr	a2, vlenb
	addi	a0, zero, 18
	mul	a2, a2, a0
	ld	a0, 16(sp)
	add	a2, a2, sp
	addi	a2, a2, 120
	vl4re8.v	v28, (a2)                       # Unknown-size Folded Reload
	addw	a7, a7, a6
	vadd.vx	v28, v28, a6
	bne	a7, t1, .LBB4_22
# %bb.23:                               # %middle.block
                                        #   in Loop: Header=BB4_13 Depth=3
	vsetivli	zero, 1, e32, m1, ta, mu
	vmv.v.i	v25, 0
	vsetvli	a1, zero, e32, m4, ta, mu
	vredsum.vs	v25, v4, v25
	vmv.x.s	t3, v25
	j	.LBB4_12
.LBB4_24:                               # %for.body.us.preheader
	ld	a0, 72(sp)                      # 8-byte Folded Reload
	slli	a1, a0, 32
	slli	a2, a3, 32
	mulhu	a0, a1, a2
	addi	a4, a0, -1
	ld	a3, 112(sp)                     # 8-byte Folded Reload
	mul	a5, t4, a3
	mulw	a3, t4, a3
	mul	s1, s9, t4
	addw	s1, s1, s5
	srai	s0, a3, 63
	add	a5, a5, s0
	xor	a5, a5, s0
	slli	a5, a5, 32
	slli	s0, a4, 32
	mulhu	s0, a5, s0
	srli	a5, s0, 32
	snez	a5, a5
	sext.w	s0, s0
	bltz	a3, .LBB4_26
# %bb.25:                               # %for.body.us.preheader
	not	s1, s1
.LBB4_26:                               # %for.body.us.preheader
	sltu	s1, s1, s0
	srli	a4, a4, 32
	snez	a4, a4
	snez	a3, a3
	and	a3, a3, a4
	or	a3, a3, s1
	or	a3, a3, a5
	beqz	a3, .LBB4_29
# %bb.27:                               # %for.body.us.preheader375
	mv	a0, zero
	srli	a1, a1, 32
	srli	a2, a2, 32
	mul	a1, a1, a2
	ld	a3, 104(sp)                     # 8-byte Folded Reload
.LBB4_28:                               # %for.body.us
                                        # =>This Inner Loop Header: Depth=1
	ld	a2, 112(sp)                     # 8-byte Folded Reload
	mul	a2, a0, a2
	add	a2, a2, s9
	mul	a2, a2, t4
	add	a2, a2, s5
	slli	a2, a2, 32
	srli	a2, a2, 31
	add	a2, a2, a3
	addi	a0, a0, 1
	sh	zero, 0(a2)
	bne	a1, a0, .LBB4_28
	j	.LBB4_31
.LBB4_29:                               # %vector.ph343
	mv	a1, zero
	vsetvli	a2, zero, e32, m2, ta, mu
	vid.v	v26
	vmset.m	v0
	vmv.v.x	v28, s9
	vmv.v.x	v30, s5
	vsetvli	zero, zero, e16, m1, ta, mu
	vmv.v.i	v25, 0
.LBB4_30:                               # %vector.body342
                                        # =>This Inner Loop Header: Depth=1
	sub	a2, a0, a1
	vsetvli	a2, a2, e16, m1, ta, mu
	vsetvli	zero, a2, e32, m2, ta, mu
	vmv2r.v	v8, v26
	ld	a3, 112(sp)                     # 8-byte Folded Reload
	vmadd.vx	v8, a3, v28
	vmadd.vx	v8, t4, v30
	vwaddu.vx	v12, v8, zero
	vsetvli	a3, zero, e64, m4, ta, mu
	vadd.vv	v8, v12, v12
	vsetvli	zero, a2, e16, m1, ta, mu
	ld	a3, 104(sp)                     # 8-byte Folded Reload
	vsoxei64.v	v25, (a3), v8, v0.t
	add	a1, a1, a2
	vsetvli	a3, zero, e32, m2, ta, mu
	vadd.vx	v26, v26, a2
	bne	a1, a0, .LBB4_30
.LBB4_31:                               # %for.cond.cleanup
	csrr	a0, vlenb
	addi	a1, zero, 22
	mul	a0, a0, a1
	add	sp, sp, a0
	ld	s11, 120(sp)                    # 8-byte Folded Reload
	ld	s10, 128(sp)                    # 8-byte Folded Reload
	ld	s9, 136(sp)                     # 8-byte Folded Reload
	ld	s8, 144(sp)                     # 8-byte Folded Reload
	ld	s7, 152(sp)                     # 8-byte Folded Reload
	ld	s6, 160(sp)                     # 8-byte Folded Reload
	ld	s5, 168(sp)                     # 8-byte Folded Reload
	ld	s4, 176(sp)                     # 8-byte Folded Reload
	ld	s3, 184(sp)                     # 8-byte Folded Reload
	ld	s2, 192(sp)                     # 8-byte Folded Reload
	ld	s1, 200(sp)                     # 8-byte Folded Reload
	ld	s0, 208(sp)                     # 8-byte Folded Reload
	ld	ra, 216(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 224
	ret
.Lfunc_end4:
	.size	psroi_align_golden, .Lfunc_end4-psroi_align_golden
                                        # -- End function
	.globl	psroi_pooling_align_golden      # -- Begin function psroi_pooling_align_golden
	.p2align	1
	.type	psroi_pooling_align_golden,@function
psroi_pooling_align_golden:             # @psroi_pooling_align_golden
# %bb.0:                                # %entry
	addi	sp, sp, -160
	sd	ra, 152(sp)                     # 8-byte Folded Spill
	sd	s0, 144(sp)                     # 8-byte Folded Spill
	sd	s1, 136(sp)                     # 8-byte Folded Spill
	sd	s2, 128(sp)                     # 8-byte Folded Spill
	sd	s3, 120(sp)                     # 8-byte Folded Spill
	sd	s4, 112(sp)                     # 8-byte Folded Spill
	sd	s5, 104(sp)                     # 8-byte Folded Spill
	sd	s6, 96(sp)                      # 8-byte Folded Spill
	sd	s7, 88(sp)                      # 8-byte Folded Spill
	sd	s8, 80(sp)                      # 8-byte Folded Spill
	sd	s9, 72(sp)                      # 8-byte Folded Spill
	sd	s10, 64(sp)                     # 8-byte Folded Spill
	sd	s11, 56(sp)                     # 8-byte Folded Spill
	lwu	a1, 28(a0)
	lwu	a2, 32(a0)
	mulw	s3, a2, a1
	beqz	s3, .LBB5_3
# %bb.1:                                # %for.body.preheader
	mv	s1, zero
	ld	a3, 8(a0)
	sd	a3, 48(sp)                      # 8-byte Folded Spill
	ld	a3, 16(a0)
	sd	a3, 40(sp)                      # 8-byte Folded Spill
	lwu	a3, 24(a0)
	lwu	a4, 36(a0)
	lwu	s9, 40(a0)
	lwu	s10, 44(a0)
	lbu	s11, 48(a0)
	lbu	s7, 49(a0)
	mul	a5, s9, a4
	mul	a5, a5, s10
	slli	a5, a5, 32
	srli	s2, a5, 32
	ld	s0, 0(a0)
	sext.w	s4, a3
	sext.w	s5, a1
	sext.w	s6, a2
	sext.w	s8, a4
.LBB5_2:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	sd	s7, 24(sp)
	sd	s11, 16(sp)
	sd	s10, 8(sp)
	sext.w	a4, s1
	sd	s9, 0(sp)
	mv	a0, s0
	ld	a1, 48(sp)                      # 8-byte Folded Reload
	ld	a2, 40(sp)                      # 8-byte Folded Reload
	mv	a3, s4
	mv	a5, s5
	mv	a6, s6
	mv	a7, s8
	call	psroi_align_golden
	addiw	s1, s1, 1
	add	s0, s0, s2
	bltu	s1, s3, .LBB5_2
.LBB5_3:                                # %for.cond.cleanup
	ld	s11, 56(sp)                     # 8-byte Folded Reload
	ld	s10, 64(sp)                     # 8-byte Folded Reload
	ld	s9, 72(sp)                      # 8-byte Folded Reload
	ld	s8, 80(sp)                      # 8-byte Folded Reload
	ld	s7, 88(sp)                      # 8-byte Folded Reload
	ld	s6, 96(sp)                      # 8-byte Folded Reload
	ld	s5, 104(sp)                     # 8-byte Folded Reload
	ld	s4, 112(sp)                     # 8-byte Folded Reload
	ld	s3, 120(sp)                     # 8-byte Folded Reload
	ld	s2, 128(sp)                     # 8-byte Folded Reload
	ld	s1, 136(sp)                     # 8-byte Folded Reload
	ld	s0, 144(sp)                     # 8-byte Folded Reload
	ld	ra, 152(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 160
	ret
.Lfunc_end5:
	.size	psroi_pooling_align_golden, .Lfunc_end5-psroi_pooling_align_golden
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, -128
	sd	ra, 120(sp)                     # 8-byte Folded Spill
	sd	s0, 112(sp)                     # 8-byte Folded Spill
	sd	s1, 104(sp)                     # 8-byte Folded Spill
	sd	s2, 96(sp)                      # 8-byte Folded Spill
	sd	s3, 88(sp)                      # 8-byte Folded Spill
	sd	s4, 80(sp)                      # 8-byte Folded Spill
	sd	s5, 72(sp)                      # 8-byte Folded Spill
	sd	s6, 64(sp)                      # 8-byte Folded Spill
	sd	s7, 56(sp)                      # 8-byte Folded Spill
	sd	s8, 48(sp)                      # 8-byte Folded Spill
	sd	s9, 40(sp)                      # 8-byte Folded Spill
	sd	s10, 32(sp)                     # 8-byte Folded Spill
	mv	a0, zero
	vsetvli	a1, zero, e8, m1, ta, mu
	vid.v	v25
	lui	a1, 88
	addiw	a1, a1, 192
	addi	a2, zero, 63
	lui	a3, %hi(src_arr_global)
	addi	s3, a3, %lo(src_arr_global)
.LBB6_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	sub	a3, a1, a0
	vsetvli	a3, a3, e8, m1, ta, mu
	vand.vx	v26, v25, a2
	add	a4, a0, s3
	vse8.v	v26, (a4)
	add	a0, a0, a3
	vsetvli	a4, zero, e8, m1, ta, mu
	vadd.vx	v25, v25, a3
	bne	a0, a1, .LBB6_1
# %bb.2:                                # %vector.ph56
	mv	a0, zero
	vsetvli	a1, zero, e64, m4, ta, mu
	vid.v	v28
	addi	a1, zero, 150
	vmset.m	v0
	vsetvli	zero, zero, e16, m1, ta, mu
	addi	a2, zero, 16
	vmv.v.x	v25, a2
	lui	a2, %hi(rois_arr_global)
	addi	s5, a2, %lo(rois_arr_global)
	vmv.v.i	v26, 1
	vmv.v.i	v27, 11
	vmv.v.i	v8, 2
.LBB6_3:                                # %vector.body55
                                        # =>This Inner Loop Header: Depth=1
	sub	a2, a1, a0
	vsetvli	a2, a2, e16, m1, ta, mu
	vsetvli	zero, a2, e64, m4, ta, mu
	vsll.vi	v12, v28, 3
	vsetvli	a3, zero, e64, m4, ta, mu
	vadd.vv	v16, v12, v12
	vsetvli	zero, a2, e16, m1, ta, mu
	vsoxei64.v	v26, (s5), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 1
	vsetvli	a3, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a2, e16, m1, ta, mu
	vsoxei64.v	v26, (s5), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 2
	vsetvli	a3, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a2, e16, m1, ta, mu
	vsoxei64.v	v27, (s5), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 3
	vsetvli	a3, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a2, e16, m1, ta, mu
	vsoxei64.v	v27, (s5), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 4
	vsetvli	a3, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a2, e16, m1, ta, mu
	vsoxei64.v	v8, (s5), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 5
	vsetvli	a3, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a2, e16, m1, ta, mu
	vsoxei64.v	v8, (s5), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v16, v12, 6
	vsetvli	a3, zero, e64, m4, ta, mu
	vadd.vv	v16, v16, v16
	vsetvli	zero, a2, e16, m1, ta, mu
	vsoxei64.v	v25, (s5), v16, v0.t
	vsetvli	zero, zero, e64, m4, ta, mu
	vor.vi	v12, v12, 7
	vsetvli	a3, zero, e64, m4, ta, mu
	vadd.vv	v12, v12, v12
	vsetvli	zero, a2, e16, m1, ta, mu
	vsoxei64.v	v25, (s5), v12, v0.t
	add	a0, a0, a2
	vsetvli	a3, zero, e64, m4, ta, mu
	vadd.vx	v28, v28, a2
	bne	a0, a1, .LBB6_3
# %bb.4:                                # %for.body.preheader.i
	mv	s1, zero
	#APP
	rdcycle	s4

	#NO_APP
	addi	s6, zero, 2
	addi	s7, zero, 40
	addi	s8, zero, 23
	lui	a0, %hi(out_arr_global)
	addi	s2, a0, %lo(out_arr_global)
	lui	a0, 2
	addiw	s9, a0, -832
	addi	s10, zero, 48
.LBB6_5:                                # %for.body.i20
                                        # =>This Inner Loop Header: Depth=1
	sd	zero, 24(sp)
	sd	s6, 16(sp)
	sd	s7, 8(sp)
	sext.w	s0, s1
	addi	a3, zero, 300
	addi	a5, zero, 7
	addi	a6, zero, 7
	addi	a7, zero, 8
	sd	s8, 0(sp)
	mv	a0, s3
	mv	a1, s5
	mv	a2, s2
	mv	a4, s0
	call	psroi_align_golden
	add	s3, s3, s9
	addi	s1, s1, 1
	bltu	s0, s10, .LBB6_5
# %bb.6:                                # %psroi_pooling_align_golden.exit
	#APP
	rdcycle	a0

	#NO_APP
	subw	a1, a0, s4
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	mv	a0, zero
	ld	s10, 32(sp)                     # 8-byte Folded Reload
	ld	s9, 40(sp)                      # 8-byte Folded Reload
	ld	s8, 48(sp)                      # 8-byte Folded Reload
	ld	s7, 56(sp)                      # 8-byte Folded Reload
	ld	s6, 64(sp)                      # 8-byte Folded Reload
	ld	s5, 72(sp)                      # 8-byte Folded Reload
	ld	s4, 80(sp)                      # 8-byte Folded Reload
	ld	s3, 88(sp)                      # 8-byte Folded Reload
	ld	s2, 96(sp)                      # 8-byte Folded Reload
	ld	s1, 104(sp)                     # 8-byte Folded Reload
	ld	s0, 112(sp)                     # 8-byte Folded Reload
	ld	ra, 120(sp)                     # 8-byte Folded Reload
	addi	sp, sp, 128
	ret
.Lfunc_end6:
	.size	main, .Lfunc_end6-main
                                        # -- End function
	.type	src_arr_global,@object          # @src_arr_global
	.data
	.globl	src_arr_global
	.p2align	3
src_arr_global:
	.byte	8                               # 0x8
	.zero	360639
	.size	src_arr_global, 360640

	.type	rois_arr_global,@object         # @rois_arr_global
	.bss
	.globl	rois_arr_global
	.p2align	3
rois_arr_global:
	.zero	2400
	.size	rois_arr_global, 2400

	.type	out_arr_global,@object          # @out_arr_global
	.globl	out_arr_global
	.p2align	3
out_arr_global:
	.zero	235200
	.size	out_arr_global, 235200

	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.8,"aMS",@progbits,1
	.p2align	3
.L.str:
	.asciz	"psroi_23x40x392x300 running cycles : %d.\n"
	.size	.L.str, 42

	.ident	"Terapines LTD zcc version 1.0.0 (https://www.terapines.com 153ecb6322f1f09cb4ffa189f112fa2836ff5f3b)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym src_arr_global
	.addrsig_sym rois_arr_global
	.addrsig_sym out_arr_global
