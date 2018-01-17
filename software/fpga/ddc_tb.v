`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:51:29 11/28/2015
// Design Name:   ddc
// Module Name:   /home/lichee/work/LCSDR/src/xilinx/main1/ddc_tb.v
// Project Name:  main1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ddc
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ddc_tb;

	// Inputs
	reg [11:0] ADC_IN;
	reg ADC_CLK;
	reg ENC_SW;
	reg ENC_DIR;
	reg ENC_CNT;
	reg ENC_CLK;
	reg CIC_CLK;
    reg DATA_ACK;

	// Outputs
	wire [15:0] OUT;
    wire DATA_RDY;

	// Instantiate the Unit Under Test (UUT)
	ddc uut (
		.ADC_IN(ADC_IN), 
		.ADC_CLK(ADC_CLK), 
		.ENC_SW(ENC_SW), 
		.ENC_DIR(ENC_DIR), 
		.ENC_CNT(ENC_CNT), 
		.ENC_CLK(ENC_CLK), 
		.OUT(OUT), 
        .DATA_ACK(DATA_ACK),
		.CIC_CLK(CIC_CLK),
        .DATA_RDY(DATA_RDY)
	);

	initial begin
		// Initialize Inputs
		ADC_IN = 0;
		ADC_CLK = 0;
		ENC_SW = 0;
		ENC_DIR = 0;
		ENC_CNT = 0;
		ENC_CLK = 0;
		CIC_CLK = 0;
        DATA_ACK = 0;

		// Wait 100 ns for global reset to finish
        ADC_IN = 2;
		#100;
        
		// Add stimulus here

	end

    parameter PERIOD_ADC = 1000/40;
    parameter PERIOD_CIC = 1000/80;

    always begin
        CIC_CLK = 1'b0;
        #(PERIOD_CIC/2) CIC_CLK = 1'b1;
        #(PERIOD_CIC/2);
    end       

    always begin
        ADC_CLK = 1'b0;
        #(PERIOD_ADC/2) ADC_CLK = 1'b1;
        #(PERIOD_ADC/2);
    end       
      
endmodule

