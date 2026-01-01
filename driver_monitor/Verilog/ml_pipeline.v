module ml_pipeline(
    input wire clk,rst,
    input wire signed [7:0] accel, jerk, steer,
    input wire [7:0] brake,
    input wire signed [7:0] w0,w1,w2,w3,
    output reg[7:0] score
);

reg signed [15:0] m0,m1,m2,m3;
reg signed [17:0]sum;

always @(posedge clk or negedge rst) begin
    if (rst == 1'b0) begin
        m0 <= 16'd0;
        m1 <= 16'd0;
        m2 <= 16'd0;
        m3 <= 16'd0;
        score <= 8'd0;
        sum <= 18'd0;
    end
    else begin
        m0 <= w0*accel;
        m1 <= w1*jerk;
        m2 <= w2*steer;
        m3 <= w3*brake;
        sum <= m0+m1+m2+m3;
        if (sum < 0) begin
            score <= 8'd0;
        end
        else if (sum>255) begin
            score <= 8'hff;
        end
        else begin
            score <= sum[7:0];
        end
    end
end
endmodule

