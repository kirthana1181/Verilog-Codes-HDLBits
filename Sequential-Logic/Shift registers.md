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
                    q <= q>>1;
                else
                    q <= q;
        end
    end

endmodule
```

# 2. rotate100

```verilog
module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else if (ena) begin
            case(ena)
                2'b01: q <= {q[0],q[99:1]};
                2'b10: q <= {q[98:0],q[99]};
                default: q <= q;
            endcase
        end
        else
            q <= q;
    end
endmodule
```  

# 3. Left/Right shift by 1 or 8

```verilog
module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else if (ena) begin 
            case(amount) 
                2'b00: q <= {q[63],q[62:1]<<1};  //left
                2'b01: q <= {q[63],q[62:1]<<8};//left8
                2'b10: q <= {q[63],q[62:0]>>1};	 //right
                2'b11: q <= {q[63],q[62:0]>>8};//right8
            endcase
        end
        else
            q <= q;
    end
    
endmodule

```
