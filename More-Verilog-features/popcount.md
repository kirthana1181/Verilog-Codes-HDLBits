A "population count" circuit counts the number of '1's in an input vector. Build a population count circuit for a 255-bit input vector.

```verilog
module top_module( 
    input [254:0] in,
    output [7:0] out );
    
    wire [7:0]temp;
    always @(*) begin
        out = 0;
        for(integer i = 0 ; i < 255 ; i = i + 1) begin
            if (in[i] == 1'b1)
                out = out + 1;
            else
                out = out;
        end
    end
endmodule

```
