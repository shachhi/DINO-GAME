`timescale 1ns/1ns

module tb_obstcl_gen;

    // Testbench signals
    reg clk;
    reg reset;
    wire [7:0] ledLine;
    //wire collision;

    // Instantiate the module under test
    obstacle_generator uut (
        .clk(clk),
        .reset(reset),
        .ledLine(ledLine)
    );

    // Generate a clock with 10ns period
    initial clk = 0;
    always #5 clk = ~clk;  // Toggle every 5ns (period = 10ns)

    // Stimulus logic
    initial begin
        $display("Time\tReset\tObstacles");
        $monitor("%0t\t%b\t%b\t%b", $time, reset, ledLine,collison);

        // Initialize
        reset = 1;
        #10;
        reset = 0;

        // Run for some time
        #400;

        $finish;
    end

endmodule
