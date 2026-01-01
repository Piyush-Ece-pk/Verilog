module config_reg(
    input wire clk,rst,
    input wire cfg_we,
    input wire [3:0] cfg_addr,
    input wire [15:0] wght_data,
    output reg signed [7:0] w0,w1,w2,w3,
    output reg [7:0] warn_th,
    output reg [7:0] emer_th 
);

always @(posedge clk or negedge rst) begin
if (rst == 1'b0)  begin
    w0 <= 8'd2;
    w1 <= 8'd3;
    w2 <= 8'd1;
    w3 <= 8'd4;
    emer_th <= 8'd180;
    warn_th <= 8'd100;
end
else if (cfg_we) begin
    case (cfg_addr)
        4'h0 : w0 <= wght_data[7:0];
        4'h1 : w1 <= wght_data[7:0];
        4'h2 : w2 <= wght_data[7:0];
        4'h3 : w3 <= wght_data[7:0];
        4'h4 : warn_th <= wght_data[7:0];
        4'h5 : emer_th <= wght_data[7:0];
    endcase 
end
end
endmodule