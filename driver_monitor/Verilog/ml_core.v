module ml_core(
    input wire clk,rst,
    input wire signed [7:0] accel,
    input wire signed [7:0] jerk,
    input wire signed [7:0] steer,
    input wire [7:0] brake,
    output reg [7:0] score
);

localparam signed [7:0] w0 = 8'sd2;
localparam signed [7:0] w1 = 8'sd3;
localparam signed [7:0] w2 = 8'sd1;
localparam signed [7:0] w3 = 8'sd4;
localparam signed [15:0] bias = 16'sd20;

reg signed [15:0] mac;
always @(posedge clk or negedge rst)
begin
if (rst == 1'b0) begin
    mac = 16'sd0;
    score <= 8'd0;
    end
else begin
    mac = w0*accel + w1*jerk + w2* steer + w3*brake + bias;
    if (mac < 16'sd0) begin
        score <= 8'd0;
    end
    else if (mac > 255) begin
        score <= 8'hff;
    end
    else begin
        score <= mac[7:0];
    end
end
end
endmodule

