`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:16 11/09/2015 
// Design Name: 
// Module Name:    fx2_if
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fx2_if(
    input clk_locked,
    input [15:0] datai,
    inout [15:0] data,
    output reg [1:0] addr,
    output reg slrd,
    output reg slwr,
    output reg sloe,
    input flag_ef,
    input flag_ff,
    input clk,
    output ifclk,
    output reg done,
    input data_rdy
);

assign data = (slwr)? 16'bz : datai;

ODDR2 #(
    .DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1" 
    .INIT(1'b0),    // Sets initial state of the Q output to 1'b0 or 1'b1
    .SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
) ODDR2_inst (
    .Q(ifclk),   // 1-bit DDR output data
    .C0(!clk),   // 1-bit clock input
    .C1(clk),   // 1-bit clock input
    .CE(1'b1), // 1-bit clock enable input
    .D0(1'b1), // 1-bit data input (associated with C0)
    .D1(1'b0), // 1-bit data input (associated with C1)
    .R(1'b0),   // 1-bit reset input
    .S(1'b0)    // 1-bit set input
);

reg [2:0]state = 0;

parameter INIT=0,WAIT=1,WRITE=2;

initial begin
    done <= 0;
    sloe <= 1;
    slrd <= 1;
    slwr <= 1;
    addr <= 2'b10;
end

always @ (posedge clk)
    case (state)
        INIT:
        begin
            if (clk_locked)
                state <= WAIT;
        end
        WAIT:
        begin
            done <= 1;
            if (flag_ff & data_rdy) begin
                slwr <= 0;
                state <= WRITE;
            end
        end
        WRITE:
        begin
            if ((!flag_ff) | (!data_rdy)) begin
                slwr <= 1;
                state <= WAIT;
            end
        end
    endcase

endmodule
