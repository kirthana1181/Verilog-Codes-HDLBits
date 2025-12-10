# 1. K-Map1 : 3var

<img width="191" height="251" alt="image" src="https://github.com/user-attachments/assets/18fcc81b-34f8-43e6-a206-8c6faf142fc1" />

out = a + b + c

```verilog
module top_module(
    input a,
    input b,
    input c,
    output out  ); 
    
    assign out = a | b | c;

endmodule
```

# 2. K-Map2 : 4 var

<img width="223" height="219" alt="image" src="https://github.com/user-attachments/assets/932ad469-0c9a-4e84-bbdf-b0a33399ce16" />

out = a'.(b.c+d') + c'.b' + a.c.d

```verilog
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  );
    
    assign out = (~a & ((b & c) | ~d)) | (~c & ~b) | (a & c & d);

endmodule
```

# 3. K-Map3: 4 var

<img width="215" height="209" alt="image" src="https://github.com/user-attachments/assets/4c4b36ec-ed2b-4c86-a967-d2f5940b4a7a" />

out = a + b'.c

```verilog
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    
    assign out = a | (~b)&c;

endmodule
```
# 4. K-Map4: 4 var

<img width="208" height="211" alt="image" src="https://github.com/user-attachments/assets/20fee474-7032-4ff8-8088-2ad7fade2da8" />

out = c'.d'.(a ⊕ b) + c'.d.(a ⊙ b) + c.d.(a ⊕ b) + c.d'.(a ⊙ b)

=> out = (a ⊕ b).(c ⊙ d) + (a ⊙ b).(c ⊕ d)

```verilog
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    
    assign out = ((a ^ b) & ~(c ^ d)) | (~(a ^ b) & (c ^ d));

endmodule
```

# 5. Minimum sop and pos for a given function

out_pos = c.(d + (a + b)')

out_sop = c.(a'+ b').d

```verilog
module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
    assign out_sop = c & (d | ~(a | b));
    assign out_pos = c & (~a | d) & (~b | d);

endmodule
```

# 6. Exams/m2014 q3

<img width="182" height="163" alt="image" src="https://github.com/user-attachments/assets/850dcec5-e971-4226-a9d0-7eca17bc5a97" />

```verilog
module top_module (
    input [4:1] x, 
    output f );
    
    assign f = (x[3] & ~x[1]) | (x[2] & x[4]);

endmodule
```
# 7. Exams/2012 q1g 

<img width="146" height="133" alt="image" src="https://github.com/user-attachments/assets/a312c172-25c0-4cb4-a90d-526e79a00528" />

```verilog
module top_module (
    input [4:1] x,
    output f
); 
    assign f = (x[3] & ~x[1]) | (x[4] & x[3] & x[2]) | (~x[2] & ~x[4]);

endmodule

```

# 8. Exams/ece241 2014 q3

<img width="561" height="302" alt="image" src="https://github.com/user-attachments/assets/7395bcdf-df25-4557-a803-cf72530c38cb" />

```verilog
module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
    assign mux_in[0] = c | d;
    assign mux_in[1] = 0;
    assign mux_in[2] = ~d;
    assign mux_in[3] = c & d;

endmodule
```
