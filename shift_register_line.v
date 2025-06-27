module shift_register_line(input in, input on, input clk,output reg [7:0] ledLine);
   initial ledLine=8'b0;
   always @(posedge clk)begin
    if (on) ledLine<={ledLine[6:0],in};//for obstacle to be generate from right to left
    //ledLine<={in,ledLine[7:1]} would have done from left to right obstacle generation
   end
endmodule