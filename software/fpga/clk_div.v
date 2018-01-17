`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:28:57 10/19/2015 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div(
    input clk_in,
    output clk_out
    );
	 
    parameter width=13;
    parameter count=13'd6000;
    reg [width:0]counter=0;
    reg clk_int=0;

    always @ (posedge clk_in) begin
        counter <= counter + 1'd1;
        if (counter == count) begin
            counter <= 0;
            clk_int <= ~clk_int;
        end
    end

    assign clk_out = clk_int;


endmodule
