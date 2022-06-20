	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p0_m2p0_a2p0_f2p0_d2p0_c2p0_v0p10"
	.option	nopic
	.file	"psroi.c"
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
	li	a6, 600
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
	.globl	psroi_pooling_align_vec         # -- Begin function psroi_pooling_align_vec
	.p2align	2
	.type	psroi_pooling_align_vec,@function
psroi_pooling_align_vec:                # @psroi_pooling_align_vec
# %bb.0:                                # %entry
	addi	sp, sp, -1328
	sw	ra, 1324(sp)                    # 4-byte Folded Spill
	sw	s0, 1320(sp)                    # 4-byte Folded Spill
	sw	s1, 1316(sp)                    # 4-byte Folded Spill
	sw	s2, 1312(sp)                    # 4-byte Folded Spill
	sw	s3, 1308(sp)                    # 4-byte Folded Spill
	sw	s4, 1304(sp)                    # 4-byte Folded Spill
	sw	s5, 1300(sp)                    # 4-byte Folded Spill
	sw	s6, 1296(sp)                    # 4-byte Folded Spill
	sw	s7, 1292(sp)                    # 4-byte Folded Spill
	sw	s8, 1288(sp)                    # 4-byte Folded Spill
	sw	s9, 1284(sp)                    # 4-byte Folded Spill
	sw	s10, 1280(sp)                   # 4-byte Folded Spill
	sw	s11, 1276(sp)                   # 4-byte Folded Spill
	csrr	a1, vlenb
	li	a2, 56
	mul	a1, a1, a2
	sub	sp, sp, a1
	li	a3, 0
	lw	a1, 4(a0)
	sw	a1, 52(sp)                      # 4-byte Folded Spill
	lw	a1, 12(a0)
	sw	a1, 24(sp)                      # 4-byte Folded Spill
	lw	a7, 16(a0)
	lw	a1, 20(a0)
	sw	a1, 16(sp)                      # 4-byte Folded Spill
	lw	a1, 24(a0)
	sw	a1, 56(sp)                      # 4-byte Folded Spill
	lw	s8, 28(a0)
	lw	s4, 32(a0)
	lbu	a6, 36(a0)
	lbu	a1, 37(a0)
	addi	a2, s8, -1
	addi	a4, s4, -1
	addi	t0, sp, 660
	li	s1, 300
	vsetvli	s0, zero, e16, m8, ta, mu
	sw	a2, 48(sp)                      # 4-byte Folded Spill
	vmv.v.x	v8, a2
	addi	s0, sp, 60
	sw	a4, 44(sp)                      # 4-byte Folded Spill
	vmv.v.x	v16, a4
.LBB3_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	slli	a4, a3, 1
	add	a2, t0, a4
	sub	a5, s1, a3
	vsetvli	a5, a5, e16, m8, ta, mu
	vse16.v	v8, (a2)
	add	a2, s0, a4
	add	a3, a3, a5
	vse16.v	v16, (a2)
	bne	a3, s1, .LBB3_1
# %bb.2:                                # %for.cond.cleanup
	lw	a2, 16(sp)                      # 4-byte Folded Reload
	mul	a2, a2, a7
	sw	a2, 20(sp)                      # 4-byte Folded Spill
	beqz	a2, .LBB3_18
# %bb.3:                                # %for.body38.lr.ph
	lw	s1, 56(sp)                      # 4-byte Folded Reload
	beqz	s1, .LBB3_11
# %bb.4:                                # %for.body38.us.preheader
	li	a5, 0
	sw	zero, 28(sp)                    # 4-byte Folded Spill
	mul	a3, s4, s8
	li	a2, 1
	sll	s2, a2, a1
	mul	a2, a3, s1
	sw	a2, 12(sp)                      # 4-byte Folded Spill
	lw	a4, 20(sp)                      # 4-byte Folded Reload
	mul	s0, a4, s1
	li	a2, 256
	lw	s1, 16(sp)                      # 4-byte Folded Reload
	divu	s1, a2, s1
	sw	s1, 40(sp)                      # 4-byte Folded Spill
	divu	a2, a2, a7
	sw	a2, 36(sp)                      # 4-byte Folded Spill
	lw	a2, 52(sp)                      # 4-byte Folded Reload
	addi	s1, a2, 4
	sw	s1, 32(sp)                      # 4-byte Folded Spill
	addi	s6, a2, 6
	addi	s7, a2, 2
	slli	a2, a6, 1
	andi	s9, a2, 254
	mv	s5, s0
	slli	s1, s0, 1
	slli	a4, a4, 1
	li	s11, 8
	li	s10, 3
	j	.LBB3_6
