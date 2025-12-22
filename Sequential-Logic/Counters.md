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

# 6. Count1-12

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
    wire [3:0]w1;
    
    assign c_enable = (enable == 1) ? 1 : ((reset == 1) | (Q == 4'd12) ? 4'd0 : enable);
    assign c_load = (reset == 1) | (Q == 4'd12) & (enable == 1) ? 1 : 0 ;
    assign c_d = (reset == 1) | (Q == 4'd12) & (enable == 1) ? 1 : 1'd0;
    count4 the_counter (clk, c_enable, c_load, 1, Q);

endmodule
```

# 7.Counter 1000

```verilog
module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    wire [3:0]w1,w2,w3;
    assign OneHertz = (w1 == 9) & (w2 == 9) & (w3 == 9);
    always @(*) begin
        case({(w2 == 4'd9),(w1 == 4'd9),1'b1})
            3'b001: c_enable = 1;
            3'b011: c_enable = 3;
            3'b111: c_enable = 7;
            default: c_enable = 1;
        endcase
    end
    bcdcount counter0 (clk, reset, c_enable[0],w1);
    bcdcount counter1 (clk, reset, c_enable[1],w2);
    bcdcount counter2 (clk, reset, c_enable[2],w3);

endmodule

```
# 8. 4-digit decimal counter

```verilog
module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    assign q = 0;
    wire [3:0] w1,w2,w3,w4;
    always @(posedge clk) begin
        if (reset)
            q <= 0;
        else begin
            /*w1 <= w1 + 1;
            ena[1] <= (w1 == 4'd9) ? 1 : 0 ; 
            w2 <= ena[1] ? w2 + 1 : w2;
            ena[2] <= (w2 == 4'd9) ? 1 : 0;
            w3 <= ena[2] ? w3 + 1 : 3;
            ena[3] <= (w3 == 4'd9) ? 1 : 0;
            w4 <= ena[3] ? w4 + 1 : w4;*/
            case({(w3 == 4'd9),(w2 == 4'd9),(w1 == 4'd9)})
                3'b000: ena <= 3'b000;
                3'b001: ena <= 3'b001;
                3'b011: ena <= 3'b011;
                3'b111: ena <= 3'b111;
                default: ena <= 0;
            endcase
            case(ena)
                3'b000: q = {q[15:12],q[11:8],q[7:4],q[3:0]+1};
                3'b001: q = {q[15:12],q[11:8],q[7:4]+1,q[3:0]+1};
                3'b011: q = {q[15:12],q[11:8]+1,q[7:4]+1,q[3:0]+1};
                3'b111: q = {q[15:12]+1,q[11:8]+1,q[7:4]+1,q[3:0]+1};
                default: q = 0;
            endcase
    	end
    end

endmodule
```
