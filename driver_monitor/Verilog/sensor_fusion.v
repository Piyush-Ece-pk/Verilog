module sensor_fusion(
    input wire clk,rst,
    input wire signed [7:0] accel,
    input wire signed [7:0] steer,
    input wire [7:0] brake,
    output reg signed [7:0] jerk,
    output reg signed [7:0] steer_rate,
    output reg signed [15:0] fused_mag
);

reg signed [7:0] accel_prev;
reg signed [7:0] steer_prev;

always @(posedge clk)
begin
if (rst == 1'b0)  begin
    accel_prev <= 1'b0;
    steer_prev <= 1'b0;
    jerk <= 1'b0;
    steer_rate <= 1'b0;
    fused_mag <= 1'b0;
end 
else begin
    jerk <= accel-accel_prev;
    steer_rate <= steer-steer_prev;
    fused_mag <= (accel + steer + brake) >> 2;
    accel_prev <= accel;
    steer_prev <= steer;
end
end
endmodule
 