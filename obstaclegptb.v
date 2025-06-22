`timescale 1ns/1ps

module obstacle_gen_tb;

    reg clk;
    reg reset;
    reg tick;
    wire [7:0] down;

    obstacle_gen uut (
        .clk(clk),
        .reset(reset),
        .tick(tick),
        .down(down)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 100MHz clock (10ns period)

    initial begin
        $dumpfile("obstaclegpt.vcd");
        $dumpvars(0, obstacle_gen_tb);

        // Initial values
        tick = 0;
        reset = 1;

        #20 reset = 0;

        // Stimulate 50 ticks
        repeat (50) begin
            #10 tick = 1;
            #10 tick = 0;
            $display("T=%0t | down = %b", $time, down);
        end

        $finish;
    end

endmodule
