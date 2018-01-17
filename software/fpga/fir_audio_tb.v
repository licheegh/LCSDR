`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:30:11 12/02/2015
// Design Name:   fir_compiler_v5_0_audio
// Module Name:   /home/lichee/work/LCSDR/src/xilinx/main1/fir_audio_tb.v
// Project Name:  main1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fir_compiler_v5_0_audio
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fir_audio_tb;

	// Inputs
	reg sclr;
	reg nd;
	reg clk;
	reg [17:0] din;

	// Outputs
	wire rfd;
	wire rdy;
	wire [35:0] dout;

	// Instantiate the Unit Under Test (UUT)
	fir_compiler_v5_0_audio uut (
		.sclr(sclr), 
		.rfd(rfd), 
		.rdy(rdy), 
		.nd(nd), 
		.clk(clk), 
		.dout(dout), 
		.din(din)
	);

	initial begin
		// Initialize Inputs
		sclr = 0;
		nd = 0;
		clk = 0;
		din = 0;

		// Wait 100 ns for global reset to finish
		#100;
		sclr = 1;
        #100
		sclr = 0;
        #100
        wait (!clk);
        wait (clk);
        wait (!clk);
		nd = 1;
        din = 0;
        wait(!rfd);
        wait(rfd);
        din = 100;
        wait(!rfd);
        //din = 0;
        //nd = 0;
        
		// Add stimulus here

	end
    parameter PERIOD= 1000/5;
      
    always begin
        clk = 1'b0;
        #(PERIOD/2) clk = 1'b1;
        #(PERIOD/2);
    end       
      
endmodule

