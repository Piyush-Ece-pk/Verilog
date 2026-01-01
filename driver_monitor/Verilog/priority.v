module priority(
    input wire clk,rst,
    input wire emergency,
    input wire warn,
    input wire irq_ack,
    input wire [1:0] irq_mask,
    output reg [1:0] irq
);
reg emer_det;
always @(posedge clk or negedge rst) begin
    if (rst == 1'b0) begin
        emer_det <= 1'b0;
    end
    else begin
        emer_det <= emergency;
    end
end

always @(posedge clk or negedge rst) begin
    if (rst == 1'b0) begin
        irq <= 2'b00;
    end
    else if (irq_ack) begin
        irq <= 2'b00;
    end
    else begin
        if (emergency && !emer_det && !irq_mask[1]) begin    
            irq <= 2'b10;
        end
        else if (warn && !irq_mask[0]) begin
            irq <= 2'b01;
        end
    end
end
endmodule
