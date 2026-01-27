module axi_ram_top #(
    parameter axi_addr_width =32,
    parameter axi_data_width = 32,
    parameter ram_addr_width =19
)(
    input wire clk,rst,
    input wire [axi_addr_width-1:0] axi_awaddr,
    input wire axi_awvalid,
    output wire axi_awready,

    input wire [axi_data_width-1:0] axi_wdata,
    input wire [3:0] axi_wstrb,
    input wire axi_wvalid,
    output wire axi_wready,

    output wire [1:0] axi_bresp,
    output wire axi_bvalid,
    input wire axi_bready,

    input wire [axi_addr_width-1:0] axi_araddr,
    input wire axi_arvalid,
    output wire axi_arready,

    output wire [axi_data_width-1:0] axi_rdata,
    output wire [1:0] axi_rresp,
    output wire axi_rvalid,
    input wire axi_rready,

    input wire ram_b_en,
    input wire ram_b_we,
    input wire [ram_addr_width-1:0] ram_b_addr,
    input wire [7:0] ram_b_wdata,
    output wire [7:0] ram_b_rdata     
);

wire  ram_a_en;
wire ram_a_we;
wire [ram_addr_width-1:0] ram_a_addr;
wire [7:0] ram_a_wdata;
wire [7:0] ram_a_rdata;

axi_lite #(
    .axi_addr_width(axi_addr_width),
    .axi_data_width(axi_data_width),
    .ram_addr_width(ram_addr_width)
) axi_lite_u (
    .clk(clk),
    .rst(rst),
    .axi_awaddr(axi_awaddr),
    .axi_awvalid(axi_awvalid),
    .axi_awready(axi_awready),
    .axi_wdata(axi_wdata),
    .axi_wstrb(axi_wstrb),
    .axi_wvalid(axi_wvalid),
    .axi_wready(axi_wready),
    .axi_bresp(axi_bresp),
    .axi_bvalid(axi_bvalid),
    .axi_bready(axi_bready),
    .axi_araddr(axi_araddr),
    .axi_arvalid(axi_arvalid),
    .axi_arready(axi_arready),
    .axi_rdata(axi_rdata),
    .axi_rresp(axi_rresp),
    .axi_rvalid(axi_rvalid),
    .axi_rready(axi_rready),
    .ram_a_en(ram_a_en),
    .ram_a_we(ram_a_we),
    .ram_a_addr(ram_a_addr),
    .ram_a_wdata(ram_a_wdata),
    .ram_a_rdata(ram_a_rdata)
);

dp_ram #(
    .data_width(8),
    .addr_width(ram_addr_width)
) dpram_u (
    .clk(clk),
    .rst(rst),
    .a_en(ram_a_en),
    .a_we(ram_a_we),
    .a_addr(ram_a_addr),
    .a_wdata(ram_a_wdata),
    .a_rdata(ram_a_rdata),
    .b_en(ram_b_en),
    .b_we(ram_b_we),
    .b_addr(ram_b_addr),
    .b_wdata(ram_b_wdata),
    .b_rdata(ram_b_rdata)
);
endmodule
