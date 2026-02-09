module counter(
    input clk,
    input reset,
	 input collision,
    input enable,
    output logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1
);
    logic [3:0] a, b, c;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            a <= 0;
            b <= 0;
            c <= 0;
        end else if (enable) begin
            if (a == 4'b1001) begin
                a <= 0;
                if (b == 4'b1001) begin
                    b <= 0;
                    c <= c + 1'b1;
                end else begin
                    b <= b + 1'b1;
                end
            end else begin
                a <= a + 1'b1;
            end
        end
    end

    always @(*) begin
        case (c)
            4'b0000: HEX5 = 7'b1000000; // 0
            4'b0001: HEX5 = 7'b1111001; // 1
            4'b0010: HEX5 = 7'b0100100; // 2
            4'b0011: HEX5 = 7'b0110000; // 3
            4'b0100: HEX5 = 7'b0011001; // 4
            4'b0101: HEX5 = 7'b0010010; // 5
            4'b0110: HEX5 = 7'b0000010; // 6
            4'b0111: HEX5 = 7'b1111000; // 7
            4'b1000: HEX5 = 7'b0000000; // 8
            4'b1001: HEX5 = 7'b0010000; // 9
            default: HEX5 = 7'b1000000; // Default to 0
				
        endcase

        case (b)
            4'b0000: HEX4 = 7'b1000000; // 0
            4'b0001: HEX4 = 7'b1111001; // 1
            4'b0010: HEX4 = 7'b0100100; // 2
            4'b0011: HEX4 = 7'b0110000; // 3
            4'b0100: HEX4 = 7'b0011001; // 4
            4'b0101: HEX4 = 7'b0010010; // 5
            4'b0110: HEX4 = 7'b0000010; // 6
            4'b0111: HEX4 = 7'b1111000; // 7
            4'b1000: HEX4 = 7'b0000000; // 8
            4'b1001: HEX4 = 7'b0010000; // 9
            default: HEX4 = 7'b1111111; // Default to off
        endcase

        case (a)
            4'b0000: HEX3 = 7'b1000000; // 0
            4'b0001: HEX3 = 7'b1111001; // 1
            4'b0010: HEX3 = 7'b0100100; // 2
            4'b0011: HEX3 = 7'b0110000; // 3
            4'b0100: HEX3 = 7'b0011001; // 4
            4'b0101: HEX3 = 7'b0010010; // 5
            4'b0110: HEX3 = 7'b0000010; // 6
            4'b0111: HEX3 = 7'b1111000; // 7
            4'b1000: HEX3 = 7'b0000000; // 8
            4'b1001: HEX3 = 7'b0010000; // 9
            default: HEX3 = 7'b1111111; // Default to off
        endcase
		  HEX2 = 7'b1111111;
        HEX1 = 7'b1111111;
		  // Display "LOSER" if collision occurs
        if (collision) begin
            HEX5 = 7'b1000111; // 'L'
            HEX4 = 7'b1000000; // 'O'
            HEX3 = 7'b0010010; // 'S'
            HEX2 = 7'b0000110; // 'E'
            HEX1 = 7'b0001000; // 'R'
		  end else begin
		  if (reset) begin
				HEX5 = 7'b0010010; // 'S'
            HEX4 = 7'b0000111; // 't'
            HEX3 = 7'b0001000; // 'A'
            HEX2 = 7'b0101111; // 'R'
            HEX1 = 7'b0000111; // 't'
		  end
		  end
    end
endmodule