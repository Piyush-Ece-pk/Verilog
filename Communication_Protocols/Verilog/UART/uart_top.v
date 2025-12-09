module uart_top(clk,rst,tx,tx_done,data_in,tx_start,data_out,rx_done,parity_err);
input wire clk,rst;
input wire tx_start;
input wire[7:0] data_in;
output wire tx;
output wire tx_done;
output wire[7:0] data_out;
output wire rx_done;
output wire parity_err;

wire uart_int;

uart_tx tx_inst(
    .clk(clk),
    .rst(rst),
    .tx(uart_int),
    .tx_done(tx_done),
    .data_in(data_in),
    .tx_start(tx_start)
);

uart_rx rx_inst(
    .clk(clk),
    .rst(rst),
    .rx(uart_int),
    .data_out(data_out),
    .rx_done(rx_done),
    .parity_err(parity_err)
);
assign tx = uart_int;

endmodule


