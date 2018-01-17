`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:56:07 11/15/2015
// Design Name:   adc_if
// Module Name:   /home/lichee/work/LCSDR/src/xilinx/main1/adc_if_tb.v
// Project Name:  main1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adc_if
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module adc_if_tb;

	// Inputs
	reg [11:0] DATA_A;
	reg [11:0] DATA_B;
	reg OTR_A;
	reg OTR_B;
	reg clk;

	// Outputs
	wire OEB_A;
	wire OEB_B;
	wire PDWN_A;
	wire PDWN_B;
	wire DCS;
	wire DFS;
	wire [11:0] DATA_O_A;

	// Instantiate the Unit Under Test (UUT)
	adc_if uut (
		.DATA_A(DATA_A), 
		.DATA_B(DATA_B), 
		.OTR_A(OTR_A), 
		.OTR_B(OTR_B), 
		.OEB_A(OEB_A), 
		.OEB_B(OEB_B), 
		.PDWN_A(PDWN_A), 
		.PDWN_B(PDWN_B), 
		.DCS(DCS), 
		.DFS(DFS), 
		.clk(clk), 
		.DATA_O_A(DATA_O_A)
	);

	initial begin
		// Initialize Inputs
		DATA_A = 0;
		DATA_B = 0;
		OTR_A = 0;
		OTR_B = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

