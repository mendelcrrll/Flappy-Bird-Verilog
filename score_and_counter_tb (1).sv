module score_and_counter_tb;
    // Inputs
    reg clk;
    reg rst;
    reg [15:0][15:0] green;
    reg collision;
    reg enable;

    // Outputs
    wire score;
    wire [6:0] HEX5, HEX4, HEX3, HEX2, HEX1;

    // Instantiate the score and counter modules
    score score_inst (
        .clk(clk),
        .rst(rst),
        .green(green),
        .score(score)
    );

    counter counter_inst (
        .clk(clk),
        .reset(rst),
        .collision(collision),
        .enable(enable),
        .HEX5(HEX5),
        .HEX4(HEX4),
        .HEX3(HEX3),
        .HEX2(HEX2),
        .HEX1(HEX1)
    );

    // Clock generation
    always #5 clk = ~clk; // Toggle clock every 5 ns, 100 MHz clock

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        green = 16'b0;
        collision = 0;
        enable = 0;

        // Apply reset
        #50; // Wait for 50 ns
        rst = 0; // Deassert reset

        // Simulate score condition (green[15][14] is set to 1)
        green[15][14] = 1;
        #10;
        green[15][14] = 0; // Turn off the green signal
        
        // Test score condition when green[15][14] is high
        #100;

        // Simulate collision (score should trigger LOSER)
        collision = 1;
        #50;
        collision = 0;

        // Enable counter and check HEX outputs
        enable = 1;
        #200; // Let the counter run for a while

        // Test when counter reaches certain values
        #100;
        enable = 0; // Disable counter to hold at the current value

        // Apply reset again to observe behavior during reset
        #50;
        rst = 1;
        #50; rst = 0;

        // Finish simulation
        $stop;
    end
endmodule
