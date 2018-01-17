`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:15 11/14/2015 
// Design Name: 
// Module Name:    adc_if 
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
module adc_if(
    input [11:0] DATA_A,
    input [11:0] DATA_B,
    input OTR_A,
    input OTR_B,
    output OEB_A,
    output OEB_B,
    output PDWN_A,
    output PDWN_B,
    output DCS,
    output DFS,
    input clk,
    output reg [11:0] DATA_O_A
    );

    initial begin
        DATA_O_A <= 0;
    end
    // 0: en 1: dis
    assign PDWN_A = 0;
    assign PDWN_B = 1;

    // 0: en 1: high-z
    assign OEB_A = 0;
    assign OEB_B = 1;

    // 1: en 0: dis duty cycle stabilizer
    assign DCS = 1;
    // 1: twos complement 0: offset binary
    assign DFS = 1;

    always @ (posedge clk) begin
        DATA_O_A <= DATA_A;
    end


endmodule
