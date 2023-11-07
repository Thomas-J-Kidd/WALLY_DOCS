In this guide I will learn how to write a regression test 

# Step 0
Before running anything. Once you have opened your terminal window either through SSH or X2Go or REALVNC or whatever mode, you must run the setup file to ensure that your machine has the correct environmental variables. Because this is dependent on your system administrator please consult them first. There is another Tutorial [[Setting up setup-host.sh file]] that is about setting up your [[setup-host.sh]] file (OSU only). 

1) assuming you have it written correctly run `./setup-host.sh` in the directory that, that file is in. Often it will be in your `/home/user/cvw/setup-host.sh`

# Step 1 Decide which tests to you want to build
change `cvw/tests/riscof/Makefile` line 12. #'it out to only compile the wally riscv tests. This will cut down the test compilation time to 1-2 minutes.  Making the `root arch32 wally32 wally32e arch64 wally64 ` tests is important for verifying that our processor is RISCV compliant. If we cant pass the `arch32` or `arch64` tests then we cannot use the RISCV trademark on our processor implementation. The other tests: `wally32. wally32e wally64` are tests that we want to pass. Building the tests for `arch32` and `arch64` take about an hour or two. So be careful with which tests you need to build! 
`
```
all: root wally32 wally64 
#all: root arch32 wally32 wally32e arch64 wally64 
```
# Step 2 Adding our test to be built and used
In this step we will add our test to a list of tests to tell the software which tests to execute. In Step 3 we will add the test to a directory so that it can actually execute our test.

We need to add our test in this file:
```
/home/thkidd/Projects/cvw/tests/wally-riscv-arch-test/riscv-test-suite/rv64i_m/privilege/Makefrag
``` 

Since we are writing our test for the 64 bit version of wally, we will add it to the `rv64i_m` directory. 

My test is called `WALLY-thomas-practice-01`

```testfile
rv64i_sc_tests = \
    WALLY-mmu-sv39 \
    WALLY-mmu-sv48 \
    WALLY-pmp \
    WALLY-minfo-01 \
    WALLY-csr-permission-s-01 \
    WALLY-csr-permission-u-01 \
    WALLY-misa-01 \
    WALLY-amo \
    WALLY-lrsc \
    WALLY-trap-sret-01 \
    WALLY-status-mie-01 \
    WALLY-status-sie-01 \
    WALLY-status-tw-01 \
    WALLY-thomas-practice-01 \
```

In this file you will see two test lists. `rv64i_sc_tests` and `target_tests_nosim`. The `rv64i_sc_tests` is for the spike tests where the signature to verify the tests is generated. The second list, `target_tests_nosim`, is for tests where we have to write our own signatures. This is because spike cannot generate them for some reasons like testing a peripheral device. The spike processor that we are comparing against does not have an I2C peripheral for example, and thus cannot create a signature to verify our tests. 

# Step 3 Create our test
In this step we will add our actual test file to the lists of tests to execute. 

**Directory:** `/home/thkidd/Projects/cvw/tests/wally-riscv-arch-test/riscv-test-suite/rv64i_m/privilege/src`

The test file we want to write is: `WALLY-thomas-practice-01.S` This is what we added to the list of tests to be executed before. 

We will dive deeper into how to write these tests in the next tutorial. 

For now just add this regression test:

```regression-test
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

```

# Step 4 Make our test
Make sure you do Step 0 if you are coming back from a earlier session of working on this!

In this step we will make the simulations. Go into the `sim` directory. Often something like `cvw/sim/` and run `make`. This will make all the tests that you need. Especially the one you just wrote. If something is wrong with your test in coding or syntax, an error should pop up here. These errors can be frustrating and make no sense. Take a deep breath and consult you, your partner, and your advisor / professor / TA. 

Once your tests are made, we can now test those tests. Before we jump into that here is some important information.  Something helpful before you start this process is to familiarize yourself with what this make command outputs. Lets see what you can learn!

1) run `make | tee make.log` This will output the file into a text file called `make.log` You can name it whatever you would like. 
2) Inspect the file
3) Search for your test! In vim if you are normal mode (not insert mode, just hit ESC a couple of times for good measures) you can use the `/` key to search for phrases. Once you hit enter you can you `n` to go to the next finding of that keyword or `N` to go back the the previous location of that keyword. 
4) You should find something like this
```
riscv64-unknown-elf-elf2hex --bit-width 64 --input ../tests/riscof/work/wally-riscv-arch-test/rv64i_m/privilege/src/WALLY-thomas-practice-01.S/ref/ref.elf --output ../tests/riscof/work/wally-riscv-arch-test/rv64i_m/privilege/src/WALLY-thomas-practice-01.S/ref/ref.elf.memfile