.LBB3_5:                                # %for.cond.cleanup47.us
                                        #   in Loop: Header=BB3_6 Depth=1
	lw	a2, 28(sp)                      # 4-byte Folded Reload
	addi	a2, a2, 1
	sw	a2, 28(sp)                      # 4-byte Folded Spill
	slli	a2, a2, 16
	srli	a5, a2, 16
	lw	a2, 20(sp)                      # 4-byte Folded Reload
	bgeu	a5, a2, .LBB3_18
.LBB3_6:                                # %for.body38.us
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_8 Depth 2
                                        #       Child Loop BB3_9 Depth 3
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	vsetvli	s3, a2, e16, m2, ta, mu
	beqz	s3, .LBB3_5
# %bb.7:                                # %for.body48.lr.ph.us
                                        #   in Loop: Header=BB3_6 Depth=1
	li	ra, 0
	lw	s0, 28(sp)                      # 4-byte Folded Reload
	slli	a2, s0, 16
	srli	t6, a2, 16
	lw	a2, 16(sp)                      # 4-byte Folded Reload
	divu	a6, a5, a2
	mul	a2, a6, a2
	sub	a7, a5, a2
	lw	a2, 12(sp)                      # 4-byte Folded Reload
	mul	a2, s0, a2
	slli	a2, a2, 16
	srli	t0, a2, 16
	addi	t3, sp, 660
	addi	t1, sp, 60
	lw	t2, 24(sp)                      # 4-byte Folded Reload
