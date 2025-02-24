module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire con0;
    wire[31:0]b1;
    add16 addr0 (.a(a[15:0]),.b(b1[15:0]),.sum(sum[15:0]),.cout(con0),.cin(sub));
    add16 addr1 (.a(a[31:16]),.b(b1[31:16]),.sum(sum[31:16]),.cin(con0));
    always @(b,sub) begin
        case(sub)
            0: b1 = b;
            1: b1 = ~{b};
        endcase
    end
endmodule
