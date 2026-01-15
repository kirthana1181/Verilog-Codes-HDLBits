# 1. 4-bit shift regsiter

```verilog
module top_module(
    input clk,
    input areset,  // async active-high reset to zero
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
    
    //reg [3:0] a;
    always @(posedge clk or posedge areset) begin
        if (areset)
            q = 0;
        else begin
            if (load)
                q <= data;
            else
                if (ena == 1'b1)
                    q = q>>1;
                else
                    q = q;
        end
    end

endmodule
```

# 2. rotate100

```verilog

```  
