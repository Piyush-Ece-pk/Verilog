module sensor(
    input wire clk,rst,
    output reg signed[7:0] accel,
    output reg signed[7:0] steer,
    output reg [7:0] brake
);

reg [7:0] counter;

always @(posedge clk or negedge rst) 
begin
    if (rst == 1'b0) begin
        accel <= 8'd0;
        steer <= 8'd0;
        brake <= 8'd0;
        counter <= 8'd0;
    end
    else begin
        counter <= counter+1;
        brake <= (counter>200)? 8'd200 : counter ;
        accel <= counter-8'd64;
        steer <= counter[6:0];
    end
end
endmodule