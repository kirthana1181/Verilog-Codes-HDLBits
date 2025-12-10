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

# 7. 
