module shift_left(
    input clk,
    input rst,
    input enable,
    input [15:0] new_pipe, 
    output reg [15:0][15:0] shifted_green
);
    integer i, j;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            shifted_green <= '0;				
        end else if (enable) begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 15; j > 0; j = j - 1) begin
                    shifted_green[i][j] <= shifted_green[i][j - 1];
						  shifted_green[i][j - 1] <= 1'b0;
                end
            end
				for (i = 0; i < 16; i = i + 1) begin
					shifted_green[i][0] <= new_pipe[i];
				end
        end
    end
endmodule
