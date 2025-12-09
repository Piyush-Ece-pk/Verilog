module uart_rx(clk,rst,rx,data_out,rx_done,parity_err);
input wire clk,rst;
input wire rx;
output reg parity_err;
output reg rx_done;
output reg[7:0] data_out;

parameter clk_freq = 1000000;
parameter baudrate = 9600;
localparam bits_per_clk = clk_freq/baudrate;
localparam mid_sample = bits_per_clk/2;
localparam 
idle = 3'd0,
start = 3'd1,
data_bit = 3'd2,
parity_bit = 3'd3,
stop1 = 3'd4,
stop2 = 3'd5,
done = 3'd6;

reg [7:0] data;
reg parity;
reg [7:0] clk_count;
reg [3:0] bit_index;
reg [2:0] state;

always @(posedge clk or negedge rst) 
begin   
    if (rst == 1'b0) begin
        clk_count <= 8'b0;
        bit_index <= 4'd0;
        state <= idle;
        rx_done <= 1'b0;
        data <= 8'b0;
        parity_err <= 1'b0;
    end
    else begin
        case (state)
            idle : begin    
                rx_done <= 1'b0;
                data_out <= 8'b0;
                if (rx == 1'b0) begin   
                    clk_count <= 8'b0;
                    bit_index <= 4'b0;
                    state <= start;
                end
            end
            start : begin
                clk_count <= clk_count+1;
                if (clk_count == mid_sample) begin
                    if (rx == 1'b0) begin
                        clk_count <= 8'b0;
                        bit_index <= 4'd0;
                        state <= data_bit;
                    end
                    else begin
                        state <= idle;
                    end
                end
            end
            data_bit : begin
                clk_count <= clk_count+1;
                if (clk_count == mid_sample) begin
                    data[bit_index] <= rx;
                end
                if  (clk_count == bits_per_clk-1) begin
                    clk_count <= 8'b0;
                    if (bit_index == 4'd7) begin
                        state <= parity_bit;
                    end
                    else begin
                        bit_index <= bit_index+1;
                    end
                end
            end
            parity_bit : begin
                clk_count <= clk_count+1;
                if (clk_count==mid_sample) begin
                    parity <= rx;
                end
                if (clk_count == bits_per_clk-1) begin
                    clk_count <= 8'b0;
                    state <= stop1;
                    end
            end
            stop1 : begin
                clk_count <= clk_count+1;
                if (clk_count == mid_sample && rx!=1) begin
                    state <= idle;
                end
                if (clk_count == bits_per_clk-1) begin
                    clk_count <= 8'b0;
                    state <= stop2;
                end
            end
            stop2 : begin
                clk_count <= clk_count+1;
                if (clk_count == mid_sample && rx!=1) begin
                    state <= idle;
                end
                if (clk_count == bits_per_clk-1) begin
                    clk_count <= 8'b0;
                    state <= done;
                end
            end
            done : begin
                data_out <= data;
                parity_err <= (parity != ^data);
                rx_done <= 1'b1;
                state <= idle;
            end
        endcase
    end
end
endmodule








