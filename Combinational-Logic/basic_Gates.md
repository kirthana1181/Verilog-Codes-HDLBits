# 1. Implement the following circuit:

<img width="239" height="42" alt="image" src="https://github.com/user-attachments/assets/1e2f9031-d768-46b2-a789-68bffe170483" />

```verilog
module top_module (
    input in,
    output out);

      assign out = in;

endmodule

```

# 2. Implement the circuit:

<img width="195" height="110" alt="image" src="https://github.com/user-attachments/assets/58737d25-f007-46d7-a97a-65e5ed82808d" />

```verilog
module top_module (
    input in,
    output out);

      assign out = 1'b0;

endmodule

```
# 3. NOR Gate

<img width="292" height="116" alt="image" src="https://github.com/user-attachments/assets/f84cc525-f27f-4cc4-b613-293435e76880" />

```verilog
module top_module (
    input in1,
    input in2
    output out);

      assign out = ~(in1 | in2);

endmodule

```

# 4. 1NOT-1AND Gate

<img width="292" height="116" alt="image" src="https://github.com/user-attachments/assets/a4dbf7a9-d944-4f5d-a41f-b496355de2b9" />

```verilog
module top_module (
    input in1,
    input in2,
    output out);

    assign out = (~in2) & in1;

endmodule

```

# 5. 1XNOR-1XOR Gate

<img width="502" height="160" alt="image" src="https://github.com/user-attachments/assets/a0810954-77e6-44a8-87af-73193a5ccc72" />

```verilog
module top_module (
    input in1,
    input in2,
    input in3,
    output out);

    assign out = in3 ^ ~(in1 ^ in2);

endmodule
```

# 6. Several Logic gates

There are 7 outputs, each with a logic gate driving it:

out_and: a and b
out_or: a or b
out_xor: a xor b
out_nand: a nand b
out_nor: a nor b
out_xnor: a xnor b
out_anotb: a and-not b

```verilog
module top_module( 
    input a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);

    assign out_and = a & b;
    assign out_or = a | b;
    assign out_xor = a ^ b;
    assign out_nand = ~(a & b);
    assign out_nor = ~(a | b);
    assign out_xnor = ~(a ^ b);
    assign out_anotb = a & ~b;
endmodule
```

# 7. 7420 ic

<img width="784" height="428" alt="image" src="https://github.com/user-attachments/assets/92675022-34a1-4747-a185-d86a785e5dc7" />

```verilog
module top_module ( 
    input p1a, p1b, p1c, p1d,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    
    assign p1y = ~(p1a & p1b & p1c & p1d);
    assign p2y = ~(p2a & p2b & p2c & p2d);
    
endmodule
```

# 8. Truthtable 1

For a boolean function of N inputs, there are 2\^N possible input combinations. Each row of the truth table lists one input combination, so there are always 2\^N rows. The output column shows what the output should be for each input value.

<img width="143" height="196" alt="image" src="https://github.com/user-attachments/assets/92069db9-8248-4627-8bff-f22f7355a116" />

```verilog
module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
    assign f = (~x3 & x2) | (x3 & x1);

endmodule
```

# 9. Create a circuit that has two 2-bit inputs A[1:0] and B[1:0], and produces an output z. The value of z should be 1 if A = B, otherwise z should be 0.

```verilog
module top_module ( input [1:0] A, input [1:0] B, output z ); 
    
    assign z = (A[1:0] == B[1:0])? 1'b1 : 1'b0;

endmodule

```

# 10. Implement the function z = (x^y) & x. in this module.

```verilog
module top_module (input x, input y, output z);
    
    assign z = x & ~y;

endmodule
```

# 11. Circuit B is described using waveform
<img width="1200" height="247" alt="image" src="https://github.com/user-attachments/assets/77fe75ec-d8cc-44b0-8101-f317d0c43007" />

```verilog
module top_module ( input x, input y, output z );
    
    assign z = ~(x ^ y);

endmodule
```

# 12. See [mt2015_q4a](https://github.com/kirthana1181/Verilog-Codes-HDLBits/new/master#10-implement-the-function-z--xy--x-in-this-module) and [mt2015_q4b](https://github.com/kirthana1181/Verilog-Codes-HDLBits/new/master#11-circuit-b-is-described-using-waveform) for the submodules used here. The top-level design consists of two instantiations each of subcircuits A and B, as shown below.

<img width="471" height="368" alt="image" src="https://github.com/user-attachments/assets/a66e9f1c-9dbb-47a6-a557-584d5b4e8193" />

```verilog
module top_module (input x, input y, output z);
    
    wire w1, w2, w3, w4;
    Aia ia1(x,y,w1);
    Bib ib1(x,y,w2);
    Aia ia2(x,y,w3);
    Bib ib2(x,y,w4);
    
    assign z = (w1 | w2) ^ (w3 & w4);

endmodule

module Aia (input x, input y, output z);
    assign z = x & ~y;
endmodule

module Bib (input x, input y, output z);
    assign z = ~(x ^ y);
endmodule
```

# 13. Ringer

```verilog
module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
    assign motor = (vibrate_mode == 1'b1) & (ring == 1'b1);
    assign ringer = (vibrate_mode == 1'b0) & (motor != 1'b1) & (ring == 1'b1);
    
endmodule

```