.LBB3_8:                                # %for.body48.us.us
                                        #   Parent Loop BB3_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_9 Depth 3
	lw	t5, 0(a0)
	lw	t4, 8(a0)
	lw	a2, 52(sp)                      # 4-byte Folded Reload
	vlse16.v	v8, (a2), s11
	vlse16.v	v10, (s7), s11
	lw	a2, 32(sp)                      # 4-byte Folded Reload
	vlse16.v	v12, (a2), s11
	vlse16.v	v14, (s6), s11
	vsub.vv	v12, v12, v8
	vmaxu.vx	v12, v12, s2
	vsub.vv	v14, v14, v10
	vmaxu.vx	v14, v14, s2
	lw	a2, 40(sp)                      # 4-byte Folded Reload
	vmul.vx	v12, v12, a2
	vsrl.vi	v12, v12, 8
	lw	a2, 36(sp)                      # 4-byte Folded Reload
	vmul.vx	v14, v14, a2
	vsrl.vi	v14, v14, 8
	vdivu.vx	v16, v12, s9
	vdivu.vx	v18, v14, s9
	vsetvli	zero, s3, e16, m2, tu, mu
	vmacc.vx	v10, a6, v14
	vmacc.vx	v8, a7, v12
	vsetvli	zero, zero, e16, m2, ta, mu
	vmul.vx	v14, v18, s10
	vmul.vx	v20, v16, s10
	vadd.vv	v22, v10, v18
	vadd.vv	v18, v10, v14
	vadd.vv	v28, v8, v16
	vadd.vv	v20, v8, v20
	vle16.v	v4, (t3)
	vle16.v	v6, (t1)
	vsrl.vx	v16, v22, a1
	vsrl.vx	v10, v28, a1
	lw	a2, 48(sp)                      # 4-byte Folded Reload
	vmsltu.vx	v0, v16, a2
	lw	a2, 44(sp)                      # 4-byte Folded Reload
	vmsltu.vx	v8, v10, a2
	vmnand.mm	v9, v0, v0
	vmnand.mm	v14, v8, v8
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v24, v4
	vadd.vi	v24, v16, 1, v0.t
	vmv.v.v	v2, v6
	vmv1r.v	v0, v8
	vadd.vi	v2, v10, 1, v0.t
	vmv.v.v	v26, v22
	vmv1r.v	v0, v9
	vsll.vx	v26, v16, a1, v0.t
	vmv.v.v	v8, v28
	vmv1r.v	v0, v14
	vsll.vx	v8, v10, a1, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vsll.vx	v12, v16, a1
	csrr	a2, vlenb
	li	a5, 54
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v12, (a2)                       # Unknown-size Folded Spill
	vsll.vx	v30, v10, a1
	vsub.vv	v12, v26, v12
	vsub.vv	v8, v8, v30
	vrsub.vx	v26, v12, s2
	vrsub.vx	v0, v8, s2
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v14, v10
	vmacc.vx	v14, s4, v24
	csrr	a2, vlenb
	li	a5, 48
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v14, (a2)                       # Unknown-size Folded Spill
	vmv2r.v	v14, v2
	vmacc.vx	v2, s4, v24
	csrr	a2, vlenb
	li	a5, 50
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v2, (a2)                        # Unknown-size Folded Spill
	vmv.v.v	v24, v10
	vmacc.vx	v24, s4, v16
	csrr	a2, vlenb
	li	a5, 44
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v24, (a2)                       # Unknown-size Folded Spill
	vmacc.vx	v14, s4, v16
	csrr	a2, vlenb
	li	a5, 46
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v14, (a2)                       # Unknown-size Folded Spill
	vsetvli	zero, zero, e16, m2, ta, mu
	vmul.vv	v24, v26, v0
	vmul.vv	v26, v26, v8
	vmul.vv	v0, v12, v0
	vmul.vv	v8, v12, v8
	vsrl.vx	v12, v24, a1
	csrr	a2, vlenb
	li	a5, 42
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v12, (a2)                       # Unknown-size Folded Spill
	vsrl.vx	v12, v26, a1
	csrr	a2, vlenb
	li	a5, 40
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v12, (a2)                       # Unknown-size Folded Spill
	vsrl.vx	v12, v0, a1
	csrr	a2, vlenb
	li	a5, 38
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v12, (a2)                       # Unknown-size Folded Spill
	vsrl.vx	v8, v8, a1
	csrr	a2, vlenb
	li	a5, 36
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v8, (a2)                        # Unknown-size Folded Spill
	vsrl.vx	v24, v18, a1
	vmsleu.vx	v0, v24, s8
	vmsleu.vx	v8, v10, s4
	vmnand.mm	v9, v0, v0
	vmnand.mm	v14, v8, v8
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v26, v4
	vadd.vi	v26, v24, 1, v0.t
	vmv.v.v	v2, v6
	vmv1r.v	v0, v8
	vadd.vi	v2, v10, 1, v0.t
	vmv1r.v	v0, v9
	vsll.vx	v18, v24, a1, v0.t
	vmv1r.v	v0, v14
	vsll.vx	v28, v10, a1, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	vsll.vx	v8, v24, a1
	vsub.vv	v8, v18, v8
	vsub.vv	v12, v28, v30
	vrsub.vx	v28, v8, s2
	vrsub.vx	v18, v12, s2
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v14, v10
	vmacc.vx	v14, s4, v24
	csrr	a2, vlenb
	slli	a2, a2, 5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v14, (a2)                       # Unknown-size Folded Spill
	vmv2r.v	v14, v2
	vmacc.vx	v14, s4, v24
	csrr	a2, vlenb
	li	a5, 30
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v14, (a2)                       # Unknown-size Folded Spill
	vmacc.vx	v10, s4, v26
	csrr	a2, vlenb
	li	a5, 52
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vmacc.vx	v2, s4, v26
	csrr	a2, vlenb
	li	a5, 34
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v2, (a2)                        # Unknown-size Folded Spill
	vsetvli	zero, zero, e16, m2, ta, mu
	vmv.v.v	v10, v28
	addi	a2, sp, 1264
	vs2r.v	v28, (a2)                       # Unknown-size Folded Spill
	vmul.vv	v28, v28, v18
	vmul.vv	v18, v8, v18
	vmul.vv	v30, v10, v12
	vmul.vv	v10, v8, v12
	vsrl.vx	v12, v28, a1
	csrr	a2, vlenb
	li	a5, 28
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v12, (a2)                       # Unknown-size Folded Spill
	vsrl.vx	v12, v30, a1
	csrr	a2, vlenb
	li	a5, 26
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v12, (a2)                       # Unknown-size Folded Spill
	vsrl.vx	v12, v18, a1
	csrr	a2, vlenb
	li	a5, 24
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v12, (a2)                       # Unknown-size Folded Spill
	vsrl.vx	v10, v10, a1
	csrr	a2, vlenb
	li	a5, 22
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vmsleu.vx	v0, v16, s8
	vsrl.vx	v18, v20, a1
	vmsleu.vx	v1, v18, s4
	vmnand.mm	v11, v0, v0
	vmnand.mm	v10, v1, v1
	vsetvli	zero, zero, e16, m2, tu, mu
	vadd.vi	v4, v16, 1, v0.t
	vmv1r.v	v0, v1
	vadd.vi	v6, v18, 1, v0.t
	vmv1r.v	v0, v11
	vsll.vx	v22, v16, a1, v0.t
	vmv1r.v	v0, v10
	vsll.vx	v20, v18, a1, v0.t
	vsetvli	zero, zero, e16, m2, ta, mu
	csrr	a2, vlenb
	li	a5, 54
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vl2re8.v	v10, (a2)                       # Unknown-size Folded Reload
	vsub.vv	v22, v22, v10
	vsll.vx	v10, v18, a1
	vsub.vv	v0, v20, v10
	vrsub.vx	v20, v22, s2
	vrsub.vx	v2, v0, s2
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v10, v18
	vmacc.vx	v10, s4, v16
	csrr	a2, vlenb
	li	a5, 18
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vmv2r.v	v10, v6
	vmacc.vx	v10, s4, v16
	csrr	a2, vlenb
	slli	a2, a2, 4
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vmv.v.v	v10, v18
	vmacc.vx	v10, s4, v4
	csrr	a2, vlenb
	li	a5, 14
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vmv2r.v	v10, v6
	vmacc.vx	v10, s4, v4
	csrr	a2, vlenb
	li	a5, 12
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vsetvli	zero, zero, e16, m2, ta, mu
	vmul.vv	v10, v20, v2
	vmul.vv	v28, v20, v0
	vmul.vv	v12, v22, v2
	vmul.vv	v4, v22, v0
	vsrl.vx	v10, v10, a1
	csrr	a2, vlenb
	li	a5, 10
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vsrl.vx	v10, v28, a1
	csrr	a2, vlenb
	slli	a2, a2, 3
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vsrl.vx	v10, v12, a1
	csrr	a2, vlenb
	li	a5, 6
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vsrl.vx	v10, v4, a1
	csrr	a2, vlenb
	slli	a2, a2, 2
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vsetvli	zero, zero, e16, m2, tu, mu
	vmv.v.v	v14, v18
	vmacc.vx	v14, s4, v24
	vmv2r.v	v10, v6
	vmacc.vx	v10, s4, v24
	csrr	a2, vlenb
	slli	a2, a2, 1
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v10, (a2)                       # Unknown-size Folded Spill
	vmacc.vx	v18, s4, v26
	csrr	a2, vlenb
	li	a5, 20
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v18, (a2)                       # Unknown-size Folded Spill
	vmacc.vx	v6, s4, v26
	csrr	a2, vlenb
	li	a5, 54
	mul	a2, a2, a5
	add	a2, a2, sp
	addi	a2, a2, 1264
	vs2r.v	v6, (a2)                        # Unknown-size Folded Spill
	vsetvli	zero, zero, e16, m2, ta, mu
	addi	a2, sp, 1264
	vl2re8.v	v10, (a2)                       # Unknown-size Folded Reload
	vmul.vv	v24, v10, v2
	vmul.vv	v26, v10, v0
	vmul.vv	v2, v8, v2
	vmul.vv	v0, v8, v0
	add	a5, t5, t0
	slli	a2, t6, 1
	add	a2, a2, t4
	mul	s0, ra, s5
	vsrl.vx	v4, v24, a1
	vsrl.vx	v24, v26, a1
	vsrl.vx	v6, v2, a1
	vsrl.vx	v26, v0, a1
	slli	s0, s0, 1
	add	s0, s0, a2
	lw	a2, 56(sp)                      # 4-byte Folded Reload
