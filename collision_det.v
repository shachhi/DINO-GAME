module collision_checker(
    input clk,
    input reset,
    input [7:0] obstacle_line,
    input dino_row,
    output reg collision
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            collision <= 0;
        else
            // Collision only if dino is on bottom row and obstacle at column 0
            collision <= (dino_row == 0) && (obstacle_line[7] == 1'b1);
    end

endmodule
