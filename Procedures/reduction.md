## Introduction to Reduction Operators

Unary operators that have only one operand. Create a circuit that will compute a parity bit for a 8-bit byte (which will add a 9th bit to the byte). 

```verilog
module top_module (
    input [7:0] in,
    output parity); 
    
    assign parity = ^ in[7:0];

endmodule
```
## Gates100

Build a combinational circuit with 100 inputs, in[99:0].

There are 3 outputs:

out_and: output of a 100-input AND gate.
out_or: output of a 100-input OR gate.
out_xor: output of a 100-input XOR gate.

```verilog
module top_module( 
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor 
);
    assign out_and = & in;
    assign out_or = | in;
    assign out_xor = ^ in;

endmodule
```
