In this guide I will learn how to write a regression test 

# Step 0
Before running anything. Once you have opened your terminal window either through SSH or X2Go or REALVNC or whatever mode, you must run the setup file to ensure that your machine has the correct environmental variables. Because this is dependent on your system administrator please consult them first. There is another Tutorial [[Setting up setup-host.sh file]] that is about setting up your [[setup-host.sh]] file (OSU only). 

1) assuming you have it written correctly run `./setup-host.sh` in the directory that, that file is in. Often it will be in your `/home/user/cvw/setup-host.sh`

# Step 1
change `cvw/tests/riscof/Makefile` line 12. #'it out to only compile the wally riscv tests. This will cut down the test compilation time to 1-2 minutes.
`
```
all: root wally32 wally64 
#all: root arch32 wally32 wally32e arch64 wally64 
```
# Step 2
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

# Step 3
In this step we will add our actual test file to the lists of tests to execute. 

**Directory:** `/home/thkidd/Projects/cvw/tests/wally-riscv-arch-test/riscv-test-suite/rv64i_m/privilege/src`

The test file we want to write is: `WALLY-thomas-practice-01` This is what we added to the list of tests to be executed before. 

We will dive deeper into how to write these tests in the next tutorial. 

# Step 4
Make sure you do Step 0 if you are coming back from a earlier session of working on this!

In this step we will make the simulations. Go into the `sim` directory. Often something like `cvw/sim/` and run `make`. This will make all the tests that you need. Especially the one you just wrote. If something is wrong with your test in coding or syntax, an error should pop up here. These errors can be frustrating and make no sense. Take a deep breath and consult you, your partner, and your advisor / professor / TA. 

