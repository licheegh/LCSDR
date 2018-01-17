`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:23:33 10/22/2015
// Design Name:   wave_gen
// Module Name:   D:/work/LCSDR/src/xilinx/main1/wave_gen_tb.v
// Project Name:  main1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: wave_gen
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module wave_gen_tb;

	// Inputs
	reg CLK;
	reg LATCH;

	// Outputs
	wire [15:0] DATA_L;
	wire [15:0] DATA_R;

	// Instantiate the Unit Under Test (UUT)
	wave_gen uut (
		.DATA_L(DATA_L), 
		.DATA_R(DATA_R), 
		.CLK(CLK), 
		.LATCH(LATCH)
	);

	initial begin
		// Initialize Inputs
		CLK = 0;
		LATCH = 0;

		// Wait 100 ns for global reset to finish
		#100;

        LATCH = 1;
        #10;
        LATCH = 0;

        #200;
        LATCH = 1;
        #10;
        LATCH = 0;

        
		// Add stimulus here

	end

    parameter PERIOD = 1000/100;

    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end       
      
endmodule

