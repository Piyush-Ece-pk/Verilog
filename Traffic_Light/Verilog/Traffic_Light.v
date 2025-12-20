module traffic_light(
    input wire clk,rst,
    input wire nss,sns,wes,ews,
    output reg[1:0] s,w,n,e
);

parameter 
    nr = 4'd0,
    ny = 4'd1,
    ng = 4'd2,
    sr = 4'd3,
    sy = 4'd4,
    sg = 4'd5,
    er = 4'd6,
    ey = 4'd7,
    eg = 4'd8,
    wr = 4'd9,
    wy = 4'd10,
    wg = 4'd11;

reg [3:0] current_s,next_s;
integer count;

always @(posedge clk or negedge rst)
begin
    if (rst == 1'b0) begin
        count <= 0;
        current_s <= nr;
    end
    else begin
        current_s <= next_s;
        if (count == 10) begin
            count <= 0;
        end
        else begin
            count <= count+1;
        end
    end
end

always @(*) begin
    n <= 2'b00;
    s <= 2'b00;
    w <= 2'b00;
    e <= 2'b00;
    next_s <= current_s;
    case (current_s) 
        nr : begin  
            n <= 2'b10;
            if (sns) 
                next_s <= sg;
            else if (nss) 
                next_s <= ng;
            else if (ews) 
                next_s <= eg;
            else 
                next_s <= wg;
        end

        ny : begin
            n <= 2'b01;
            next_s <= (count == 5) ? ng:nr;
        end

        ng: begin
            n <= 2'b00;
            if (count == 10) begin
                if (nss && !(sns || ews || wes ))
                    begin
                    next_s <= ng;
                end
                else 
                    next_s <= ny;
            end
        end

        sr : begin  
            s <= 2'b10;
            if (sns) 
                next_s <= sg;
            else if (nss) 
                next_s <= ng;
            else if (ews) 
                next_s <= eg;
            else 
                next_s <= wg;
        end

        sy : begin
            s <= 2'b01;
            next_s <= (count == 5) ? sg:sr;
        end

        sg: begin
            s <= 2'b00;
            if (count == 10) begin
                if (sns && !(nss || ews || wes ))
                    begin
                    next_s <= sg;
                end
                else 
                    next_s <= sy;
            end
        end

        er : begin  
            e <= 2'b10;
            if (sns) 
                next_s <= sg;
            else if (nss) 
                next_s <= ng;
            else if (ews) 
                next_s <= eg;
            else 
                next_s <= wg;
        end

        ey : begin
            e <= 2'b01;
            next_s <= (count == 5) ? eg:er;
        end

        eg: begin
            e <= 2'b00;
            if (count == 10) begin
                if (ews && !(sns || nss || wes ))
                    begin
                    next_s <= eg;
                end
                else 
                    next_s <= ny;
            end
        end

        wr : begin  
            w <= 2'b10;
            if (sns) 
                next_s <= sg;
            else if (nss) 
                next_s <= ng;
            else if (ews) 
                next_s <= eg;
            else 
                next_s <= wg;
        end

        wy : begin
            w <= 2'b01;
            next_s <= (count == 5) ? wg:wr;
        end

        wg: begin
            w <= 2'b00;
            if (count == 10) begin
                if (wes && !(sns || ews || nss ))
                    begin
                    next_s <= wg;
                end
                else 
                    next_s <= wy;
            end
        end
        default : begin
            next_s <= ng;
        end
    endcase
end
endmodule
