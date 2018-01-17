`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:05:12 12/02/2015
// Design Name:   fir_compiler_v5_0_first
// Module Name:   /home/lichee/work/LCSDR/src/xilinx/main1/fir_first_tb.v
// Project Name:  main1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fir_compiler_v5_0_first
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fir_first_tb;

	// Inputs
	reg sclr;
	reg nd;
	reg clk;
	reg [17:0] din;

	// Outputs
	wire rfd;
	wire rdy;
	wire [17:0] dout;

	// Instantiate the Unit Under Test (UUT)
	fir_compiler_v5_0_first uut (
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
    parameter PERIOD= 1000/80;
      
    always begin
        clk = 1'b0;
        #(PERIOD/2) clk = 1'b1;
        #(PERIOD/2);
    end       
endmodule

