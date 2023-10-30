The control unit will control how the SPI module is being used. Instructions can come into the control unit that will decode them and then use this information to do what SPI does. So what does SPI do?

## What do we need to control in SPI?

### Clock Generation

The Control Unit will need to generate the clock signal using the [[Parameterized Baud Rate Generator (BRG)]] This will make our current unit the **Controller** while the other side is called the **peripheral**

#### Clock polarity (CPOL)
- SCLKCPOL=0 is a clock which idles at the [logical low](https://en.wikipedia.org/wiki/Logical_low "Logical low") voltage.
- SCLKCPOL=1 is a clock which idles at the logical high voltage.

#### Clock Phase (CPHA)

- For CPHA=0:
    - The first data bit is outputted _immediately_ when CS activates.
    - Subsequent bits are outputted when SCLK transitions _to_ its idle voltage level.
    - Sampling occurs when SCLK transitions _from_ its idle voltage level.
- For CPHA=1:
    - The first data bit is outputted on SCLK's first clock edge _after_ CS activates.
    - Subsequent bits are outputted when SCLK transitions _from_ its idle voltage level.
    - Sampling occurs when SCLK transitions _to_ its idle voltage level.

### Sending Data in and out

##### MISO
When data is sent from the controller to a peripheral, it's sent on a data line called **PICO,** for **"Peripheral In / Controller Out"**. 

##### MOSI (using tri state outputs on sub devices?)
If the peripheral needs to send a response back to the controller, the controller will continue to generate a prearranged number of clock cycles, and the peripheral will put the data onto a third data line called **POCI**, for **"Peripheral Out / Controller In"**.

![[Pasted image 20230914094348.png]]

### Chip Select (CS) - active low
There's one last line you should be aware of, called CS for Chip Select. This tells the peripheral that it should wake up and receive / send data and is also used when multiple peripherals are present to select the one you'd like to talk to.

The chip select line uses **active low**

### Interrupt Signal?
