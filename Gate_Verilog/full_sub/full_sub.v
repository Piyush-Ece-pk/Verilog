module full_sub(a,b,bin,diff,bo);
    input wire a,b,bin;
    output wire bo,diff;

assign diff = a^b^bin;
assign bo = ((~a)&b)|(((~a)|b)&bin);
endmodule