.LBB3_9:                                # %for.body63.us.us
                                        #   Parent Loop BB3_6 Depth=1
                                        #     Parent Loop BB3_8 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vsetvli	zero, zero, e8, m1, ta, mu
	csrr	t4, vlenb
	li	t5, 44
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v0, (a5), v8
	csrr	t4, vlenb
	li	t5, 46
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v1, (a5), v8
	csrr	t4, vlenb
	li	t5, 48
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v2, (a5), v8
	csrr	t4, vlenb
	li	t5, 50
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v3, (a5), v8
	vwaddu.vx	v12, v0, zero
	vwaddu.vx	v20, v1, zero
	vwaddu.vx	v0, v2, zero
	vwaddu.vx	v22, v3, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	csrr	t4, vlenb
	li	t5, 42
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmulu.vv	v16, v8, v12
	vsetvli	zero, zero, e16, m2, tu, mu
	csrr	t4, vlenb
	li	t5, 40
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmaccu.vv	v16, v8, v20
	csrr	t4, vlenb
	li	t5, 38
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmaccu.vv	v16, v8, v0
	csrr	t4, vlenb
	li	t5, 36
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmaccu.vv	v16, v8, v22
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wx	v2, v16, a1
	vsetvli	zero, zero, e8, m1, ta, mu
	csrr	t4, vlenb
	slli	t4, t4, 5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v12, (a5), v8
	csrr	t4, vlenb
	li	t5, 30
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v13, (a5), v8
	csrr	t4, vlenb
	li	t5, 52
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v16, (a5), v8
	csrr	t4, vlenb
	li	t5, 34
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v17, (a5), v8
	vwaddu.vx	v18, v12, zero
	vwaddu.vx	v20, v13, zero
	vwaddu.vx	v12, v16, zero
	vwaddu.vx	v22, v17, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	csrr	t4, vlenb
	li	t5, 28
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmulu.vv	v28, v8, v18
	vsetvli	zero, zero, e16, m2, tu, mu
	csrr	t4, vlenb
	li	t5, 26
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v20
	csrr	t4, vlenb
	li	t5, 24
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v12
	csrr	t4, vlenb
	li	t5, 22
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v22
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wx	v0, v28, a1
	vsetvli	zero, zero, e8, m1, ta, mu
	csrr	t4, vlenb
	li	t5, 18
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v12, (a5), v8
	csrr	t4, vlenb
	slli	t4, t4, 4
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v13, (a5), v8
	csrr	t4, vlenb
	li	t5, 14
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v16, (a5), v8
	csrr	t4, vlenb
	li	t5, 12
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v17, (a5), v8
	vwaddu.vx	v18, v12, zero
	vwaddu.vx	v20, v13, zero
	vwaddu.vx	v12, v16, zero
	vwaddu.vx	v22, v17, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	csrr	t4, vlenb
	li	t5, 10
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmulu.vv	v28, v8, v18
	vsetvli	zero, zero, e16, m2, tu, mu
	csrr	t4, vlenb
	slli	t4, t4, 3
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v20
	csrr	t4, vlenb
	li	t5, 6
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v12
	csrr	t4, vlenb
	slli	t4, t4, 2
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vwmaccu.vv	v28, v8, v22
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wx	v12, v28, a1
	vsetvli	zero, zero, e8, m1, ta, mu
	vloxei16.v	v16, (a5), v14
	csrr	t4, vlenb
	slli	t4, t4, 1
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v17, (a5), v8
	csrr	t4, vlenb
	li	t5, 20
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v18, (a5), v8
	csrr	t4, vlenb
	li	t5, 54
	mul	t4, t4, t5
	add	t4, t4, sp
	addi	t4, t4, 1264
	vl2re8.v	v8, (t4)                        # Unknown-size Folded Reload
	vloxei16.v	v19, (a5), v8
	vwaddu.vx	v20, v16, zero
	vwaddu.vx	v22, v17, zero
	vwaddu.vx	v16, v18, zero
	vwaddu.vx	v28, v19, zero
	vsetvli	zero, zero, e16, m2, ta, mu
	vwmulu.vv	v8, v4, v20
	vsetvli	zero, zero, e16, m2, tu, mu
	vwmaccu.vv	v8, v24, v22
	vwmaccu.vv	v8, v6, v16
	vwmaccu.vv	v8, v26, v28
	vsetvli	zero, zero, e16, m2, ta, mu
	vnsrl.wx	v16, v8, a1
	vadd.vv	v8, v2, v0
	vadd.vv	v8, v8, v12
	vadd.vv	v8, v8, v16
	vsrl.vi	v8, v8, 2
	vsse16.v	v8, (s0), s1
	add	a5, a5, a3
	addi	a2, a2, -1
	add	s0, s0, a4
	bnez	a2, .LBB3_9
