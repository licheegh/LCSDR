`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:48:03 10/21/2015
// Design Name:   audio
// Module Name:   D:/work/LCSDR/src/xilinx/main1/audio_tb.v
// Project Name:  main1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: i2s_driver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module i2s_driver_tb;

	// Inputs
	reg [15:0] DATA_L;
	reg [15:0] DATA_R;
	reg CLK;

	// Outputs
	wire BCK;
	wire WS;
	wire DATAI;
	wire RANGE;
	wire DEEM;

	// Instantiate the Unit Under Test (UUT)
	i2s_driver uut (
		.BCK(BCK), 
		.WS(WS), 
		.DATAI(DATAI), 
		.RANGE(RANGE), 
		.DEEM(DEEM), 
		.LATCH(LATCH), 
		.DATA_L(DATA_L), 
		.DATA_R(DATA_R), 
		.CLK(CLK)
	);

	initial begin
		// Initialize Inputs
		DATA_L = 0;
		DATA_R = 0;
		CLK = 0;

		// Wait 100 ns for global reset to finish
		#100;

        DATA_L = 16'h0AA0;
        DATA_R = 16'hA00A;

        #400

        DATA_L = 16'h0FFF;
        DATA_R = 16'h0000;
        
		// Add stimulus here

	end

    parameter PERIOD = 1000/100;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end       
      
endmodule

