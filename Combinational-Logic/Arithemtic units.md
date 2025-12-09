# 1. Half adder

```verilog
module top_module( 
    input a, b,
    output cout, sum );
    
    assign cout = a & b ;
    assign sum = a ^ b;

endmodule

```

# 2. full adder

```verilog
module top_module( 
    input a, b, cin,
    output cout, sum );
    
    assign  cout = (a & b) | ((a ^ b) & cin);
    assign sum = a ^ b ^ cin;

endmodule
```

# 3. 3-bit binary adder (Adder3)

```verilog
module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    fa inst1(a[0],b[0],cin,cout[0],sum[0]);
    fa inst2(a[1],b[1],cout[0],cout[1],sum[1]);
    fa inst3(a[2],b[2],cout[1],cout[2],sum[2]);
    
endmodule

module fa( 
    input a, b, cin,
    output cout, sum );
    
    assign  cout = (a & b) | ((a ^ b) & cin);
    assign sum = a ^ b ^ cin;

endmodule
```


# 4. 4-bit ripple carry adder

```verilog
module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    genvar i;
    wire [3:0]w1;
    
    fa inst0(x[0],y[0],0,w1[0],sum[0]);
    
    generate
        for(i = 1; i < 4; i= i +1) begin: adder
            fa inst(x[i],y[i],w1[i-1],w1[i],sum[i]);
        end
    endgenerate
    
    assign sum[4] = w1[3];
endmodule


module fa( 
    input a, b, cin,
    output cout, sum );
    
    assign  cout = (a & b) | ((a ^ b) & cin);
    assign sum = a ^ b ^ cin;

endmodule
```
# 5. Signed addition overflow

```verilog
module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
    assign s = a + b;
    assign overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]) ;

endmodule
```

# 6. 100-bit binary adder

```verilog
module top_module (
	input [99:0] a,
	input [99:0] b,
	input cin,
	output cout,
	output [99:0] sum
);

	// The concatenation {cout, sum} is a 101-bit vector.
	assign {cout, sum} = a+b+cin;

endmodule
```

or

```verilog
module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
    
    genvar i;
    wire [99:0] w1;
    fa inst0 (a[0],b[0],cin,w1[0],sum[0]);
    generate 
        for(i = 1 ; i < 100 ; i = i + 1) begin: adder
            fa inst (a[i],b[i],w1[i-1],w1[i],sum[i]);
        end
    endgenerate
    
    assign cout = w1[99];

endmodule


module fa( 
    input a, b, cin,
    output cout, sum );
    
    assign  cout = (a & b) | ((a ^ b) & cin);
    assign sum = a ^ b ^ cin;

endmodule
```

# 8. 4-bit BCD Adder

```verilog
module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    
    genvar i;
    wire [3:0]w1;
    bcd_fadd inst0 ( .a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(w1[0]), .sum(sum[3:0]));
    
    generate 
        for( i = 1; i < 4; i = i + 1) begin: bcd_add
            bcd_fadd inst ( .a(a[3+4*i:4*i]), .b(b[3+4*i:4*i]), .cin(w1[i-1]), .cout(w1[i]), .sum(sum[3+4*i:4*i]));
        end
    endgenerate
    assign cout = w1[3];

endmodule
```


