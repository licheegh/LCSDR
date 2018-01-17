`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:01:43 11/11/2015
// Design Name:   main
// Module Name:   D:/work/LCSDR/src/xilinx/main1/main_fx2_wavegen_tb.v
// Project Name:  main1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module main_fx2_wavegen_tb;

	// Inputs
	reg FPGA_CLKIN;
	reg FX2_FLAGA;
	reg FX2_FLAGB;
	reg FX2_FLAGC;
	reg FX2_INT0;
	reg FX2_PKTEND;
	reg FX2_CLKO;
	reg [13:0] D_A;
	reg [13:0] D_B;
	reg ADC_OTR_A;
	reg ADC_OTR_B;
	reg ADC_DCS;
	reg ADC_DFS;
	reg FPGA_CLKOUT_ADC;
	reg ADC_CLK;
	reg ENC_A;
	reg ENC_B;
	reg ENC_SW;
	reg DAC_DATAI;
	reg DAC_DEEM;
	reg DAC_BCK;
	reg DAC_WS;
	reg DAC_PLL;
	reg GND;
	reg M0;
	reg M1;
	reg MISO;
	reg MOSI;
	reg DOUT;
	reg CS;
	reg CLK;
	reg LADC_DI;
	reg LADC_DO;
	reg LADC_CS;
	reg LADC_CLK;
	reg LDAC_LD;
	reg LDAC_DI;
	reg LDAC_CS;
	reg LDAC_CLK;

	// Outputs
	wire [7:0] Ext;
	wire DEBUG_LED;
	wire [1:0] FIFOADR;
	wire FX2_SLWR;
	wire FX2_SLRD;
	wire FX2_SLCS;
	wire FX2_SLOE;
	wire FX2_IFCLK;
	wire ADC_PDWN_A;
	wire ADC_PDWN_B;
	wire ADC_OEB_A;
	wire ADC_OEB_B;
	wire INIT_B;

	// Bidirs
	wire [15:0] FD;

	// Instantiate the Unit Under Test (UUT)
	main uut (
		.Ext(Ext), 
		.FPGA_CLKIN(FPGA_CLKIN), 
		.DEBUG_LED(DEBUG_LED), 
		.FD(FD), 
		.FIFOADR(FIFOADR), 
		.FX2_SLWR(FX2_SLWR), 
		.FX2_SLRD(FX2_SLRD), 
		.FX2_FLAGA(FX2_FLAGA), 
		.FX2_FLAGB(FX2_FLAGB), 
		.FX2_FLAGC(FX2_FLAGC), 
		.FX2_INT0(FX2_INT0), 
		.FX2_PKTEND(FX2_PKTEND), 
		.FX2_SLCS(FX2_SLCS), 
		.FX2_SLOE(FX2_SLOE), 
		.FX2_CLKO(FX2_CLKO), 
		.FX2_IFCLK(FX2_IFCLK), 
		.D_A(D_A), 
		.D_B(D_B), 
		.ADC_OTR_A(ADC_OTR_A), 
		.ADC_OTR_B(ADC_OTR_B), 
		.ADC_DCS(ADC_DCS), 
		.ADC_DFS(ADC_DFS), 
		.FPGA_CLKOUT_ADC(FPGA_CLKOUT_ADC), 
		.ADC_PDWN_A(ADC_PDWN_A), 
		.ADC_PDWN_B(ADC_PDWN_B), 
		.ADC_OEB_A(ADC_OEB_A), 
		.ADC_OEB_B(ADC_OEB_B), 
		.ADC_CLK(ADC_CLK), 
		.ENC_A(ENC_A), 
		.ENC_B(ENC_B), 
		.ENC_SW(ENC_SW), 
		.DAC_DATAI(DAC_DATAI), 
		.DAC_DEEM(DAC_DEEM), 
		.DAC_BCK(DAC_BCK), 
		.DAC_WS(DAC_WS), 
		.DAC_PLL(DAC_PLL), 
		.GND(GND), 
		.INIT_B(INIT_B), 
		.M0(M0), 
		.M1(M1), 
		.MISO(MISO), 
		.MOSI(MOSI), 
		.DOUT(DOUT), 
		.CS(CS), 
		.CLK(CLK), 
		.LADC_DI(LADC_DI), 
		.LADC_DO(LADC_DO), 
		.LADC_CS(LADC_CS), 
		.LADC_CLK(LADC_CLK), 
		.LDAC_LD(LDAC_LD), 
		.LDAC_DI(LDAC_DI), 
		.LDAC_CS(LDAC_CS), 
		.LDAC_CLK(LDAC_CLK)
	);

	initial begin
		// Initialize Inputs
		FPGA_CLKIN = 0;
		FX2_FLAGA = 0;
		FX2_FLAGB = 0;
		FX2_FLAGC = 0;
		FX2_INT0 = 0;
		FX2_PKTEND = 0;
		FX2_CLKO = 0;
		D_A = 0;
		D_B = 0;
		ADC_OTR_A = 0;
		ADC_OTR_B = 0;
		ADC_DCS = 0;
		ADC_DFS = 0;
		FPGA_CLKOUT_ADC = 0;
		ADC_CLK = 0;
		ENC_A = 0;
		ENC_B = 0;
		ENC_SW = 0;
		DAC_DATAI = 0;
		DAC_DEEM = 0;
		DAC_BCK = 0;
		DAC_WS = 0;
		DAC_PLL = 0;
		GND = 0;
		M0 = 0;
		M1 = 0;
		MISO = 0;
		MOSI = 0;
		DOUT = 0;
		CS = 0;
		CLK = 0;
		LADC_DI = 0;
		LADC_DO = 0;
		LADC_CS = 0;
		LADC_CLK = 0;
		LDAC_LD = 0;
		LDAC_DI = 0;
		LDAC_CS = 0;
		LDAC_CLK = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
        #1500;
        FX2_FLAGB <= 1;
        #500;
        FX2_FLAGB <= 0;

		// Add stimulus here

	end

    parameter PERIOD = 1000/40;

    always begin
        ADC_CLK = 1'b0;
        #(PERIOD/2) ADC_CLK = 1'b1;
        #(PERIOD/2);
    end       
      
endmodule

