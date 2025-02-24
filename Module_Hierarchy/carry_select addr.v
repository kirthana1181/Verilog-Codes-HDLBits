module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire cout0,cout;
    wire [15:0]sum0,sum1;
    add16 addr0(.a(a[31:16]),.b(b[31:16]),.sum(sum0),.cin(1'b0),.cout(cout0));
    add16 addr1(.a(a[31:16]),.b(b[31:16]),.sum(sum1),.cin(1'b1),.cout(cout0));
    add16 addr2(.a(a[15:0]),.b(b[15:0]),.sum(sum[15:0]),.cout(cout),.cin(1'b0));
    always @(cout,sum1,sum0) begin
        case(cout)
            0: sum[31:16]=sum0;
            1: sum[31:16]=sum1;
        endcase
    end
endmodule
