module axi_ram_tb;
parameter axi_addr_width = 32;
parameter axi_data_width = 32;
parameter ram_addr_width = 19;
parameter img_bytes = 273280;

reg clk;
reg rst;

initial begin 
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 0;
    repeat (10) @(posedge clk);
    rst = 1;
end

reg [axi_addr_width-1:0] axi_awaddr;
reg axi_awvalid;
wire axi_awready;
reg [axi_data_width-1:0] axi_wdata;
reg [3:0] axi_wstrb;
reg axi_wvalid;
wire axi_wready;
wire [1:0] axi_bresp;
wire axi_bvalid;
reg axi_bready;
reg [axi_addr_width-1:0] axi_araddr;
reg axi_arvalid;
wire axi_arready;
wire [axi_data_width-1:0] axi_rdata;
wire [1:0] axi_rresp;
wire axi_rvalid;
reg axi_rready;


axi_ram_top uut(
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
    .ram_b_en(1'b0),
    .ram_b_we(1'b0),
    .ram_b_addr({ram_addr_width{1'b0}}),
    .ram_b_wdata(8'h00),
    .ram_b_rdata()
);

reg [7:0] img_mem [0:img_bytes-1];

initial begin
    $readmemh("C:/Users/piyus/vlsi_lab/dpram_axi/verilog/image.hex", img_mem);
    $display("Loaded image.hex into memory (size = %0d bytes)", img_bytes);
end

task axi_w32;
    input [31:0] addr; 
    input [31:0] data;
    integer timeout;
    begin
        @(posedge clk);
        axi_awaddr <= addr;
        axi_awvalid <= 1'b1;

        timeout = 0;
        while (!axi_awready && timeout < 1000) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        axi_awvalid <= 1'b0;

        @(posedge clk);
        axi_wdata <= data;
        axi_wstrb <= 4'b1111;
        axi_wvalid <= 1'b1;

        timeout = 0;
        while (!axi_wready && timeout < 1000) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        axi_wvalid <= 1'b0;

        axi_bready <= 1'b1;
        timeout = 0;
        while (!axi_bvalid && timeout < 1000) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        axi_bready <= 1'b0;
    end
endtask

task axi_r32;
    input [31:0] addr;
    output [31:0] data;
    integer timeout;
    begin
        @(posedge clk);
        axi_araddr <= addr;
        axi_arvalid <= 1'b1;

        timeout = 0;
        while (!axi_arready && timeout < 1000) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        axi_arvalid <= 1'b0;

        axi_rready <= 1'b1;
        timeout = 0;
        while (!axi_rvalid && timeout < 1000) begin
            @(posedge clk);
            timeout = timeout + 1;
        end
        data <= axi_rdata;
        axi_rready <= 1'b0;
    end
endtask

integer i;
integer fd;
reg [31:0] rdata;
integer chunk_size;

initial begin
    axi_awvalid = 0;
    axi_wvalid  = 0;
    axi_bready  = 0;
    axi_arvalid = 0;
    axi_rready  = 0;

    wait(rst);
    repeat (10) @(posedge clk); 

    fd = $fopen("C:/Users/piyus/vlsi_lab/dpram_axi/verilog/ram_dump.bin","wb");

    chunk_size = 1024; 
    for (i = 0; i < img_bytes; i = i + 4) begin
        axi_w32(i, {img_mem[i+3], img_mem[i+2], img_mem[i+1], img_mem[i]});
        if (i % (chunk_size*4) == 0)
            $display("AXI write progress: %0d/%0d bytes", i, img_bytes);
    end

    for (i = 0; i < img_bytes; i = i + 4) begin
        axi_r32(i, rdata);
        $fwrite(fd, "%c", rdata[7:0]);
        $fwrite(fd, "%c", rdata[15:8]);
        $fwrite(fd, "%c", rdata[23:16]);
        $fwrite(fd, "%c", rdata[31:24]);
        if (i % (chunk_size*4) == 0)
            $display("AXI read progress: %0d/%0d bytes", i, img_bytes);
    end

    $fclose(fd);
    $display("RAM dump written successfully to ram_dump.bin!");
    $finish;
end

endmodule
