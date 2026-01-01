module driver_monitor_top(
    input wire clk,rst,
    input wire cfg_we,
    input wire [3:0] cfg_addr,
    input wire [15:0] wght_data,
    input wire irq_ack,
    input wire [1:0] irq_mask,
    input  wire signed [7:0] accel,
    input  wire signed [7:0] steer,
    input  wire [7:0] brake,
    output wire [1:0] irq
);


wire signed [7:0] steer_rate,jerk;
wire signed [15:0] fused_mag;
wire [7:0] ml_score;
wire [7:0] avg_sc;
wire warning,emergency;
wire signed [7:0] w0,w1,w2,w3;
wire [7:0] warn_th,emer_th;


sensor_fusion fusion_uut (
    .clk(clk),
    .rst(rst),
    .accel(accel),
    .steer(steer),
    .brake(brake),
    .fused_mag(fused_mag),
    .jerk(jerk),
    .steer_rate(steer_rate)
);

config_reg cgf_uut (
    .clk(clk),
    .rst(rst),
    .cfg_we(cfg_we),
    .cfg_addr(cfg_addr),
    .wght_data(wght_data),
    .w0(w0),
    .w1(w1),
    .w2(w2),
    .w3(w3),
    .warn_th(warn_th),
    .emer_th(emer_th)
);

ml_pipeline ml_uut (
    .clk(clk),
    .rst(rst),
    .accel(accel),
    .jerk(jerk),
    .steer(steer),
    .brake(brake),
    .w0(w0),
    .w1(w1),
    .w2(w2),
    .w3(w3),
    .score(ml_score)
);

window_mean mean_uut(
    .clk(clk),
    .rst(rst),
    .score(ml_score),
    .avg(avg_sc)
);

safety_fsm safety_uut(
    .clk(clk),
    .rst(rst),
    .avg_sc(avg_sc),
    .warn_th(warn_th),
    .emer_th(emer_th),
    .warning(warning),
    .emergency(emergency)
);


emergency emer_uut (
    .score(ml_score),
    .emergent(emergent),
    .warning(warning)
);


priority prior_uut(
    .clk(clk),
    .rst(rst),
    .emergency(emergency),
    .warn(warning),
    .irq(irq),
    .irq_ack(irq_ack),
    .irq_mask(irq_mask)
);

endmodule
