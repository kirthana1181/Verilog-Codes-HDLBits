# 1. Count15

```verilog
module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
    
    always @(posedge clk) begin
        if(reset)
            q <= 0;
        else
            q <= q+1;
    end

endmodule
```

# 2. count10

```verilog
module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
    
    always @(posedge clk) begin
        if(q == 9)
            q = ~(q[3] & q[1]);
        else
            q = q;
        if(reset)
            q <= 0;
        else
            q <= q+1;
    end

endmodule
```
# 3. count1to10

```verilog
module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
    
    always @(posedge clk) begin
        if(q == 10)
            q = q[0] & q[1] & ~q[2] & q[3];
        else
            q = q;
        if(reset)
            q <= 1;
        else
            q <= q+1;
    end

endmodule
```

# 4. countslow

```verilog
module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    always @(posedge clk) begin
        q = (q == 9)? ((slowena == 1'b1)? ~(q[3] & q[1]) : 4'd9) : q;
        if(reset)
            q <= 0;
        else begin
            if(slowena)
                q <= q + 1;
            else
                q <= q;
        end
    end

endmodule
```
# 5. Counter1-12

```verilog
module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
    wire [3:0]w1,w2,w3;
    assign w1 = (reset == 1) ? 4'd1 : Q; 
    assign w2 = (Q == 12)? Q[3] & Q[2] : Q;
    always @(*) begin
        c_enable <= enable;
        case({reset,(Q == 12)})
            2'b00: w3 = Q;
            2'b01: w3 = w2;
            2'b10: w3 = w1;
            2'b11: w3 = w1;
        endcase
    end
    count4 the_counter0 (clk, c_enable, c_load, c_d, w1);

endmodule

```
