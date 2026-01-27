module dp_ram #(
    parameter data_width = 8,
    parameter addr_width = 19
)(
    input wire clk,rst,
    input wire a_en,
    input wire a_we,
    input wire [addr_width-1:0] a_addr,
    input wire [data_width-1:0] a_wdata,
    output reg [data_width-1:0] a_rdata,

    input wire b_en,
    input wire b_we,
    input wire [addr_width-1:0] b_addr,
    input wire [data_width-1:0] b_wdata,
    output reg [data_width-1:0] b_rdata
);

reg [data_width-1:0] mem [0:(1<<addr_width)-1];

always @(posedge clk)
begin
    if (rst == 1'b0) begin
        a_rdata <= '0;
    end
    else if (a_en) begin
        if (a_we)
            mem[a_addr] <= a_wdata;
        a_rdata <= mem[a_addr];
    end
end

always @(posedge clk)
begin
    if (rst == 1'b0) begin
        b_rdata <= '0;
    end
    else if (b_en) begin
        if (b_we)
            mem[b_addr] <= b_wdata;
        b_rdata <= mem[b_addr];
    end
end
endmodule
    