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
    output reg signed [63:0] q); 
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else if (ena) begin 
            case(amount) 
                2'b00: q <= q <<< 1;//left  --0 {q[63],q[62:0]<<1};
                2'b01: q <= q <<< 8;//left8 --1 {q[63],q[62:0]<<8};
                2'b10: q <= $signed(q[63:0]) >>> 1; //right --2
                2'b11: q <= $signed(q[63:0]) >>> 8; //right8--3
                default: q <= q;
            endcase
        end
        else
            q <= q;
    end
    
endmodule
```
# 4. 5 bit LFSR

```verilog
module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 5'h1
    output [4:0] q
); 
    //wire a,b;
    //assign a = 0 ^ q[0];
    //assign b = q[3] ^ q[0];
    always @(posedge clk) begin
        //q[4] = 1'h0 ^ q[0];	//a
        if (reset)
            q <= 5'h1;
        else begin
            q[0] <= q[1];
            q[1] <= q[2];
            q[2] <= q[3] ^ q[0]; //b
            q[3] <= q[4];
            q[4] <= 1'h0 ^ q[0];
        end
    end

endmodule
```
# 4. 3 bit LFSR

```verilog
module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q

    always @(posedge KEY[0]) begin
        case(KEY[1])
            1'b0 : begin
                LEDR[2] <= LEDR[2] ^ LEDR[1];
                LEDR[1] <= LEDR[0];
                LEDR[0] <= LEDR[2];
            end
            1'b1: begin
                LEDR[2] <= SW[2];
                LEDR[1] <= SW[1];
                LEDR[0] <= SW[0];
            end
        endcase
    end

endmodule
```

# 5. 32 bit LFSR

```verilog
module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    always @(posedge clk) begin
        if(reset)
            q <= 32'h1;
        else begin
            q[0]  <= q[1] ^ q[0]; //pos1
            q[1]  <= q[2] ^ q[0]; //pos2
            q[19:2] <= q[20:3]; 
            q[21] <= q[22] ^ q[0];//pos22
            q[29:22] <= q[30:23];
            q[31] <= 1'h0 ^ q[0]; //pos32  
        end
    end

endmodule
```
