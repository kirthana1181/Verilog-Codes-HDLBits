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

# 4. 
