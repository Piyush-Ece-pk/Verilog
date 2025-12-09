`timescale 1ns/1ps
module all_gates_tb;
    reg a,b;
    wire o_and,o_or,o_exnor,o_exor,o_nand,o_nor,o_not;

    all_gates uut (
        .a(a),
        .b(b),
        .o_and(o_and),
        .o_or(o_or),
        .o_exnor(o_exnor),
        .o_exor(o_exor),
        .o_nand(o_nand),
        .o_nor(o_nor),
        .o_not(o_not)
        );
initial begin 
    $dumpfile("wave.vcd");
    $dumpvars(0,all_gates_tb);

    a=0; b=0; #10;
    a=0; b=1; #10;
    a=1; b=0; #10;
    a=1; b=1; #10;

    $finish;
end
endmodule

    