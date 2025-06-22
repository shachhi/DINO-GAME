module dino_mov(
    input clk,
    input reset,
    input jump_button,
    output reg [15:0] grid //[15:8]=row1, [7:0]=row0
);
reg [2:0] col;
reg row;
reg [1:0]jump_counter;
always @(posedge clk or posedge reset) begin 
    if (reset) begin
    row<=0;
    jump_counter=0;
    end
    else begin
            if (jump_button && row == 0) begin
                // Start jump
                row <= 1;
                jump_counter <= 2; // stays in air for 2 clock cycles ie 20ns
            end 
            //ignore the jump initiated when row==1
            else if (jump_counter!=0)begin
                jump_counter <= jump_counter - 1;
                if (jump_counter == 1)
                    row <= 0; // fall back down
            end
    end
    //row<=~row;// this is making the dino jump up or down only when i push jump i want it to jump then after some clk
    //cycles come back down again
    //Idea:
//When jump_button is pressed, set row = 1.

//Start a counter (e.g., 3 or 4 cycles).

//After the counter expires, reset row = 0.


end

always @(*) begin
        grid = 16'b0;  // clear grid
        if (row == 0)
            grid[7] = 1'b1;       // row 0, column 0 (down row)
        else
            grid[15] = 1'b1;       // row 1, column 0 (up row)
    end
endmodule