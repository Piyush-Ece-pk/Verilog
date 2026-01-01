module emergency(
    input wire [7:0] score,
    output reg warning,
    output reg emergent
);

always @(*) begin
    warning <= 1'b0;
    emergent <= 1'b0;

    if (score > 8'd180) begin
        emergent <= 1'b1;
    end
    else if (score <= 8'd100) begin
        warning <= 1'b1;
    end
    else begin
        warning <= 1'b0;
        emergent <= 1'b0;
    end
end
endmodule