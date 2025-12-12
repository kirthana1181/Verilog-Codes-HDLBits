# 1. DFF

D flip-flops are created by the logic synthesizer when a clocked always block is used. A D flip-flop is the simplest form of "blob of combinational logic followed by a flip-flop" where the combinational logic portion is just a wire.

Create a single D flip-flop.

```verilog
module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q );//

    // Use a clocked always block
    //   copy d to q at every positive edge of clk
    //   Clocked always blocks should use non-blocking assignments
    always @(posedge clk) begin
        q <= d;
    end

endmodule

```

# 2. An 8-bit DFF

```verilog
module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk) begin
        q <= d;
    end

endmodule
```

# 3. 8-bit DFF with reset

```verilog
module top_module (
    input clk,
    input reset,            // Synchronous reset
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk) begin
        if(reset)
            q <= 0;
        else
            q <= d;
    end

endmodule
```

# 4. DFF8p

Create 8 D flip-flops with active high synchronous reset. The flip-flops must be reset to 0x34 rather than zero. All DFFs should be triggered by the negative edge of clk

```verilog
module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);
    always @(negedge clk) begin
        if(reset)
            q <= 8'h34;
        else
            q <= d;
    end

endmodule

```

# 5. Dff8ar

Create 8 D flip-flops with active high asynchronous reset. All DFFs should be triggered by the positive edge of clk.


```verilog
module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);
    always @(posedge clk or posedge areset) begin
        if(areset)
            q <= 0;
        else
            q <= d;
    end

endmodule
```

# 6. Dff16e

Create 16 D flip-flops. It's sometimes useful to only modify parts of a group of flip-flops. The byte-enable inputs control whether each byte of the 16 registers should be written to on that cycle. byteena[1] controls the upper byte d[15:8], while byteena[0] controls the lower byte d[7:0].

resetn is a synchronous, active-low reset.

All DFFs should be triggered by the positive edge of clk.

```verilog
module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);
    always @(posedge clk) begin
        if(resetn) begin
            case(byteena)
                2'b00: q <= q;
                2'b01: q <= {q[15:8],d[7:0]};
                2'b10: q <= {d[15:8],q[7:0]};
                2'b11: q <= d;
                default : q <= q;
            endcase
        end
        else
            q <= 0;
    end

endmodule
```

# 7. d-latch


<img width="263" height="226" alt="image" src="https://github.com/user-attachments/assets/27ce4657-d4b8-4283-be6e-c5557567c6ff" />


```verilog
module top_module (
    input d, 
    input ena,
    output q);
    
    always @(*) begin
        if(ena)
            q <= d;
        else
            q <= q;
    end

endmodule
```

# 9. dff-ar


<img width="191" height="148" alt="image" src="https://github.com/user-attachments/assets/06ea6288-efa0-443c-b044-71aa44e26eee" />

```verilog
module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);
    
    always @(posedge clk or posedge ar) begin
        if(ar)
            q <= 0;
        else
            q <= d;

    end

endmodule

```

# 10. Synchronous Reset

<img width="267" height="189" alt="download" src="https://github.com/user-attachments/assets/c5740cda-d731-4adf-98bd-87a391c18aff" />

```verilog

module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);
    
    always @(posedge clk) begin
        if(r)
            q <= 0;
        else
            q <= d;
    end

endmodule
```

# 11. Exams/m2014 q4d

<img width="529" height="193" alt="c59c1a1e81f0ec1e2ec10884d8dd0dc1" src="https://github.com/user-attachments/assets/e0a66258-9cd7-46a5-b226-b7d6f4a1d1fa" />


```verilog
module top_module (
    input clk,
    input in, 
    output out);
    
    always @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
```

# 12. Mt2015 muxdff

<img width="647" height="264" alt="d512aadec96141e7d4cc21e008b6acbd" src="https://github.com/user-attachments/assets/694eca92-89a6-4d12-aedf-a400060d2eca" />

```verilog
module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    
    always @(posedge clk) begin
        case(L)
            1'b0: Q <= q_in;
            1'b1: Q <= r_in;
        endcase
    end

endmodule
```

