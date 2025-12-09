module spi(
    input wire clk,
    input wire rst,
    input wire miso,
    input wire start,
    input wire [7:0] data_in,
    output reg mosi,
    output reg sck,
    output reg ss,
    output reg done,
    output reg [7:0] data_out
);

parameter clk_div = 4;

reg [1:0] state;
reg [2:0] bit_count;
reg [7:0] shift_reg;
reg [clk_div-1:0] clk_div_count;

localparam
    idle      = 2'd0,
    load      = 2'd1,
    transfer  = 2'd2,
    done_bit  = 2'd3;

always @(posedge clk or negedge rst)
begin
    if (!rst) begin
        state <= idle;
        sck <= 0;
        ss <= 1;
        done <= 0;
        clk_div_count <= 0;
        bit_count <= 0;
        shift_reg <= 0;
        data_out <= 0;
        mosi <= 0;
    end
    else begin
        case (state)

        idle: begin
            sck <= 0;
            done <= 0;
            ss <= 1;
            if (start)
                state <= load;
        end

        load: begin
            ss <= 0;
            shift_reg <= data_in;
            bit_count <= 3'b111;
            clk_div_count <= 0;
            state <= transfer;
        end

        transfer: begin
            clk_div_count <= clk_div_count + 1;

            if (clk_div_count == (clk_div/2)-1) begin
                sck <= 1;
                mosi <= shift_reg[bit_count];
            end

            if (clk_div_count == clk_div-1) begin
                sck <= 0;
                clk_div_count <= 0;
                data_out[bit_count] <= miso;

                if (bit_count == 0)
                    state <= done_bit;
                else
                    bit_count <= bit_count - 1;
            end
        end

        done_bit: begin
            ss <= 1;
            done <= 1;
            sck <= 0;
            state <= idle;
        end

        endcase
    end
end

endmodule
