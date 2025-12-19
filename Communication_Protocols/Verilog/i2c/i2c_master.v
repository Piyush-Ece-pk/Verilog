module i2c_master #(
    parameter clk_freq = 50000000,
    parameter i2c_freq = 100000
)
(
    input wire clk,
    input wire rst,
    input wire start,
    input wire rw,
    input wire [6:0] addr7,
    input wire [7:0] reg_addr,
    input wire [7:0] data_in,
    input wire do_read,
    output reg busy,
    output reg ack_err,
    output reg arb_lost,
    output reg[7:0] read_data,
    output reg done,
    inout wire sda,
    inout wire scl
);

localparam integer clk_per_half_scl = clk_freq/(i2c_freq*2);
localparam integer cntr_w = $clog2(clk_per_half_scl+1);

reg sda_oe;
reg scl_oe;

assign sda = sda_oe ? 1'b0 : 1'bz;
assign scl = scl_oe ? 1'b0 : 1'bz;

wire sda_in = sda;
wire scl_in = scl;

localparam
    idle= 4'd0,
    start_bit = 4'd1,
    send_addr = 4'd2,
    wait_ack1 = 4'd3,
    send_reg = 4'd4,
    wait_ack2 = 4'd5,
    write_data = 4'd6,
    wait_ack3 = 4'd7,
    rep_start = 4'd8,
    send_addr_rd = 4'd9,
    wait_ack4 = 4'd10,
    read_data_bit = 4'd11,
    send_nack = 4'd12,
    stop = 4'd13,
    done_bit = 4'd14;

reg [3:0] state,next_state;

reg [cntr_w-1:0] half_scl_cnt;
reg scl_edge;
reg phase;

reg [7:0] tx_shift;
reg [2:0] bit_index;
reg expecting_ack;

always @(posedge clk or negedge rst) begin
    if (!rst) 
        arb_lost <= 1'b0;
    else if (sda_oe && sda_in)
        arb_lost <= 1'b1;
    else
        arb_lost <= arb_lost;
end

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        half_scl_cnt <= 1'b0;
        scl_edge <= 1'b0;
        phase <= 1'b0;
    end
    else begin
        if (half_scl_cnt == (clk_per_half_scl-1)) begin
            half_scl_cnt <= 1'b0;
            scl_edge <= 1'b1;
            phase <= ~phase;
        end
        else begin
            half_scl_cnt <= half_scl_cnt+1;
            scl_edge <= 1'b0;
        end
    end
