- Open Core I2C controller: https://opencores.org/projects/i2c
- writing a kernel driver: https://www.kernel.org/doc/html/latest/i2c/writing-clients.html


# Step 1: change the config.vh file to add memory space

## config.vh
source: 
```location

cvw/config/rv64gc/config.vh
```

edited code
```config.vh
localparam I2C_SUPPORTED = 1'b1;
localparam logic [63:0] I2C_BASE = 64'h10000500;
localparam logic [63:0] I2C_RANGE = 64'h00000010;
```

- the range is from 10 because the i2C register block found in the Fu740-C000 Manual has an address range of 10. This info can be found in Table 98.

# MMU
## Step 2
#### File: pmachecker.sv

source:
```location
~/cvw/src/mmu/pmachecker.sv
```


expanded # of bits on line 47 of SelRegions from 10 to 11
```verilog
logic [11:0]                 SelRegions;
```

## Step 3
#### adrdecs.sv

source:
```location
~/cvw/src/mmu/adrdecs.sv
```

expanded the logic from 10 bits to 11 bits

```verilog
output logic [11:0]          SelRegions
```

added a new region of physcal memory. Added it to the top since we made the I2C the 11th bit

```verilog
adrdec #(P.PA_BITS) spidec(PhysicalAddress, P.I2C_BASE[P.PA_BITS-1:0], P.I2C_RANGE[P.PA_BITS-1:0], P.I2C_SUPPORTED, AccessRW, Size,  4'b0100, SelRegions[11]); // *** Double check supported size in specs
```

- Supported size is 4'b0100. This means 32 bits. The order is the following
	- 1000 = 64 bits
	- 0100 = 32 bits
	- 0010 = half word
	- 0001 = byte
- The supported size by SiFive is specifically 32 bits. 

#todo do we need to change the address map in step 1 to 32 bits because of this?

expanded the bit count from 10 to 11
```verilog
assign SelRegions[0] = ~|(SelRegions[11:1]); // none of the regions are selected
```
