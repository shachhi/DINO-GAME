module obstacle_generator(input clk,input reset,output [7:0]ledLine);
   wire randomNo;
   reg bitstream=0;
   lfsr_random_bit randomGenerator(clk,randomNo);
   shift_register_line LINE(bitstream,1'b1,clk,ledLine);

   parameter LAST_ZERO=3'b100;
   parameter FIRST_ONE=3'b000;
   parameter SECOND_ONE=3'b001;
   parameter FIRST_ZERO=3'b010;
   parameter SECOND_ZERO=3'b011;

   reg [2:0] state= LAST_ZERO;

   always @(posedge clk) begin
    if (reset) state<=LAST_ZERO;
    else if ((state==LAST_ZERO) && randomNo) state<=FIRST_ONE;
    else if ((state==LAST_ZERO) && ~randomNo) state<=SECOND_ONE;
    else state<=state+1;
   end

   always @(posedge clk) bitstream<=~(state[2]|state[1]);
   //only the nor of first two bits of FIRST_ONE AND SECOND_ONE states give me 1

endmodule