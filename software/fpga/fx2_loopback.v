`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:16 11/09/2015 
// Design Name: 
// Module Name:    fx2_loopback
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
module fx2_loopback(
    input clk_locked,
    inout [15:0] data,
    output reg [1:0] addr,
    output reg slrd,
    output reg slwr,
    output reg sloe,
    input flag_ef,
    input flag_ff,
    input clk,
    output ifclk,
    output reg done
);

wire fifo_clk, fifo_full, fifo_empty;
reg fifo_rst, fifo_wr_en, fifo_rd_en;
wire [15:0]fifo_din;
wire [15:0]fifo_dout;
wire [7:0]data_count;

fifo_fx2 fifo (
    .clk(fifo_clk), // input clk
    .rst(fifo_rst), // input rst
    .din(fifo_din), // input [15 : 0] din
    .wr_en(fifo_wr_en), // input wr_en
    .rd_en(fifo_rd_en), // input rd_en
    .dout(fifo_dout), // output [15 : 0] dout
    .full(fifo_full), // output full
    .empty(fifo_empty), // output empty
    .data_count(data_count) // output [7 : 0] data_count
);

assign fifo_clk = clk;
assign data = (slwr)? 16'bz : fifo_dout;
assign fifo_din = data;

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

parameter INIT=0,IDLE=1,PRE_READ=2,READ=3,READ_LAST=4,WRITE=5;

initial begin
    done <= 0;
end


always @ (negedge clk)
    case (state)
        INIT:
        begin
            fifo_wr_en <= 0;
            fifo_rd_en <= 0;
            fifo_rst <= 1;
        end
        IDLE:
        begin
            fifo_rst <= 0;
            fifo_rd_en <= 0;
        end
        PRE_READ:
        begin
            fifo_wr_en <= 1;
        end
        READ:
        begin
        end
        READ_LAST:
        begin
            fifo_wr_en <= 0;
            fifo_rd_en <= 1;
        end
        WRITE:
        begin
        end
    endcase

always @ (posedge clk)
    case (state)
        INIT:
        begin
            sloe <= 1;
            slrd <= 1;
            slwr <= 1;
            addr <= 2'b0;
            if (clk_locked)
                state <= IDLE;
        end
        IDLE:
        begin
            done <= 1;
            if (flag_ef) begin
                state <= PRE_READ;
                sloe <= 0;
            end
        end
        PRE_READ:
        begin
            slrd <= 0;
            state <= READ;
        end
        READ:
        begin
            if (!flag_ef) begin
                state <= READ_LAST;
                slrd <= 1;
            end
                
        end
        READ_LAST:
        begin
            state <= WRITE;
            sloe <= 1;
            slwr <= 0;
            addr <= 2'b10;
        end
        WRITE:
        begin
            if (fifo_empty) begin
                state <= IDLE;
                addr <= 2'b00;
                slwr <= 1;
            end
        end
    endcase

endmodule
