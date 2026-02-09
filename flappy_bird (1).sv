module flappy_bird(
	input CLOCK_50,
	input bird_clk,
	input pipe_clock,
   input rst,
	input press,
	output reg [15:0][15:0] GrnPixels,
   output reg [15:0][15:0] RedPixels,
	output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1,
	output logic collision_reset, 
	output logic score_update
	);
  
    pipes uut (
        .clk(pipe_clock),
		  .LFSR_clk(CLOCK_50),
        .rst(rst || collision_reset),
        .shifted_green(GrnPixels)
    );
	 
	 bird birdy(
	 .clk(bird_clk),
    .rst(rst),
    .press(press),
    .red(RedPixels)
	 );
	 
	 collision col(
    .clk(CLOCK_50),
    .rst(rst),
	 .press(press),
    .red(RedPixels), 
    .green(GrnPixels),
	 .collision(collision_reset)
  );
  
  
  counter uut_counter (
     .clk(pipe_clock),
     .reset(rst),
	  .collision(collision_reset),
     .enable(score_update),
     .HEX5(HEX5),
     .HEX4(HEX4),
     .HEX3(HEX3),
	  .HEX2(HEX2),
	  .HEX1(HEX1)
    );
	 
	 
  score score(
    .clk(pipe_clock),
    .rst(rst || collision_reset),
    .green(GrnPixels),
	 .score(score_update)
  );
  

  
endmodule
	 