# %bb.10:                               # %for.cond59.for.cond.cleanup62_crit_edge.us.us
                                        #   in Loop: Header=BB3_8 Depth=2
	slli	a2, s3, 1
	add	t3, t3, a2
	add	ra, ra, s3
	sub	t2, t2, s3
	vsetvli	s3, t2, e16, m2, ta, mu
	add	t1, t1, a2
	bnez	s3, .LBB3_8
	j	.LBB3_5
.LBB3_11:                               # %for.body38.preheader
	li	a0, 0
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	vsetvli	a1, a2, e16, m2, ta, mu
	bnez	a1, .LBB3_14
.LBB3_12:                               # %for.cond.cleanup47
                                        # =>This Inner Loop Header: Depth=1
	addi	a0, a0, 1
	slli	a1, a0, 16
	srli	a1, a1, 16
	lw	a2, 20(sp)                      # 4-byte Folded Reload
	bgeu	a1, a2, .LBB3_18
# %bb.13:                               # %for.body38
                                        #   in Loop: Header=BB3_12 Depth=1
	lw	a2, 24(sp)                      # 4-byte Folded Reload
	vsetvli	a1, a2, e16, m2, ta, mu
	beqz	a1, .LBB3_12
.LBB3_14:                               # %for.body48
                                        # =>This Inner Loop Header: Depth=1
	sub	a1, a2, a1
	vsetvli	a2, a1, e16, m2, ta, mu
	beqz	a2, .LBB3_12
