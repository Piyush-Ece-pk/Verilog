module i2c_slave #(
    parameter slave_addr = 7'h42
)(
    input wire clk,rst,
    inout wire sda,
    inout wire scl,
    input wire sim_clk_str
);

reg sda_oe;
reg scl_oe;

assign sda = sda_oe ? 1'b0 : 1'bz ;
assign scl = scl_oe ? 1'b0 : 1'bz ;

wire sda_in = sda;
wire scl_in = scl;

localparam
    idle = 4'd0,
    addr= 4'd1,
    ack_addr = 4'd2,
    reg_bit = 4'd3,
    ack_reg = 4'd4,
    data = 4'd5,
    ack_data = 4'd6,
    read_byte = 4'd7,
    ack_read = 4'd8;

reg [3:0] state;
reg [7:0] shift;
reg [2:0] bit_cnt;
reg rw_flag;
reg [7:0] reg_file [0:15];
reg [3:0] reg_ptr;
reg expecting_reg;

reg sda_prev,scl_prev;

wire start_det = (sda_in == 1'b1 && sda_in == 1'b0 && scl_in == 1'b1);
wire stop_det = (sda_in == 1'b0 && sda_in == 1'b1 && scl_in == 1'b1);

integer i;

initial begin
    for (i= 0 ; i < 16 ; i=i+1 )
        reg_file[i]=i;
    state = idle;
    sda_oe = 1'b0;
    scl_oe = 1'b0;
    sda_prev = 1'b1;
    scl_prev = 1'b1;
    bit_cnt = 3'd7;
    shift = 8'b0;
    reg_ptr = 4'b0;
    //expecting_ack = 1'b0;
end

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        state = idle;
        sda_oe = 1'b0;
        scl_oe = 1'b0;
        sda_prev = 1'b1;
        scl_prev = 1'b1;
        bit_cnt = 3'd7;
        shift = 8'b0;
        reg_ptr = 4'b0;
        //expecting_ack = 1'b0;
    end
    else begin
        sda_prev <= sda_in;
        scl_prev <= scl_in;
    end

    if (start_det) begin
        state <= addr;
        bit_cnt <= 3'd7;
        shift <= 8'b0;
        scl_oe <= 1'b0;
    end
    else if (stop_det) begin
        state <= idle;
        sda_oe <= 1'b0;
        scl_oe <= 1'b0;
    end
    else begin
        if (scl_prev == 1'b0 && scl_in == 1'b1) begin
            case(state) 
                addr: begin
                    shift[bit_cnt] <= sda_in;
                    if (bit_cnt == 1'b0) begin
                        if (shift[7:1] == slave_addr) begin
                            state <= ack_addr;
                            rw_flag <= shift[0];
                        end
                        else begin  
                            state <= idle;
                        end
                        bit_cnt <= 3'd7;
                    end
                    else begin
                        bit_cnt <= bit_cnt - 1;
                    end
                end

                ack_addr : begin
                    sda_oe <= 1'b1;
                    state <= reg_bit;
                end

                reg_bit : begin
                    sda_oe <= 1'b0;
                    bit_cnt <= 3'd7;
                    if (bit_cnt == 1'b0) begin
                        reg_ptr <= shift[7:0];
                        bit_cnt <= 3'd7;
                        if (rw_flag == 1'b0) begin
                            state <= ack_reg;
                            expecting_reg <= 1'b1;
                        end
                        else begin
                            state <= ack_reg;
                        end
                    end
                    else begin
                        bit_cnt <= bit_cnt-1;
                    end
                end
                ack_reg : begin
                    sda_oe <= 1'b1;
                    if (rw_flag) begin
                        sda_oe <= 1'b0;
                        state <= read_byte;
                        bit_cnt <= 3'd7;
                        shift <= reg_file[reg_ptr];
                    end
                    else begin
                        sda_oe <= 1'b0;
                        state <= data;
                        bit_cnt <= 3'd7;
                        shift <= 8'h00;
                    end
                end
                data : begin
                    if (bit_cnt == 1'b0) begin
                        reg_file[reg_ptr] <= shift;
                        state <= ack_data;
                        bit_cnt <= 3'd7;
                    end
                    else begin
                        bit_cnt <= bit_cnt-1;
                    end
                end

                ack_data : begin
                    sda_oe <= 1'b1;
                    sda_oe <= 1'b0;
                    state <= idle;
                end

                read_byte : begin
                    sda_oe <= ~shift[bit_cnt];
                    if (bit_cnt == 1'b0) begin
                        bit_cnt <= 3'd7;
                        sda_oe <= 1'b0;
                        state <= idle;
                    end
                    else begin
                        bit_cnt <= bit_cnt-1;
                    end
                end

                default : begin
                    state <= idle;
                end
            endcase 
        end
    end
end
endmodule

        
            
                


                
                



