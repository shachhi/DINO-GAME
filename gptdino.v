module pixel_game (
    input clk,
    input reset,
    input jump_button,
    output reg [15:0] grid  // [15:8] = row 1, [7:0] = row 0
);

reg [2:0] col;
reg row;
reg [25:0] slow_clk;

wire tick = slow_clk[22];

always @(posedge clk) begin
    slow_clk <= slow_clk + 1;
end

always @(posedge tick or posedge reset) begin
    if (reset)
        col <= 0;
    else
        col <= (col == 7) ? 0 : col + 1;
end

always @(posedge tick or posedge reset) begin
    if (reset)
        row <= 0;
    else if (jump_button)
        row <= ~row;
end

always @(*) begin
    grid = 16'b0;
    if (row == 0)
        grid[col] = 1'b1;        // row 0 is bits [7:0]
    else
        grid[col + 8] = 1'b1;    // row 1 is bits [15:8]
end

endmodule