# %bb.15:                               # %for.body48.1
                                        #   in Loop: Header=BB3_14 Depth=1
	sub	a1, a1, a2
	vsetvli	a2, a1, e16, m2, ta, mu
	beqz	a2, .LBB3_12
# %bb.16:                               # %for.body48.2
                                        #   in Loop: Header=BB3_14 Depth=1
	sub	a1, a1, a2
	vsetvli	a2, a1, e16, m2, ta, mu
	beqz	a2, .LBB3_12
# %bb.17:                               # %for.body48.3
                                        #   in Loop: Header=BB3_14 Depth=1
	sub	a2, a1, a2
	vsetvli	a1, a2, e16, m2, ta, mu
	bnez	a1, .LBB3_14
	j	.LBB3_12
.LBB3_18:                               # %for.cond.cleanup37
	csrr	a0, vlenb
	li	a1, 56
	mul	a0, a0, a1
	add	sp, sp, a0
	lw	ra, 1324(sp)                    # 4-byte Folded Reload
	lw	s0, 1320(sp)                    # 4-byte Folded Reload
	lw	s1, 1316(sp)                    # 4-byte Folded Reload
	lw	s2, 1312(sp)                    # 4-byte Folded Reload
	lw	s3, 1308(sp)                    # 4-byte Folded Reload
	lw	s4, 1304(sp)                    # 4-byte Folded Reload
	lw	s5, 1300(sp)                    # 4-byte Folded Reload
	lw	s6, 1296(sp)                    # 4-byte Folded Reload
	lw	s7, 1292(sp)                    # 4-byte Folded Reload
	lw	s8, 1288(sp)                    # 4-byte Folded Reload
	lw	s9, 1284(sp)                    # 4-byte Folded Reload
	lw	s10, 1280(sp)                   # 4-byte Folded Reload
	lw	s11, 1276(sp)                   # 4-byte Folded Reload
	addi	sp, sp, 1328
	ret
