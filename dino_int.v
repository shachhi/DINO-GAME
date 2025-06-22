module dino_game_top(
    input clk,
    input reset,
    input jump_button,
    output [15:0] grid,
    output collision
);//for the whole project imagine the actual main module which has reset and clk and jump as input and output 16 wires+collision

    // Instantiate Dino Movement Module
    dino_mov u_dinomov (
        .clk(clk),
        .reset(reset),
        .jump_button(jump_button),
        .grid(grid)
    );

    // Instantiate Obstacle Generator Module
    obstacle_generator u_obstcl (
        .clk(clk),
        .reset(reset),
        .ledLine(grid[7:0])
    );

    assign collision= (~grid[8]) & ledLine[7];

endmodule
