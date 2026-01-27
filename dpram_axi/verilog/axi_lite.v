module axi_lite #(
    parameter axi_addr_width = 32,
    parameter axi_data_width = 32,
    parameter ram_addr_width = 19

)(
    input  wire clk,
    input  wire rst,

    input  wire [axi_addr_width-1:0] axi_awaddr,
    input  wire axi_awvalid,
    output reg  axi_awready,

    input  wire [axi_data_width-1:0] axi_wdata,
    input  wire [3:0] axi_wstrb,
    input  wire axi_wvalid,
    output reg  axi_wready,

    output reg  [1:0] axi_bresp,
    output reg  axi_bvalid,
    input  wire axi_bready,

    input  wire [axi_addr_width-1:0] axi_araddr,
    input  wire axi_arvalid,
    output reg  axi_arready,

    output reg  [axi_data_width-1:0] axi_rdata,
    output reg  [1:0] axi_rresp,
    output reg  axi_rvalid,
    input  wire axi_rready,

    output reg  ram_a_en,
    output reg  ram_a_we,
    output reg  [ram_addr_width-1:0] ram_a_addr,
    output reg  [7:0] ram_a_wdata,
    input  wire [7:0] ram_a_rdata
);

reg [axi_addr_width-1:0] awaddr_q;
reg [axi_addr_width-1:0] araddr_q;
reg [1:0] byte_idx;
reg write_active, read_active;

wire [ram_addr_width-1:0] base_w = (awaddr_q[ram_addr_width+1:2] << 2);
wire [ram_addr_width-1:0] base_r = (araddr_q[ram_addr_width+1:2] << 2);


always @(posedge clk) begin
    if (!rst) begin
        axi_awready <= 0;
        axi_wready  <= 0;
        axi_bvalid  <= 0;
        ram_a_en    <= 0;
        ram_a_we    <= 0;
        write_active<= 0;
        byte_idx    <= 0;
    end else begin
        axi_awready <= 0;
        axi_wready  <= 0;
        ram_a_en    <= 0;
        ram_a_we    <= 0;

        if (axi_awvalid && !write_active && !axi_bvalid) begin
            axi_awready <= 1;
            awaddr_q    <= axi_awaddr;
            write_active<= 1;
            byte_idx    <= 0;
        end
        else if (write_active && axi_wvalid) begin
            axi_wready <= 1;
            ram_a_en   <= 1;
            ram_a_we   <= axi_wstrb[byte_idx];
            ram_a_addr <= base_w + byte_idx;
            ram_a_wdata<= axi_wdata[8*byte_idx +: 8];

            if (byte_idx == 3) begin
                write_active <= 0;
                axi_bvalid   <= 1;
            end else begin
                byte_idx <= byte_idx + 1;
            end
        end
        else if (axi_bvalid && axi_bready) begin
            axi_bvalid <= 0;
        end
    end
end

always @(posedge clk) begin
    if (!rst) begin
        axi_arready <= 0;
        axi_rvalid  <= 0;
        axi_rdata   <= 0;
        read_active <= 0;
        byte_idx    <= 0;
    end else begin
        axi_arready <= 0;
        ram_a_en    <= 0;

        if (axi_arvalid && !read_active && !axi_rvalid) begin
            axi_arready <= 1;
            araddr_q    <= axi_araddr;
            read_active <= 1;
            byte_idx    <= 0;
            axi_rdata   <= 0;
        end
        else if (read_active) begin
            ram_a_en    <= 1;
            ram_a_addr <= base_r + byte_idx;
            axi_rdata[8*byte_idx +:8] <= ram_a_rdata;

            if (byte_idx == 3) begin
                read_active <= 0;
                axi_rvalid  <= 1;
            end else begin
                byte_idx <= byte_idx + 1;
            end
        end
        else if (axi_rvalid && axi_rready) begin
            axi_rvalid <= 0;
        end
    end
end

assign axi_bresp = 2'b00;
assign axi_rresp = 2'b00;

endmodule
