## Computer and digital systems (class)

This project was developed under Computer Systems class at Warsaw University of Technology. Its a project of a simple ALU working in Two's compliment binary code. It can perform several operations on input vectors which are easily modified in terms of size. The documentation is written in polish only, as it was required for the class, yet still its computer-related class, so like half of it is in english anyway...

Enjoy checking it out!

## Operations

Here's a concise description of the operations performed by the Arithmetic Logic Unit (ALU) in SystemVerilog:


- A - 2*B
- A < B
- (A+B)[B] = 0
- U2(A) => ZM(A)

## Ports

- i_op: n-bite input deciding of code operatio
- i_arg_A: m-bit input for argument A
- i_arg_B: m-bit input for argument B
- i_clk: Clock input
- i_reset: Synchronous reset input triggered by a low state
- o_result: Synchronous output of the system
- o_status: Synchronous output indicating the status associated with the operation's result

## Status operation bits:
- ERROR bit: Indicates when the operation result is determined incorrectly.
- EVEN_1 bit: Indicates when the number of ones in the result is even.
- ONES bit: Indicates when all bits in the result are set to 1.
- OVERFLOW bit: Indicates an overflow condition occurred.

## File Structure

- ArithmeticLogicUnit
	- module
		- alu.sv
		- alu_complied
	- tests
		- testbench.sv
		- test_compiled
	- synthesis
		- alu_synthesis.sv
	- signals_output
		- signals.vcd
- Documentation
	- documentation.pdf
