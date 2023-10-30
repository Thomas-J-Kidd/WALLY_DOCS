Resource: https://www.electronics-tutorials.ws/sequential/seq_5.html

A shift register will have some data come in and then move the data "over" to another register every clock cycle. 

It consists of several d latches for each bit. Its function is to store some value before it is used in a operation. The device is also driven by a common clock making it a synchronous device. 

## Configuration

- Serial-in to Parallel-out (SIPO)  –  the register is loaded with serial data, one bit at a time, with the stored data being available at the output in parallel form.
- Serial-in to Serial-out (SISO)  –  the data is shifted serially “IN” and “OUT” of the register, one bit at a time in either a left or right direction under clock control.
- Parallel-in to Serial-out (PISO)  –  the parallel data is loaded into the register simultaneously and is shifted out of the register serially one bit at a time under clock control.
- Parallel-in to Parallel-out (PIPO)  –  the parallel data is loaded simultaneously into the register, and transferred together to their respective outputs by the same clock pulse.