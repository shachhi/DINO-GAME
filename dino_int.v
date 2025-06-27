module dino_game_top(
    input clk,
    input reset,
    input jmp,
    output [15:0] grid_out,
    output game_over
);//for the whole project imagine the actual main module which has reset and clk and jump as input 
//and output 16 wires+game_over to detect collision

    wire [15:0] dino_grid;
    wire [7:0] obstacle_line;
    wire collision;



    // Instantiate Dino Movement Module
    dino_mov dino (
        .clk(clk),
        .reset(reset||collsion),
        .jump_button(jmp),
        .grid(dino_grid)
    );

    // Instantiate Obstacle Generator Module
    obstacle_generator u_obstcl (
        .clk(clk),
        .reset(reset||collision),
        .ledLine(obstacle_line)
    );

    // Instantiate collision checker
    wire dino_row;
    assign dino_row=dino_grid[15];
    collision_checker col (
        .clk(clk),
        .reset(reset),
        .obstacle_line(obstacle_line),
        .dino_row(dino_row),
        .collision(collision)
    );


    assign game_over = collision;

    // Combine dino and obstacle into full grid
   assign grid_out[15:8] = dino_grid[15:8];
   assign grid_out[7:0]  = dino_grid[7:0] | obstacle_line;

endmodule
