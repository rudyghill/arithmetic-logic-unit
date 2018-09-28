- [Introduction](#org2b34c1c)
- [Results](#orgbeb6499)
- [Demo](#orgae745dd)
- [Conclusion](#org71ed088)



<a id="org2b34c1c"></a>

# Introduction

The purpose of this project was to design and implement an ALU, or arithmetic logic unit, using the Verilog Hardware Description Language and the Terasic DE10 Lite Board. The group consisted of Eric Dahl and Rudy HIll. Our given specifications were to create an ALU with four distinct modes: Arithmetic, Logic, Comparison, and Magic. Arithmetic mode would be able add, subtract, multiply by 2, and divide by two. Logic mode would be able perform logical operation such as AND, OR, EXOR, and NOT. Comparison mode would be able to compare two numbers, and and print out the equality, majority, minority, and the maximum value. Finally, Magic mode would be able to emulate the “sliding” lighting pattern as shown on the personified car in the television series “Night Rider”.


<a id="orgbeb6499"></a>

# Results

An overview of the project is given above in a graphical layout. The inputs are the two buttons KEY[1:0] . 10 switches SW[9:0], and the internal clock `ADC_CLK_10`. `Project1_top` outputs to three eight segment displays and 10 LEDS. The inputs are aggregated into MODE[1:0] and KEY[1:0], OP as SW[9:8], IN [7:0] as SW[7:0], CLOCK as `ADC_CLK_10`. The outputs are 10 leds LEDR[9:0] as LED[9:0], and 3 eight segment displays HEX0[7:0], HEX1[7:0], and HEX5[1:0] as themselves.

Behaviourally, the two buttons will change the mode of the ALU, and the first two switches(8&9) will change the operation within each mode. The rest of the switches are reserved as input values, 4 bit or 8 bit depending on the operation. The current mode is depicted on the far left eight segment display, HEX5. Output values are displayed on the two rightmost eight segment displays as hexadecimal value(0-F) as well as bits on the 10 LED's. All representation have the most significant value on the left and least significant on right as is the norm.

The four modes available are ARITHMETIC, LOGIC, COMPARISON, and MAGIC. ARITHMETIC, LOGIC, and COMPARISON take OP[1:0] and IN[7:0] also known as the 10 input switches SW[9:0]. MAGIC takes in only CLOCK as an input. All modes have a 10 bit output though only ARITHMETIC takes advantage of the first two values. I should mention here that first refers to the most significant values (leftmost or greatest in index) and last refers to the least significant(rightmost or least in index). ARITHMETIC is evaluated onto wires W[39:30], LOGIC is evaluated onto wires W[29:20], COMPARISON is evaluated onto wires W[19:10], and MAGIC is evaluated onto wires W[9:0].

As mentioned before the two buttons control the mode. The four 10-bit wires holding the outputs of the four modes are multiplexed through a 40 to 10 module called `MULTIPLEXER_2`. The way `MULTIPLEXER_2` works is that it declares a 2-bit register named k. `MULTIPLEXER_2` uses two always @ blocks to invert the bits of k when the bit’s corresponding button is pressed. These always @ blocks have a sensitivity list that is only activated on the positive edge of the button. In this fashion, k[0] is inverted when KEY[0] is pressed, and k[1] is inverted when KEY[1] is pressed. Register k is then used as the switch in a 4-1 multiplexer. When k = 2’b00, the output of the multiplexer is ARITHMETIC, 2’b01 means the output is LOGIC, 2’b10 means the output is COMPARISON, and 2’b11 means the output is MAGIC.

Similar to `MULTIPLEXER_2` is the module MULTIPLEXER. However, MULTIPLEXER does not need to use a register because its inputs, switches 9 and 8, are static. They either stay on or off so their state can be directly used as the switch of the multiplexer. MULTIPLEXER is instantiated within the ARITHMETIC, LOGIC, and COMPARISON modules because within each one of these modules, there are 4 submodes from which to choose. For instance, within ARITHMETIC, when SW[9:8] is 2’b00 the submode is add, 2’b01 is subtract, 2’b10 is multiply, and 2’b11 is divide. Before I can explain further, I must explain the operations within each mode in order to make sense. I’ll start with ARITHMETIC.

ARITHMETIC contains four operations, ADD, SUB, MULT, and DIV for addition, subtraction, multiplication by 2, and division by two. Each operation takes in 8-bit inputs as switches SW[7:0] and produces a 10-bit output. ADD and SUB aggregate the first four bits as a 4-bit X and the last four bits as 4-bit Y, while MULT and DIV aggregate the full 8-bits as an 8-bit number Z. ADD takes two 4-bit values as inputs and produces a 4-bit sum to the last 4-bits using the ripple carry adder implementation. Any carries are outputted to 5th bit; the rest are zeros. SUB, uses a Full Subtraction implementation to subtract X from Y. Using 2’s complement one can output a positive four bits to the last four bits if the output is negative. The 10th bit is 1 if the result is negative and 0 otherwise; all other bits are 0. MULT takes Z and multiplies by 2 (same as shifting a binary number to the left) and produces another 8-bit number to the last 8 bits. If the number is too large the 10th bit is 1; the 9th bit is always zero. DIV works similarly, it divides an 8-bit number by two (same as shifting it to the right) and produces another 8-bit value onto the last bits. If there is remainder the 10th output bit is 1. The 9th led is always zero.

LOGIC contains four operations just as ARITHMETIC. `MY_AND`, `MY_OR`, and `MY_EXOR` take in two 4-bit inputs X and Y, and `MY_NOT` takes in an 8-bit value Z. Our team had to use the `MY_` prefix because Verilog already define AND, OR, and NOT. `MY_AND` performs bitwise operations of the logical “and” on X and Y. `MY_OR` performs bitwise operations of the logical “or” on X and Y. `MY_EXOR` performs bitwise operations of the logical “exclusive or” on X and Y. Finally, `MY_NOT` performs bitwise operations of the logical “not” on Z only. All unused output bits are zero.

COMPARISON uses 1 and 0 to indicate truth and falsity respectively. It has EQUAL, GREATER, LESSER, and MAX as operations. All operations take in two 4-bit inputs X and Y. If X is equal to Y, EQUAL produces a 1 at the end, otherwise a zero. If X is greater than Y, GREATER produces a 1 at the end, otherwise a zero. If X is less than Y, LESSER produces a 1 at the end, otherwise a 0. Finally, MAX outputs the greatest of X and Y i.e if X is greater than Y, then X is outputted. Again, all unused bits are zero.

Magic has a unique implementation compare to its other modes. It take only the internal clock as an inputs. Each phase of KITT’s lights can represented by a string of bits. The internal clock is too fast for the human eye, so each phase changes only when the clock goes through 650,000 cycles. Each phase change also has direction to it. We represented this directionality as a variable. The output is this string of 10 bits that changes every 650,00 clock cycles.

So now it becomes appropriate to explain what is done to multiplexed outputs of each of the modes and operations. The 10 bits are directly applied to the LED’s and thus can themselves represent binary numbers. In addition, The last 4-bits are decoded through `eight_segment` which output to HEX0 and the previous 4-bits are also decoded through `eight_segment` which output to HEX1. As mentioned before HEX5 outputs values for each mode.


<a id="orgae745dd"></a>

# Demo

[ALU on DE10 Lite Board](https://www.youtube.com/watch?v=SJFbykHwdng)


<a id="org71ed088"></a>

# Conclusion

Overall, I can say that I learned a lot from this project. Most obviously I learned introductory Verilog and synthesis of Verilog on an FPGA, but most importantly I learned to work better in a team, be more patient and troubleshoot better. The most difficult part by far was designing and implementing Magic Mode. There were so many ways to implement the module, but we ended up doing it simply and manually assigning each phase to a preset array of bits. With the experience I have now and with more time, I would have created the module in a more automatic way, meaning I would have had a process that changed the pattern automatically with arithmetic, rather than manually creating the patterns. I am very proud of my work.