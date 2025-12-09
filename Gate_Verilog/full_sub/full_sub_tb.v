`timescale 1ns/1ps

module full_sub_tb;
    reg a,b,bin;
    wire bo,diff ;

full_sub uut (
    .a(a),
    .b(b),
    .bin(bin),
    .diff(diff),
    .bo(bo)
    );


initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0,full_sub_tb);

    a=1'b0; b=1'b0; bin=1'b0; #10;
    a=1'b0; b=1'b0; bin=1'b1; #10;
    a=1'b0; b=1'b1; bin=1'b0; #10;
    a=1'b0; b=1'b1; bin=1'b1; #10;
    a=1'b1; b=1'b0; bin=1'b0; #10;
    a=1'b1; b=1'b0; bin=1'b1; #10;
    a=1'b1; b=1'b1; bin=1'b0; #10;
    a=1'b1; b=1'b1; bin=1'b1; #10;
    $finish;
end;    

endmodule 


