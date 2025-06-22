module lfsr_random_bit(input clk, output randomBit);
   reg[7:0] lfsr;
   initial lfsr=8'b1;//10000000
   always @(posedge clk)begin
    lfsr<={lfsr[6:0],lfsr[7]^lfsr[5]^lfsr[4]^lfsr[3]};
   end
   assign randomBit=lfsr[0];
endmodule