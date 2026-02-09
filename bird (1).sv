module bird(
    input clk,
    input rst,
    input press,
    output reg [15:0][15:0] red 
    );

	 integer i, j;
    always @(posedge clk) begin
        if (rst) begin
		  		red <= '0;	
				red[1][14] <= 1'b1;
        end else if (press) begin
            for (i = 0; i < 15; i = i + 1) begin
                red[i][14] <= red[i + 1][14];
            end
        end else begin
		    for (i = 1; i < 16; i = i + 1) begin
                red[i][14] <= red[i - 1][14];
					 if (red[14][14]) begin
						red[1][14] <= 1'b1;
					 end
            end
		  end
    end
endmodule