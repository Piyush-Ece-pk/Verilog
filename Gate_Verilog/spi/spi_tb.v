module spi_tb();

reg clk, rst, start, miso;
reg [7:0] data_in;

wire mosi, sck;
wire ss, done;
wire [7:0] data_out;

spi uut(
    .clk(clk),
    .rst(rst),
    .start(start),
    .miso(miso),
    .data_in(data_in),
    .mosi(mosi),
    .sck(sck),
    .ss(ss),
    .done(done),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,spi_tb);
    rst = 0;
    start = 0;
    data_in = 8'b10101111;
    miso = 0;

    #20 rst = 1;
    #20 start = 1;
    #10 start = 0;

    wait (ss == 0);

    #10 miso = 1;
    #40 miso = 0;
    #40 miso = 1;
    #40 miso = 0;
    #40 miso = 1;
    #40 miso = 0;
    #40 miso = 1;
    #40 miso = 0;

    wait(done);
    #20;
    $finish;
end

endmodule
