`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:02:32 10/22/2015 
// Design Name: 
// Module Name:    wave_gen 
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
module wave_gen(
    output [15:0] DATA_L,
    output reg [15:0] DATA_R,
    input CLK,
    input [7:0]FREQ,
    input LATCH
    );

    parameter ROM_ADD = 10;

    reg [ROM_ADD-1:0]counter=0;

    (* rom_style = "block" *)
    reg [15:0]rom_data[0:(2**ROM_ADD)-1];

    initial
        $readmemh ("data/data.txt", rom_data, 0, (2**ROM_ADD)-1);

    assign DATA_L = 0;

    always @ (posedge CLK) begin
        if (LATCH) begin
            DATA_R <= rom_data[counter];
            counter <= counter + FREQ;
        end
    end


endmodule
