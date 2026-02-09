module bird_tb;
    // Inputs
    reg clk;
    reg rst;
    reg press;

    // Outputs
    wire [15:0][15:0] red;

    // Instantiate the bird module
    bird uut (
        .clk(clk),
        .rst(rst),
        .press(press),
        .red(red)
    );

    // Clock generation
    always #5 clk = ~clk; // Toggle clock every 5 ns, 100 MHz clock

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        press = 0;

        // Apply reset to initialize the bird
        #50; // Wait for 50 ns
        rst = 0; // Deassert reset

        // Simulate bird behavior over time
        // Initial state with no press
        #100;
        press = 1; // Simulate pressing the bird to make it flap
        #50;  // Wait for flap duration
        press = 0; // Release the press

        // Wait to observe the bird's movement without pressing
        #100;

        // Simulate another flap press
        press = 1;  // Press the bird again
        #50;
        press = 0;  // Release the press

        // Continue to observe behavior
        #200;

        // Simulate some more presses and releases
        repeat (5) begin
            #100;
            press = 1;  // Press to flap
            #50;
            press = 0;  // Release after flap
        end

        // Observe the behavior for a longer time
        #500;

        // Finish the simulation
        $stop;
    end
endmodule
