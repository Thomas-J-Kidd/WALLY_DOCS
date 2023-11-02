///////////////////////////////////////////
//
// WALLY-cache-management-tests 
// invalidate, clean, and flush
//
// Author: Rose Thompson <ross1728@gmail.com>
//
// Created 22 August 2023
//
// Copyright (C) 2021 Harvey Mudd College & Oklahoma State University
# Purpose: Tests the Zicboz cache instruction which all operate on cacheline
#          granularity blocks of memory.  The instruction cbo.zero allocates a cacheline
#          and writes 0 to each byte.  A dirty cacheline is overwritten, any data in main
#          memory is over written.        
# -----------
# Copyright (c) 2020. RISC-V International. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
# -----------
#
# This assembly file tests the cbo.zero instruction of the RISC-V Zicboz extension.
# 

#include "model_test.h"
#include "arch_test.h"
RVTEST_ISA("RV64I")
# Test code region
.section .text.init
.globl rvtest_entry_point
	
rvtest_entry_point:
RVMODEL_BOOT
RVTEST_CODE_BEGIN

RVTEST_CASE(0,"//check ISA:=regex(.*64.*);check ISA:=regex(.*I.*);def TEST_CASE_1=True;",add)
	
# Testcase 0:  rs1:x20(0x0000000000000000), rs2:x22(0x0000000000000000), result rd:x3(0x0000000000000000)
li x20, MASK_XLEN(0x0000000000000000)
li x22, MASK_XLEN(0x0000000000000000)
ADD x3, x20, x22
sd x3, 0(x6)

# Testcase 1:  rs1:x1(0x0000000000000000), rs2:x4(0x0000000000000001), result rd:x21(0x0000000000000001)
li x1, MASK_XLEN(0x0000000000000000)
li x4, MASK_XLEN(0x0000000000000001)
ADD x21, x1, x4
sd x21, 8(x6)
	
.EQU NUMTESTS,2
	
RVTEST_CODE_END
RVMODEL_HALT

RVTEST_DATA_BEGIN
.align 4
rvtest_data:
.word 0x98765432
RVTEST_DATA_END

RVMODEL_DATA_BEGIN


wally_signature:
    .fill NUMTESTS*(XLEN/32),4,0xdeadbeef

#ifdef rvtest_mtrap_routine

mtrap_sigptr:
    .fill 64*(XLEN/32),4,0xdeadbeef

#endif

#ifdef rvtest_gpr_save

gpr_save:
    .fill 32*(XLEN/32),4,0xdeadbeef

#endif

RVMODEL_DATA_END
// ../wally-riscv-arch-test/riscv-test-suite/rv64i_m/I/src/WALLY-ADD.S
// David_Harris@hmc.edu & Katherine Parry
