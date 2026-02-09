module collision(
    input clk,
    input rst,
	 input press,
    input [15:0][15:0] red,  
    input [15:0][15:0] green, 
    output reg collision
);
    integer i;
	 
	 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            collision <= 1'b0;
        end else begin
            for (i = 0; i < 16; i = i + 1) begin
                // Check for collision in column 14
                if (red[i][14] && green[i][14]) begin
                    collision <= 1'b1;
                end
                else if((red[0][14] && press) || (red[15][14] && ~(press))) begin
                    collision <= 1'b1;
					 end
            end
        end
    end
endmodule

