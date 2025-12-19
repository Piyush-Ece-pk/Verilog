module i2c_top();
    wire sda;
    wire scl;

    pullup pu_sda(sda);
    pullup pu_scl(scl);

    reg clk,rst;

initial begin 
    clk = 1'b0;
    forever #5
    clk = ~clk;
end


reg start;
reg rw;
reg [6:0] addr7;
reg [7:0] reg_addr;
reg [7:0] data_in;
reg do_read;
wire busy;
wire ack_err;
wire arb_lost;
wire[7:0] read_data;
wire done;


i2c_master #(.clk_freq(100000000),.i2c_freq(100000)) master_inst(
    .clk(clk),
    .rst(rst),
    .start(start),
    .rw(rw),
    .addr7(addr7),
    .reg_addr(reg_addr),
    .data_in(data_in),
    .do_read(do_read),
    .busy(busy),
    .ack_err(ack_err),
    .arb_lost(arb_lost),
    .read_data(read_data),
    .done(done),
    .sda(sda),
    .scl(scl)
);

reg sim_clk_str;
i2c_slave #(.slave_addr(7'h42)) slave_inst(
    .clk(clk),
    .rst(rst),
    .scl(scl),
    .sda(sda),
    .sim_clk_str(sim_clk_str)
);

initial begin
    rst = 0;
    start = 0;
    rw = 0;
    addr7 = 7'h42;
    reg_addr = 8'h01;
    data_in = 8'hA5;
    do_read = 0;
    sim_clk_str= 0;
    #100;
    rst= 1;
end
endmodule

