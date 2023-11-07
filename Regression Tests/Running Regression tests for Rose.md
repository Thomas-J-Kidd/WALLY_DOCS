Run tests gui mode

## Description
I'm creating a branch called Zicclsm with the misaligned access support.  

After you modify the signature you need to remake the regression tests, but to make them quickly **change the Makefile in cvw/tests/riscof to only build wally32 and wally64 by uncommenting line 11 and commenting line 12.** Don't commit this change.  
You'll probably have lots of questions so fell free to ask for help.

## Goal
get the regression test to run and match with the signature
## Location
The regression test is located in: 
```
cvw/tests/wally-riscv-arch-test/riscv-test-suite/rv64i_m/privilege/src/WALLY-misaligned-access-01.S  
```
The signature output is in :
```
cvw/tests/wally-riscv-arch-test/riscv-test-suite/rv64i_m/privilege/references/WALLY-misaligned-access-01.reference_output
```


# Step 0 Verify tests are there
Done

# Step 1 Make the tests
In `/home/thkidd/Wally/zicclsm_cvw/sim` I ran make

I directed the output into a file called `make.log` to analyze where the `.objdump` files are located. 

Rose's test `WALLY-misaligned-access-01` gives the following search
```bash
riscv64-unknown-elf-elf2hex --bit-width 64 --input ../tests/riscof/work/wally-riscv-arch-test/rv64i_m/privilege/src/WALLY-misaligned-access-01.S/ref/ref.elf --output ../tests/riscof/work/wally-riscv-arch-test/rv64i_m/privilege/src/WALLY-misaligned-access-01.S/ref/ref.elf.memfile

```

``` bash
extractFunctionRadix.sh ../tests/riscof/work/wally-riscv-arch-test/rv64i_m/privilege/src/WALLY-misaligned-access-01.S/ref/ref.elf.objdump

```


# Step 2
I ran `./sim-wally-batch` and outputted it to the following file: `batch.log`

If I search for `misaligned-access-01` I cannot find anything. I can find other things like 

```
# Read memfile ../tests/riscof/work/wally-riscv-arch-test/rv64i_m/privilege/src/WALLY-misa-01.S/ref/ref.elf.memfile

```


