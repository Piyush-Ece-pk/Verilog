`timescale 1ns/1ps
module full_adder_tb;
    reg a,b,cin;
    wire sum, cout;

full_adder uut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0,full_adder_tb);

    a=1'b0; b=1'b0; cin=1'b0; #10;
    a=1'b0; b=1'b0; cin=1'b1; #10;
    a=1'b0; b=1'b1; cin=1'b0; #10;
    a=1'b0; b=1'b1; cin=1'b1; #10;
    a=1'b1; b=1'b0; cin=1'b0; #10;
    a=1'b1; b=1'b0; cin=1'b1; #10;
    a=1'b1; b=1'b1; cin=1'b0; #10;
    a=1'b1; b=1'b1; cin=1'b1; #10;
    $finish;
end;    
endmodule
