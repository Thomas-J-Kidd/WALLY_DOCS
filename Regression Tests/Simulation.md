# Introduction

Welcome to the `./sim` directory. This is where most of the simulations are ran. Its important that you have a good understanding of this directory as simulation and verification is a very important part of creating anything in engineering. Each industry has their own version of testing. Some might drop a phone from 10ft others might blow up a rocket. 

Since we are writing hardware but using software to do it, we can do software based simulations to test our "hardware". Imagine how expensive it would be (and time consuming which is more expensive) to get Wally manufactured or [synthesized](synthesys.md) on an FPGA. Because of this we do testing! 

Simulations need tests. That is where the followup guide comes in on [Writing a basic regression test](Writing%20a%20basic%20regression%20test.md). While that guide just gives you the basics of how to write one, before you jump down that rabbit hole, please finish reading this guide here. We will go into detail of what you are testing, why, and with what software. 

Throughout this guide I am referencing much of the information found in the resources section of this document. 
# What are we testing and what kind of testing is there

There are two kinds of testing. Simulation based and hardware based testing. In each type of testing we have advantages and disadvantages. Within each of these categories there are many kinds of different testing and for our purposes we will focus on the software testing. 

The recommendation by the RISCV foundation is the following: 

A RISC-V processor verification project requires four key items:

- A test and verification plan
- The RTL to test (DUT – Device Under Test)
- Some tests to run
- A reference model to compare the results against

#TODO some import things to look into when writing this document are
- SAIL
- riscof
- 

## Test and Verification Plan


## The RTL to test


## Some tests to run


## A reference model to compare the results against



# What is in our `sim` directory

In Wally's sim directory you can find some interesting things. Lets break them down into different categories. This is everything that should be in the sim directory: 

```bash
-rwxrwxr-x  1      7542 Nov  3 13:16 bpred-sim.py
drwxrwxr-x  2      4096 Nov  3 13:16 bp-results
-rw-rw-r--  1    115484 Nov  6 09:17 branch.log
-rwxrwxr-x  1      1777 Nov  3 13:16 buildrootBugFinder.py
drwxrwxr-x  2      4096 Nov  6 09:17 cov
-rwxrwxr-x  1       129 Nov  3 13:16 coverage
-rw-rw-r--  1     19310 Nov  3 13:16 coverage-exclusions-rv64gc.do
-rw-rw-r--  1    198976 Nov  6 09:17 DCache.log
-rw-rw-r--  1      1973 Nov  3 13:16 FPbuild.txt
-rw-rw-r--  1     56687 Nov  3 13:16 fpga-wave.do
-rw-rw-r--  1       453 Nov  3 13:16 GetLineNum.do
-rw-rw-r--  1   1069692 Nov  6 09:17 ICache.log
-rw-rw-r--  1      2996 Nov  3 13:16 imperas.ic
-rwxrwxr-x  1      1143 Nov  3 13:16 lint-wally
-rw-rw-r--  1     37122 Nov  3 13:16 linux-wave.do
drwxrwxr-x  2      4096 Nov  6 09:17 logs
-rw-rw-r--  1      3161 Nov  3 13:16 Makefile
-rw-rw-r--  1      1559 Nov  3 13:16 makefile-memfile
-rw-rw-r--  1     34202 Nov  3 14:05 make.log
-rwxrwxr-x  1       286 Nov  3 13:16 make-tests.sh
-rwxrwxr-x  1      8928 Nov  3 13:16 regression-wally
-rwxrwxr-x  1       625 Nov  3 13:16 run-imperasdv-tests.bash
-rwxrwxr-x  1       307 Nov  3 13:16 run-imperas-linux.sh
-rwxrwxr-x  1      3293 Nov  3 13:16 rv64gc_CacheSim.py
-rwxrwxr-x  1       643 Nov  3 13:16 sim-buildroot
-rwxrwxr-x  1       704 Nov  3 13:16 sim-buildroot-batch
-rwxrwxr-x  1      1381 Nov  3 13:16 sim-imperas
-rwxrwxr-x  1       366 Nov  3 13:16 sim-testfloat
-rwxrwxr-x  1       398 Nov  3 13:16 sim-testfloat-batch
-rwxrwxr-x  1        43 Nov  3 13:16 sim-wally
-rwxrwxr-x  1        51 Nov  3 13:16 sim-wally-batch
drwxrwxr-x  2      4096 Nov  3 13:16 slack-notifier
-rw-rw-r--  1         0 Nov  3 13:37 sys,os,shutil
```



# Verification
## Objectdump




















# Resources
- [synthesized](synthesys.md)
- https://riscv.org/blog/2020/05/getting-started-with-risc-v-verification/
- https://riscv.org/wp-content/uploads/2019/12/12.10-16.10b-Open-Source-Verification-Platform-for-RISC-V-Processors.pdf
- https://github.com/riscv/sail-riscv
- https://riscof.readthedocs.io/en/latest/intro.html