module LFSR4 #(parameter WIDTH=4) (
    input logic clk, // clock input
    input logic reset, // reset input
    output logic [WIDTH-1:0] Q // present state
);
always_ff @(posedge clk) begin
    if(reset)
        Q <= 1'b1; // Initializing to a non-zero value
    else
        Q <= {Q[WIDTH - 2:0], ~(Q[WIDTH-1] ^ Q[WIDTH-2])};
end
endmodule