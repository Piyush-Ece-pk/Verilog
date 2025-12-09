module full_adder(a,b,cin,sum,cout);
    input wire a,b,cin;
    output wire sum,cout;

assign cout = (a&b)|(cin&(a^b)) ;
assign sum = a^b^cin;
endmodule