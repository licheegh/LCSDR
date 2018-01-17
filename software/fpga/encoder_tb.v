`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:23:39 10/18/2015
// Design Name:   encoder
// Module Name:   D:/work/LCSDR/src/xilinx/main1/encoder_tb.v
// Project Name:  main1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: encoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module encoder_tb;

	// Inputs
	reg ina;
	reg inb;
	reg sw;
	reg clk;

	// Outputs
	wire sw_out;
	wire dir;
	wire cnt;

	// Instantiate the Unit Under Test (UUT)
	encoder uut (
		.ina(ina), 
		.inb(inb), 
		.sw(sw), 
		.clk(clk), 
		.sw_out(sw_out), 
		.dir(dir), 
		.cnt(cnt)
	);

	initial begin
		// Initialize Inputs
		ina = 0;
		inb = 0;
		sw = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        #6;
        
		// Add stimulus here
        ina = 1;
        #100;
        inb = 1;
        #100;
        ina = 0;
        #100;
        inb = 0;
        #100;
        inb = 1;
        #100;
        ina = 1;
        #100;
        inb = 0;
        #100;
        ina = 0;


	end

    parameter PERIOD = 1000/50;

    always begin
        clk = 1'b0;
        #(PERIOD/2) clk = 1'b1;
        #(PERIOD/2);
    end       
      
endmodule

