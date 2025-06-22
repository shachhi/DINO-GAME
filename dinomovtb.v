module dino_move_tb();
reg clk;
reg reset;
reg jump_button;
wire [15:0] grid;

dino_mov dut (
        .clk(clk),
        .reset(reset),
        .jump_button(jump_button),
        .grid(grid)
    );

    // Clock generation
    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        // Initialize
        reset = 1;
        jump_button = 0;

        #20 reset = 0;

        // Simulate jump at different times
        #200 jump_button = 1;//for 50ns the jump button remains 1
        #70  jump_button = 0;

        #300 jump_button = 1;
        #70  jump_button = 0;

        #200  jump_button = 1;
        #90  jump_button = 0;

        #1000 $finish;
    end

    initial begin
    $dumpfile("dinomov.vcd");
    $dumpvars(0, dino_move_tb);  
    $monitor("time =%d, jump=%b, up=%b \n down=%b", $time,jump_button, grid[15:8], grid[7:0]);
    end
  
    endmodule