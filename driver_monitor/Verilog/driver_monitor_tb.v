module driver_monitor_tb;
    reg clk;
    reg rst;
    wire [1:0] irq;
    reg irq_ack;
    reg [1:0] irq_mask;
    reg cfg_we;
    reg [3:0] cfg_addr;
    reg [15:0] wght_data;
    reg signed [7:0] accel,steer;
    reg [7:0] brake;
    integer fd;
    integer r;
    integer fa,fs,fb;

driver_monitor_top top_uut(
    .clk(clk),
    .rst(rst),
    .irq(irq),
    .irq_ack(irq_ack),
    .irq_mask(irq_mask),
    .cfg_addr(cfg_addr),
    .cfg_we(cfg_we),
    .wght_data(wght_data),
    .accel(accel),
    .steer(steer),
    .brake(brake)
);


initial begin
    clk <= 1'b0;
    forever #5
    clk <= ~clk;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,driver_monitor_tb);
    rst <= 1'b0;
    cfg_we <= 1'b0;
    irq_mask <= 2'b00;
    irq_ack <= 1'b0; 
    #20;
    rst <= 1'b1;
    write_config(4'h0, 16'd2);
    write_config(4'h1, 16'd3);
    write_config(4'h2, 16'd1);
    write_config(4'h3, 16'd4);
    write_config(4'h4, 16'd100);
    write_config(4'h5, 16'd180);
    #500;
    irq_ack <= 1'b1;
    #10;
    irq_ack <= 1'b0;
    $display("test ends successfully");
    $finish;
end

task write_config(input [3:0] a, input [15:0] d);
begin
    @(posedge clk)
    cfg_we <= 1'b1;
    cfg_addr <= a;
    wght_data <= d;
    @(posedge clk) ;
    cfg_we <= 1'b0;
end
endtask

always @(posedge clk) begin
    if (irq == 2'b01) begin
        $display("warning interrupt at %t",$time);
    end
    else if (irq == 2'b10) begin
        $display("emergency interrupt at %t",$time);
    end
    else if (irq == 2'b01 && irq_mask[1]== 0) begin
        $display("error: warning asserted when emergengy should be here");
    end
end

initial begin 
    fd = $fopen("sensor_stream.txt","r");
    if (fd == 0) begin
        $display("error: sensor stram file not found");
        $finish;
    end
end

always @(posedge clk) begin
    if (!$feof(fd)) begin
        r = $fscanf(fd, "%d,%d,%d\n",fa,fs,fb);
        if (r ==3 ) begin
            accel <= fa[7:0];
            steer <= fs[7:0];
            brake <= fb[7:0];
        end
    end
end
endmodule
