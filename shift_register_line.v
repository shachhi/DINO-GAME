module shift_register_line(input in, input on, input clk,output reg [7:0] ledLine);
   initial ledLine=8'b0;
   always @(posedge clk)begin
    if (on) ledLine<={in,ledLine[7:1]};
   end
endmodule