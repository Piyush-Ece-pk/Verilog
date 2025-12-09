module uart_tx(clk,rst,tx,tx_done,data_in,tx_start);
output reg tx;
output reg tx_done;
input wire clk,rst;
input wire [7:0] data_in;
input wire tx_start;

parameter clk_freq = 1000000;
parameter baudrate = 9600;
localparam bits_per_clk = (clk_freq/baudrate);
localparam
idle = 3'd0,
start = 3'd1,
data_bit = 3'd2,
parity_bit = 3'd3,
stop1 = 3'd4,
stop2 = 3'd5,
done = 3'd6;
reg [2:0] state;
reg [7:0] clk_count;
reg [3:0] bit_index;
reg parity;
reg [7:0] data;

always @(posedge clk or negedge rst) 
begin
    if (rst == 1'b0) begin
        tx <= 1'b1;
        clk_count <= 8'b0;
        state <= idle;
        tx_done <= 1'b0;
        bit_index <= 4'b0;
        parity <= 1'b0;
        data <= 8'b0;
    end
    else begin
        case (state)
            idle : begin    
                tx <= 1'b1;
                clk_count <= 8'b0;
                tx_done <= 1'b0;
                if (tx_start) begin
                    data <= data_in;
                    parity <= ^data_in;
                    clk_count <= 8'b0;
                    bit_index <= 4'b0;
                    state <= start;
                end
            end
            start : begin
                tx <= 1'b0;
                clk_count <= clk_count+1;
                if (clk_count == bits_per_clk-1) begin
                    clk_count <= 8'b0;
                    state <= data_bit;
                end
            end
            data_bit : begin
                tx <= data[bit_index];
                clk_count <= clk_count+1;
                if (clk_count == bits_per_clk-1) begin
                    clk_count <= 8'b0;
                    if (bit_index == 4'd7) begin
                        state <= parity;
                    end
                    else begin
                        bit_index <= bit_index+1;
                    end
                end
            end
            parity_bit : begin
                tx <= parity;
                clk_count <= clk_count+1;
                if (clk_count== bits_per_clk-1) begin
                    clk_count <= 8'b0;
                    state <= stop1;
                end
            end
            stop1 : begin
                tx <= 1'b1;
                clk_count <= clk_count+1;
                if (clk_count==bits_per_clk-1) begin
                    clk_count <= 8'b0;
                    state <= stop2;
                end
            end
            stop2 : begin
                tx <= 1'b1;
                clk_count <= clk_count+1;
                if (clk_count==bits_per_clk-1) begin
                    clk_count <= 8'b0;
                    state <= done;
                end
            end
            done : begin
                tx_done <= 1'b1;
                state <= idle;
            end
        endcase
    end
end
endmodule



                

        





