module score(
    input clk,
    input rst,
    input [15:0][15:0] green,
    output logic score
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            score <= 1'b0;
        end else if (green[15][14]) begin
            score <= 1'b1;
        end else begin
            score <= 1'b0;  // Ensure score toggles off when condition is no longer met
        end
    end
endmodule