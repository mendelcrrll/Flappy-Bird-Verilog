module pipe_gen(
    input clk,
	 input LFSR_clk,
    input rst,
    input enable,
    output reg [15:0] new_pipe
);
    wire [3:0] gap_pos; 

    LFSR4 #(4) gap_gen1 (
        .clk(clk),
        .reset(rst),
        .Q(gap_pos)
    );
	 

    always @(posedge clk) begin
        if (rst) begin
            new_pipe <= 16'b0; 
        end else if (enable) begin
            new_pipe <= 16'b1111111111111111;
            new_pipe[(gap_pos + 1) % 11 +: 4] <= 4'b0000;
        end else begin
            new_pipe <= 16'b0;
        end
    end
endmodule
