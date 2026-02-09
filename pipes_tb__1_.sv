module pipes_tb;

    reg clk;
    reg rst;
    reg [15:0][15:0] green;
    wire [15:0][15:0] new_board;

    // Instantiate the pipes module
    pipes uut (
        .clk(clk),
        .rst(rst),
        .shifted_green(new_board)
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
	 
	 integer i,j;
    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        for (i = 0; i < 16; i = i + 1) begin
                for (j = 0; j < 16; j = j + 1) begin
                    green[i][j] <= 1'b0; 
                end
		  end
		  

        // Apply reset
        #10;
		  rst = 0;
		  
		  #10;
			  // Display initial board
			  $display("Initial Board:");
			  display_board(green);
		  
		  repeat (100) begin
			  #10;
			  $display("New Board:");
			  display_board(new_board);
		 end

        $stop;
    end

endmodule
