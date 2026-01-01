module window_mean(
    input wire clk,rst,
    input wire [7:0] score, 
    output reg [7:0] avg
);

reg [7:0] buff [0:7];
reg [10:0] sum;
integer i;

always @(posedge clk or negedge rst) begin  
    if (rst == 1'b0) begin
        sum <= 11'd0;
        avg <= 11'd0;
        for (i=0;i<8;i=i+1)
            buff[i] <= 0;
    end
    else begin
        sum <= sum - buff[7] + score;
        for (i=7;i>0;i=i-1) 
            buff[i] <= buff[i-1];
        buff[0] <= score;
        avg <= sum >> 3;
    end
end
endmodule 

