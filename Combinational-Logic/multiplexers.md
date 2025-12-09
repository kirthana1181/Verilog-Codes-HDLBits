# 1. 2-to-1 MUX

```verilog
module top_module( 
    input a, b, sel,
    output out );
    
    assign out = sel ? b : a;

endmodule

```

# 2. Mux2to1v

```verilog
module top_module( 
    input [99:0] a, b,
    input sel,
    output [99:0] out );
    
    assign out = sel ? b : a;

endmodule
```

# 3. Mux9to1v

```verilog
module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );
    
    always @(*) begin
        case(sel)
            4'd0: out = a;
            4'd1: out = b;
            4'd2: out = c;
            4'd3: out = d;
            4'd4: out = e;
            4'd5: out = f;
            4'd6: out = g;
            4'd7: out = h;
            4'd8: out = i;
            default : out[15:0] = 16'b1111111111111111;
        endcase
    end
endmodule
```

# 4. mux256to1

```verilog
module top_module( 
    input [255:0] in,
    input [7:0] sel,
    output out );
    
    always @(*) begin
        for(integer i= 0; i < 256; i = i + 1) begin
            if(sel == i)
                out = in[i];
        end
    end

endmodule
```

# 5. Mux256to1v

```verilog
module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    
    assign out = {in[4*sel+3],in[4*sel+2],in[4*sel+1],in[4*sel+0]};

endmodule
```
