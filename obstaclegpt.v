module obstacle_gen (
    input clk,
    input reset,
    input tick,                // slow clock for movement
    output reg [7:0] down      // obstacle row
);

    reg [7:0] obs_shift;       // internal shift register
    reg [1:0] spacing;         // spacing counter (counts up to 3)

    wire [1:0] rand = spacing ^ obs_shift[1:0];  // simple pseudo-random bits

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            obs_shift <= 8'b0;
            spacing <= 2'd0;
            down <= 8'b0;
        end else if (tick) begin
            if (spacing == 2'd3) begin
                spacing <= 0;
                // inject new obstacle
                case (rand)
                    2'b00: obs_shift <= {obs_shift[6:0], 1'b1};        // 1-bit obstacle
                    2'b01: obs_shift <= {obs_shift[5:0], 2'b11};       // 2-bit obstacle
                    default: obs_shift <= {obs_shift[6:0], 1'b0};      // no obstacle (rare case)
                endcase
            end else begin
                spacing <= spacing + 1;
                obs_shift <= {obs_shift[6:0], 1'b0};  // shift left with blank
            end
            down <= obs_shift;
        end
    end

endmodule

