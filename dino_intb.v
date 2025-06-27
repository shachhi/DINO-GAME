`timescale 1ns/1ns

module dino_game_top_tb;

    reg clk = 0;
    reg reset = 1;
    reg jmp = 0;
    wire [15:0] grid_out;
    wire game_over;

    // Clock generation: 50MHz simulated clock (20ns period)
    always #10 clk = ~clk;

    // Instantiate your game
    dino_game_top DUT (
        .clk(clk),
        .reset(reset),
        .jmp(jmp),
        .grid_out(grid_out),
        .game_over(game_over)
    );

    initial begin
        $display("Time | Reset | Jump | Grid Upper | Grid Lower | GameOver");
        $monitor("%4t |   %b    |   %b   |  %8b  |  %8b   |    %b",
                 $time, reset, jmp, grid_out[15:8], grid_out[7:0], game_over);

        // Initial reset
        #50  reset = 0;

        // Simulate a jump at t=100
        #100 jmp = 1;
        #40  jmp = 0;

        // Wait to let obstacles approach
        #100;

        // Simulate another jump
        #500 jmp = 1;
        #40  jmp = 0;

        //simulate jmp
        #120 jmp=1;
        #40 jmp=0;

        #2000;

        $finish;
    end
endmodule
