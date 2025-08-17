module alu_adder (
    input [3:0] a,b,
    input cin,
    output [3:0] sum,
    output cout
);
    assign {cout, sum} = a + b + cin;
endmodule

module alu_sub(
    input [3:0] a,b,
    input cin,
    output [3:0] diff,
    output cout
);
    assign {cout, diff} = a - b - cin;
endmodule

module alu_nand(
    input [3:0] a,b,
    output [3:0] y
);
    assign y = ~(a&b);
endmodule

module alu_nor(
    input [3:0] a,b,
    output [3:0] y
);
    assign y = ~(a|b);
endmodule

module alu_struct(
    input  [3:0] p,q,
    input cin,
    output [3:0] yadd,ysub,ynand,ynor,
    output cout_add, cout_sub
);

    alu_adder   a1 (p,q,cin,yadd,cout_add);
    alu_sub     a2 (p,q,cin,ysub,cout_sub);
    alu_nand    a3 (p,q,ynand);
    alu_nor     a4 (p,q,ynor);

endmodule

module alu_struct_tb;
    reg [3:0] p,q;
    reg cin;
    wire [3:0] yadd,ysub,ynand,ynor;
    wire cout_add, cout_sub;

    alu_struct uut (p, q, cin, yadd, ysub, ynand, ynor, cout_add, cout_sub);

    initial begin
        $monitor($time, " p=%b q=%b cin=%b | ADD=%b cout_add=%b | SUB=%b cout_sub=%b | NAND=%b NOR=%b",
                          p, q, cin, yadd, cout_add, ysub, cout_sub, ynand, ynor);

        cin=0; p=4'b0011; q=4'b0101; #10;
        cin=0; p=4'b1001; q=4'b0011; #10;
        cin=1; p=4'b1111; q=4'b0001; #10;
        cin=0; p=4'b1100; q=4'b1010; #10;

        $stop;
    end
endmodule
