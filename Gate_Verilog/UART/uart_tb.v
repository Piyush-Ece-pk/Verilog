module uart_tb();
 reg clk,rst;
 reg tx_start;
 reg[7:0] data_in;
 wire tx;
 wire tx_done;
 wire[7:0] data_out;
 wire rx_done;
 wire parity_err;

 uart_top top_uut(
    .clk(clk),
    .rst(rst),
    .tx_start(tx_start),
    .data_in(data_in),
    .tx(tx),
    .tx_done(tx_done),
    .data_out(data_out),
    .rx_done(rx_done),
    .parity_err(parity_err)
 );

 initial begin 
 clk <= 1'b0;
 forever #5
 clk <= ~clk;
 end

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,uart_tb);
rst <= 1'b0; #10;
rst <= 1'b1; 
data_in <= 8'b10101100;
tx_start<=1'b1;
#10;
tx_start <= 1'b0;
#200000;
$finish;
end 
endmodule

