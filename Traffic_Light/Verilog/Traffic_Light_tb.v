module traffic_light_tb();
    reg clk,rst;
    reg sns,nss,wes,ews;
    wire [1:0] n,s,w,e;



traffic_light traffic_uut(
    .clk(clk),
    .rst(rst),
    .nss(nss),
    .sns(sns),
    .ews(ews),
    .wes(wes),
    .n(n),
    .s(s),
    .e(e),
    .w(w)
);

initial begin
    clk <= 1'b0;
    forever #5 
    clk <= ~clk;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,traffic_light_tb);
    rst <= 1'b0; 
    nss <= 1'b0;sns <= 1'b0;ews <= 1'b0;wes <= 1'b0;
    #10;
    rst <= 1'b1;
    #20;
    wes <= 1'b1;
    #100;
    wes <= 1'b0;
    nss <= 1'b1;
    #200;
    nss <= 1'b0;
    sns <= 1'b1;
    #100;
    sns <= 1'b0;
    ews <= 1'b1;
    #150;
    ews <= 1'b0;
    #10;
    $finish;
end
endmodule