# 13. Exams/2014 q4a

![v2-32e3b953deb8f5f3fe3f029b14c2e6a5_b](https://github.com/user-attachments/assets/be97ce8f-2c2f-4745-ae0e-9f6603a9f70a)

```verilog
module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    always @(posedge clk) begin
        case({L,E})
            2'b00: Q <= Q;
            2'b01: Q <= w;
            2'b10: Q <= R;
            2'b11: Q <= R;
            default: Q <= 0;
        endcase
    end

endmodule
```

# 14. Exams/ece241 2014 q4

![download](https://github.com/user-attachments/assets/fb3bd6b9-4339-4d67-b506-03147d344e7f)

```verilog
module top_module (
    input clk,
    input x,
    output z
); 
    wire d0,d1,d2;
    reg [2:0] q = 3'd0;
    assign d0 = x ^ q[0];
    assign d1 = x & ~q[1];
    assign d2 = x | ~q[2];
    
    dff inst1 (clk, d0, q[0]);
    dff inst2 (clk, d1, q[1]);
    dff inst3 (clk, d2, q[2]);
    
    assign z = ~(q[0] | q[1] | q[2]);

endmodule

module dff(
    input clk,d,
    output reg Q
);   
    always @(posedge clk) begin
        Q <= d;
    end
    
endmodule
```
or 

```verilog
module top_module (
    input clk,
    input x,
    output z
); 
    wire d0,d1,d2;
    reg [2:0] q = 3'd0;
    assign d0 = x ^ q[0];
    assign d1 = x & ~q[1];
    assign d2 = x | ~q[2];
    
    always @(posedge clk) begin
        q[0] <= d0;
        q[1] <= d1;
        q[2] <= d2;
    end

    assign z = ~(q[0] | q[1] | q[2]);

endmodule
```

# 15. Exams/ece241 2013 q7

<img width="1489" height="283" alt="image" src="https://github.com/user-attachments/assets/b266fa48-cd62-4f82-8966-98427ba95898" />

```verilog
module top_module (
    input clk,
    input j,
    input k,
    output Q); 
    
    wire d;
    assign d = Q | (j & ~k);
    dff inst0 (clk,d,Q);
    always @(posedge clk) begin
        case({j,k})
            2'b00: Q <= Q;
            2'b01: Q <= j;
            2'b10: Q <= j;
            2'b11: Q <= ~Q;
            default : Q <= 0;
        endcase
    end

endmodule

module dff (
    input clk,
    input d,
    output q 
);
    always @(posedge clk) begin
        q <= d;
    end
    
endmodule
```

# 16. Edgedetect

To detech positive edge

<img width="943" height="260" alt="image" src="https://github.com/user-attachments/assets/0be343dd-3c39-4519-a3e3-38884a2700af" />

```verilog
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] pedge
);
    reg [7:0]temp = 0;
    always @(posedge clk) begin
        temp <= in;
        pedge <= in & ~temp; 
    end

endmodule
```

# 17. Edgedetect2

To detect both edges

<img width="944" height="237" alt="image" src="https://github.com/user-attachments/assets/d6fc58ab-8423-420b-ab7f-e673dbff06b5" />

```verilog
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    reg [7:0] temp = 0;
    always @(posedge clk) begin
        temp <= in;
        anyedge <= in ^ temp;
    end

endmodule
```
# 18. Edgecapture

<img width="520" height="193" alt="image" src="https://github.com/user-attachments/assets/1c91fdea-0f69-4587-a892-5343480a3249" />

```verilog

```

# 19. Dual-edge triggerred FF

<img width="240" height="74" alt="image" src="https://github.com/user-attachments/assets/852d3c48-0220-450e-86d3-924092a31928" />


```verilog
module top_module (
    input clk,
    input d,
    output q
);
    reg s,t;
    always @(posedge clk) begin
        s <= d;
    end
    
    always @(negedge clk) begin
        t <= d;
    end
    
    always @(*) begin
        case(clk)
            1'b0: q <= t;
            1'b1: q <= s;
        endcase
    end
    
endmodule
```
