module pipes(
    input clk,
	 input LFSR_clk,
    input rst,
    output reg [15:0][15:0] shifted_green 
);

logic enable_new_pipe, enable_shift_left;
logic [15:0] new_pipe;

pipe_gen new_pipe_inst (
    .clk(clk),
    .rst(rst),
	 .LFSR_clk(LFSR_clk),
    .enable(enable_new_pipe),
    .new_pipe(new_pipe) 
);


shift_left shift_left_inst (
    .clk(clk),
    .rst(rst),
    .enable(enable_shift_left),
    .new_pipe(new_pipe),
    .shifted_green(shifted_green) 
);


always @(posedge clk) begin
    if (rst) begin
        enable_new_pipe <= 1'b1;
        enable_shift_left <= 1'b0;
    end else begin
	     enable_new_pipe <= 1'b0;
		  enable_shift_left <= 1'b1;
        if (shifted_green[0][15]) begin
            enable_new_pipe <= 1'b1;
        end else begin
            enable_new_pipe <= 1'b0;
        end
    end
end

endmodule