```





# Step 5 Execute testing

When you want to execute testing, we can do this in either of two ways. Either with through a GUI or through the terminal. Terminal verification can be nice for quick checks, but for catching the actual bug in your HDL or test is almost impossible. 

### Terminal Testing
To complete a terminal test you can run the following commands. 
1) Make sure you are in the `./sim` directory using `pwd` (print working directory) 
2) Execute `./sim-wally-batch` This should output you a long text file of each test results. To better understand what the results are giving you I recommend you to save the output of the test into a file. You can do this with the following command: `./sim-wally-batch | tee batch.log` You can name your file almost anything. I used `batch.log`
3) You can use vim or any other text editor. I highly recommend learning vim for just 10 minutes, as in my opinion the "vim motions" will help you navigate text files much faster. 
4) To see if your test passed you can search for your test #TODO **is this true????????**


#TODO what about ./regresson-wally

### GUI testing
To complete the GUI testing you will need to execute the following commands
1) Make sure you are in the `./sim` directory using `pwd`
2) Execute `./sim-wally` This should pull up QUESTA
![Questa-sim](Questa-sim.png)

# Common Errors

### RISCV-OF error

If you get something like this:

```bash
thkidd@wally-gpu:~/Wally/cvw$ cd sim
thkidd@wally-gpu:~/Wally/cvw/sim$ make
make -C ../tests/riscof/ 
make[1]: Entering directory '/home/thkidd/Wally/cvw/tests/riscof'
mkdir -p ./riscof_work
mkdir -p ./work
mkdir -p ./work/riscv-arch-test
mkdir -p ./work/wally-riscv-arch-test
sed 's,{0},/home/thkidd/Wally/cvw/tests/riscof,g;s,{1},32gc,g' config.ini > config32.ini
sed 's,{0},/home/thkidd/Wally/cvw/tests/riscof,g;s,{1},64gc,g' config.ini > config64.ini
sed 's,{0},/home/thkidd/Wally/cvw/tests/riscof,g;s,{1},32e,g' config.ini > config32e.ini
riscof run --work-dir=./riscof_work --config=config32.ini --suite=../wally-riscv-arch-test/riscv-test-suite/ --env=../wally-riscv-arch-test/riscv-test-suite/env --no-browser --no-dut-run
make[1]: riscof: No such file or directory
make[1]: *** [Makefile:34: wally32] Error 127
make[1]: Leaving directory '/home/thkidd/Wally/cvw/tests/riscof'
make: *** [Makefile:51: riscoftests] Error 2
```

You might need to install riscof since its looking for it in your home directory

Use `pip3 install git+https://github.com/riscv/riscof.git` to install riscvof. 

To learn more about [[riscvof]] read this document


# Riscv_sim_RV32  or 64
Error: `ERROR | riscv_sim_RV32: executable not found. Please check environment setup.`
`ERROR | riscv_sim_RV64: executable not found. Please check environment setup.`

This error is most likely related to not having riscv-sail installed: https://github.com/riscv/sail-riscv

If you get this error definitely consult your instructor or TA as installing Sail can be difficult, especially if you don't feel comfortable with using terminal tools. 

For those who are daring you can find the install instructions in the `cvw/bin/wally-tool-chain-install.sh` file

The instructions should look something like this:

```bash
opam init -y --disable-sandboxing  
opam switch create ocaml-base-compiler.4.08.0  
opam install sail -yeval $(opam config env)  
git clone [https://github.com/riscv/sail-riscv.git](https://github.com/riscv/sail-riscv.git)  
cd sail-riscv  
# For now, use checkout that is stable for Wally  
git checkout 72b2516d10d472ac77482fd959a9401ce3487f60  
make -j 2  
ARCH=RV32 make -j 2  
sudo ln -sf $RISCV/sail-riscv/c_emulator/riscv_sim_RV64 /usr/bin/riscv_sim_RV64  
sudo ln -sf $RISCV/sail-riscv/c_emulator/riscv_sim_RV32 /usr/bin/riscv_sim_RV32
```