end

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        state <= idle;
        busy <= 1'b0;
        ack_err <= 1'b0;
        done <= 1'b0;
        read_data <= 8'h00;
        sda_oe <= 1'b0;
        scl_oe <= 1'b0;
        bit_index <= 3'd7;
        tx_shift <= 8'h00;
        expecting_ack <= 1'b0;
    end 
    else begin
        done <= 1'b0;
        case (state) 
            idle : begin 
                ack_err <= 1'b0;
                arb_lost <= 1'b0;
                if (start) begin
                    busy <= 1'b1;
                    state <= start_bit;
                end
            end
            start_bit : begin
                scl_oe <= 1'b0;
                if (scl_in && phase == 1'b0) begin
                    sda_oe <= 1'b1;
                end
                if (scl_edge && phase == 1'b1) begin
                    state <= send_addr;
                    tx_shift <= {addr7,rw};
                    bit_index <= 3'd7;
                    expecting_ack <= 1'b0;
                    scl_oe <= 1'b1;
                    half_scl_cnt <= 1'b0;
                    phase <= 1'b0;
                end
            end
            send_addr : begin
                if (scl_edge && phase == 1'b0) begin
                    sda_oe <= ~tx_shift[bit_index];
                    scl_oe <= 1'b0;
                end
                if (scl_edge && phase == 1'b1) begin
                    scl_oe <= 1'b1;
                    if (bit_index == 1'b0) begin
                        state <= wait_ack1 ;
                        sda_oe <= 1'b0;
                        expecting_ack <= 1'b1;
                    end
                    else begin
                        bit_index <= bit_index-1;
                    end
                end
            end
            wait_ack1 : begin
                if (scl_edge && phase == 1'b0) begin
                    scl_oe <= 1'b0;
                end
                if (scl_edge && phase == 1'b1) begin
                    if (sda_in == 1'b1) begin   
                        ack_err <= 1'b1;
                        scl_oe <= 1'b1;
                        
                        bit_index <= 3'd7;
                        tx_shift <= reg_addr;
                        expecting_ack <= 1'b0;
                    end
                state <= send_reg;
                end
            end
            send_reg : begin
                if (scl_edge && phase == 1'b0) begin
                    scl_oe <= 1'b0;
                    sda_oe <= ~tx_shift[bit_index];
                end
                if (scl_edge && phase == 1'b1) begin
                    scl_oe <= 1'b1;
                    if (bit_index == 1'b0) begin
                        state <= wait_ack2;
                        sda_oe <= 1'b0;
                        expecting_ack <= 1'b1;
                    end
                    else begin
                        bit_index <= bit_index-1;
                    end
                end
            end
            wait_ack2 : begin
                if (scl_edge && phase == 1'b0) begin
                    scl_oe <= 1'b0;
                end
                if (scl_edge && phase == 1'b1) begin
                    if (sda_in == 1'b1) begin
                        ack_err <= 1'b1;
                    end
                    scl_oe <= 1'b1;
                    if (do_read) begin
                        state <= rep_start;
                    end
                    else begin
                        state <= write_data;
                        tx_shift <= data_in;
                        bit_index <= 3'd7;
                    end
                end
            end
            write_data : begin
                if (scl_edge && phase == 1'b0) begin
                    sda_oe <= ~tx_shift[bit_index];
                    scl_oe <= 1'b0;
                end
                if (scl_edge && phase == 1'b1) begin
                    scl_oe <= 1'b1;
                    if (bit_index == 1'b0) begin
                        state <= wait_ack3;
                        sda_oe <= 1'b0;
                    end
                    else begin
                        bit_index <= bit_index-1;
                    end
                end
            end
            wait_ack3 : begin
                if (scl_edge && phase == 1'b0) begin
                    scl_oe <= 1'b0;
                end
                if (scl_edge && phase == 1'b1) begin
                    if (sda_in == 1'b1) begin
                        ack_err <= 1'b1;
                        scl_oe <= 1'b1;
                        state <= stop;
                    end
                end
            end
            rep_start : begin
                scl_oe <= 1'b0;
                sda_oe <= 1'b0;
                if (scl_in) begin
                    sda_oe <= 1'b1;
                    tx_shift <= {addr7,1'b1};
                    bit_index <= 3'd7;
                    sda_oe <= 1'b1;
                    scl_oe <= 1'b1;
                    state <= send_addr_rd;
                end
            end
            send_addr_rd : begin
                if (scl_edge && phase == 1'b0) begin
                    scl_oe <= 1'b0;
                    sda_oe <= ~tx_shift[bit_index];
                end
                if (scl_edge && phase == 1'b1) begin    
                    scl_oe <= 1'b1;
                    if (bit_index == 1'b0) begin
                        state <= wait_ack4;
                        sda_oe <= 1'b0;
                    end
                    else begin
                        bit_index <= bit_index-1;
                    end
                end
            end
            wait_ack4 : begin
                if (scl_edge && phase == 1'b0) begin
                    scl_oe <= 1'b0;
                end
                if (scl_edge && phase == 1'b1) begin
                    if (sda_in == 1'b1) begin
                        ack_err <= 1'b1;
                        scl_oe <= 1'b1;
                        bit_index <= 3'd7;
                        sda_oe <= 1'b0;
                        
                    end
                    state <= read_data_bit;
                end
            end
            read_data_bit : begin
                if (scl_edge && phase == 1'b0) begin
                    scl_oe <= 1'b0;
                end;
                if (scl_edge && phase == 1'b1) begin
                    read_data[bit_index] <= sda_in;
                    scl_oe <= 1'b1;
                    if (bit_index == 1'b0) begin
                        state <= send_nack;
                    end
                    else begin  
                        bit_index <= bit_index-1;
                    end
                end
            end
            send_nack : begin
                if (scl_edge && phase == 1'b0) begin    
                    scl_oe <= 1'b0;
                    sda_oe <= 1'b0;
                end
                if (scl_edge && phase == 1'b1) begin
                    scl_oe <= 1'b1;
                    state <= stop;
                end
            end
            stop : begin
                scl_oe <= 1'b0;
                if (scl_in) begin
                    sda_oe <= 1'b0;
                    state <= done_bit;
                end
                else if (phase ==1'b0)
                    sda_oe <=1'b1;
            end
            done_bit : begin
                busy <= 1'b0;
                done <= 1'b1;
                read_data <= data_in;
                state <= idle;
            end
            default : begin
                state <= idle;
            end
        endcase
    end
end
endmodule

