.Lfunc_end3:
	.size	psroi_pooling_align_vec, .Lfunc_end3-psroi_pooling_align_vec
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	li	a1, 0
	vsetvli	a0, zero, e8, m4, ta, mu
	vid.v	v8
	lui	a0, 88
	addi	a2, a0, 192
	li	a3, 63
	lui	a0, %hi(src_arr_global)
	addi	a6, a0, %lo(src_arr_global)
.LBB4_1:                                # %vector.body
                                        # =>This Inner Loop Header: Depth=1
	sub	a4, a2, a1
	vsetvli	a4, a4, e8, m4, ta, mu
	vand.vx	v12, v8, a3
	add	a5, a1, a6
	vse8.v	v12, (a5)
	add	a1, a1, a4
	vsetvli	a5, zero, e8, m4, ta, mu
	vadd.vx	v8, v8, a4
	bne	a1, a2, .LBB4_1
# %bb.2:                                # %vector.body41.preheader
	li	a2, 0
	li	a3, 600
	lui	a1, %hi(rois_arr_global)
	addi	a7, a1, %lo(rois_arr_global)
	vsetvli	a4, zero, e16, m4, ta, mu
	vmv.v.i	v8, 1
	li	a4, 16
	vmv.v.i	v12, 11
	vmv.v.i	v16, 2
	vmv.v.x	v20, a4
.LBB4_3:                                # %vector.body41
                                        # =>This Inner Loop Header: Depth=1
	sub	a5, a3, a2
	vsetvli	a5, a5, e16, m4, ta, mu
	slli	a0, a2, 4
	add	a0, a0, a7
	vsse16.v	v8, (a0), a4
	addi	a1, a0, 2
	vsse16.v	v8, (a1), a4
	addi	a1, a0, 4
	vsse16.v	v12, (a1), a4
	addi	a1, a0, 6
	vsse16.v	v12, (a1), a4
	addi	a1, a0, 8
	vsse16.v	v16, (a1), a4
	addi	a1, a0, 10
	vsse16.v	v16, (a1), a4
	addi	a1, a0, 12
	vsse16.v	v20, (a1), a4
	addi	a0, a0, 14
	add	a2, a2, a5
	vsse16.v	v20, (a0), a4
	bne	a2, a3, .LBB4_3
# %bb.4:                                # %global_arr_init.exit
	li	a0, 300
	sw	a0, 12(sp)
	li	a0, 7
	sw	a0, 16(sp)
	sw	a0, 20(sp)
	li	a0, 8
	sw	a0, 24(sp)
	li	a0, 23
	sw	a0, 28(sp)
	li	a0, 40
	sw	a0, 32(sp)
	li	a0, 2
	sh	a0, 36(sp)
	sw	a6, 0(sp)
	sw	a7, 4(sp)
	lui	a0, %hi(out_arr_global)
	addi	a0, a0, %lo(out_arr_global)
	sw	a0, 8(sp)
	#APP
	csrr	s0, mcycle

	#NO_APP
	mv	a0, sp
	call	psroi_pooling_align_vec
	#APP
	csrr	a0, mcycle

	#NO_APP
	sub	a1, a0, s0
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	li	a0, 0
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
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
