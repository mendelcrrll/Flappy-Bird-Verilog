module flappy_bird_tb;
    // Inputs
    reg CLOCK_50;
    reg rst;
    reg press;
    reg LFSR_clk;  // Added clock for LFSR
	 reg bird_clk;

    // Outputs
    wire [15:0][15:0] green;
    wire [15:0][15:0] red;
    wire [6:0] HEX5, HEX4, HEX3;

    // Instantiate the flappy_bird module
    flappy_bird uut (
        .CLOCK_50(CLOCK_50),
        .bird_clk(CLOCK_50),
        .pipe_clock(LFSR_clk),
        .rst(rst),
        .press(press),
        .GrnPixels(green),
        .RedPixels(red),
        .HEX5(HEX5),
        .HEX4(HEX4),
        .HEX3(HEX3)
    );

    // Clock generation
    always #10 CLOCK_50 = ~CLOCK_50; // Toggle the clock every 10 ns (50 MHz)
	 always #6 bird_clk = ~bird_clk; // Toggle the LFSR clock (change the period as needed)
    always #7 LFSR_clk = ~LFSR_clk; // Toggle the LFSR clock (change the period as needed)

    initial begin
        // Initialize inputs
        CLOCK_50 = 0;
        LFSR_clk = 0;  // Initialize the LFSR clock
        rst = 1;
        press = 0;

        // Apply reset
        #50; // Wait for 50 ns
        rst = 0;

        // Simulate bird press signal (flap)
        repeat (10) begin
            // Simulate a bird press and reset cycle to observe pipe generation and flap behavior
            #50; press = 0;
            #40; press = 1;

        end
        $stop;
    end
endmodule
