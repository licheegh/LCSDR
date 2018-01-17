`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:07:06 12/02/2015
// Design Name:   fm_decode
// Module Name:   /home/lichee/work/LCSDR/src/xilinx/main1/fm_decode_tb.v
// Project Name:  main1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fm_decode
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fm_decode_tb;

	// Inputs
	reg [17:0] INPUT_Q;
	reg [17:0] INPUT_I;
	reg CLK;
	reg RDY;
	reg CLK_RDY;

	// Outputs
	wire ACK;
	wire [23:0] OUTPUT;

	// Instantiate the Unit Under Test (UUT)
	fm_decode uut (
		.INPUT_Q(INPUT_Q), 
		.INPUT_I(INPUT_I), 
		.CLK(CLK), 
		.RDY(RDY), 
		.ACK(ACK), 
		.CLK_RDY(CLK_RDY), 
		.OUTPUT(OUTPUT)
	);

	initial begin
		// Initialize Inputs
		INPUT_Q = 0;
		INPUT_I = 0;
		CLK = 0;
		RDY = 0;
		CLK_RDY = 1;

		// Wait 100 ns for global reset to finish
		#200;
        CLK_RDY = 0;
        #200;
		CLK_RDY = 1;
        #200;

        INPUT_Q = 2000;
        INPUT_I = 3000;
        RDY = 1;
        wait (ACK);
        RDY = 0;
        wait (!ACK);

        INPUT_Q = 3123;
        INPUT_I = 4221;
        RDY = 1;
        wait (ACK);
        RDY = 0;
        wait (!ACK);

        while (1) begin
            INPUT_Q = 100;
            INPUT_I = 1231;
            RDY = 1;
            wait (ACK);
            RDY = 0;
            wait (!ACK);
        end


	end
    parameter PERIOD= 1000/5;
      
    always begin
        CLK = 1'b0;
        #(PERIOD/2) CLK = 1'b1;
        #(PERIOD/2);
    end       
      
endmodule

