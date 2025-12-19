module i2c_tb();
wire sda;
wire scl;
reg clk,rst;
pullup(sda);
pullup(scl);

initial begin
    clk= 1'b0;
    forever #5
    clk <= ~clk;
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
    $dumpfile("dump.vcd");
    $dumpvars(0,i2c_tb);
    rst = 1'b0;
    start = 1'b0;
    sim_clk_str =1'b0;
    addr7 = 8'h42;
    reg_addr = 8'h02;
    data_in = 8'h5a;
    do_read = 1'b0;
    #200;
    rst = 1'b1;
    #200;
    
    $display("TEST1: Write 0x%02x to reg 0x%02x", data_in, reg_addr);
    start = 1;
    rw = 0;
    do_read = 0;
    #10 start = 0;
    wait (done);
    #200;
    $display("DONE write: ack_err=%b arb_lost=%b", ack_err, arb_lost);

    $display("TEST2: Read from reg 0x%02x", reg_addr);
    start = 1;
    rw = 1;
    do_read = 1;
    #10 start = 0;
    wait (done);
    #100;
    $display("Read data = 0x%02x ack_err=%b", read_data, ack_err);

    $display("TEST3: Clock stretching simulated");
    sim_clk_str = 1;
    data_in = 8'hCC;
    reg_addr = 8'h03;
    start= 1;
    rw = 0;
    do_read = 0;
    #10 start = 0;
    wait (done);
    sim_clk_str = 0;
    #100;
    $display("After stretch write ack_err=%b", ack_err);

    #500;
    $finish;
end
endmodule
