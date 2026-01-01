module safety_fsm(
    input wire clk,rst,
    input wire [7:0] avg_sc,
    input wire [7:0] warn_th,
    input wire [7:0] emer_th,
    output reg warning,
    output reg emergency
);

localparam safe = 2'b00;
localparam emer = 2'b01;
localparam latch = 2'b10;
localparam warn = 2'b11;

reg [1:0] state,next_state;

always @(posedge clk or negedge rst) 
begin
    if (rst == 1'b0) begin  
        state <= safe;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    warning <= 1'b0;
    emergency <= 1'b0;
    next_state <= state;

    case(state) 
        safe : begin
            if (avg_sc > warn_th) begin
                next_state <= warn;
            end
        end
        warn : begin
            warning <= 1'b1;
            if (avg_sc > emer_th) begin
                next_state <=emer;
            end
            else if (avg_sc <= warn_th) begin
                next_state <= safe;
            end
        end
        emer : begin
            emergency <= 1'b1;
            next_state <= latch;
        end
        latch : begin
            emergency <= 1'b1;
        end
    endcase
end
endmodule
        