module shift_left_tb;

    reg clk;
    reg rst;
    reg enable;
    reg [15:0][15:0] green;
    wire [15:0][15:0] new_green;

    // Instantiate the shift_left module
    shift_left uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .green(green),
        .new_green(new_green)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Display the board
    task display_board(input [15:0][15:0] board);
        integer i, j;
        begin
            for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    if (board[i][j] == 1)
                        $write("#");
                    else
                        $write(".");
                end
                $write("\n");
            end
            $write("\n");
        end
    endtask

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        enable = 0;
        green = 16'hFFFF;

        // Apply reset
        #10;
        rst = 0;

        // Test case: Shift left
        enable = 1;
        green[0] = 16'b1010101010101010;
        green[1] = 16'b1100110011001100;
        green[2] = 16'b1111000011110000;
        green[3] = 16'b0000111100001111;
        #10;

        // Display initial board
        $display("Initial Board:");
        display_board(green);
		  
		  repeat (10) begin
            #10;
            $display("Shifted Board:");
            display_board(new_green);
            green = new_green;
        end

        // Finish simulation
        $stop;
    end

endmodule
