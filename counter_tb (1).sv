module counter_tb;
    // Inputs
    reg clk;
    reg reset;
    reg enable;  // New enable signal

    // Outputs
    wire [6:0] HEX5, HEX4, HEX3;

    // Instantiate the counter
    counter uut_counter (
        .clk(clk),
        .reset(reset),
        .enable(enable),  // Connect the enable signal
        .HEX5(HEX5),
        .HEX4(HEX4),
        .HEX3(HEX3)
    );

    // Clock generation
    always #5 clk = ~clk; // Toggle clock every 5 ns (100 MHz)

    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        enable = 0;

        // Apply reset
        #10; // Wait 10 ns
        reset = 0;
		  
		  // Enable counting and observe behavior
        enable = 1;
        #10000; // Allow the counter to increment for 500 ns
		  

        // Finish simulation
        $stop;
    end
endmodule
