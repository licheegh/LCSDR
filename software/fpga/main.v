`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:56:02 10/10/2015 
// Design Name: 
// Module Name:    main FLAGA
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
module main(Ext, FPGA_CLKIN, DEBUG_LED, FD, FIFOADR, FX2_SLWR, FX2_SLRD, FX2_FLAGA, FX2_FLAGB, FX2_FLAGC, FX2_INT0, FX2_PKTEND, FX2_SLCS, FX2_SLOE, FX2_CLKO, FX2_IFCLK, D_A, D_B, ADC_OTR_A, ADC_OTR_B, ADC_DCS, ADC_DFS, FPGA_CLKOUT_ADC, ADC_PDWN_A, ADC_PDWN_B, ADC_OEB_A, ADC_OEB_B, ADC_CLK, ENC_A, ENC_B, ENC_SW, DAC_DATAI, DAC_DEEM, DAC_BCK, DAC_WS, DAC_PLL, GND, INIT_B, M0, M1, MISO, MOSI, DOUT, CS, CLK, LADC_DI, LADC_DO, LADC_CS, LADC_CLK, LDAC_LD, LDAC_DI, LDAC_CS, LDAC_CLK);

//unused:
input GND;
input M0;
input M1;
input MISO;
input MOSI;
input DOUT;
input CS;
input CLK;
//end

output [7:0] Ext; //External Interface

input FPGA_CLKIN; //Aux clock input

output DEBUG_LED;

output INIT_B;     //DEBUG LED 2

//input DEBUG_LED;

//input INIT_B;     //DEBUG LED 2

/* fx2 */

inout [15:0] FD;
output [1:0] FIFOADR;
input FX2_FLAGA;
input FX2_FLAGB;
output FX2_SLWR;
output FX2_SLRD;
output FX2_SLOE;
output FX2_IFCLK;
output FX2_SLCS; //FLAGD, PA7
// not used:
input FX2_INT0; //PA0
input FX2_FLAGC; //Fixed Function
input FX2_PKTEND; //PA6
input FX2_CLKO; //Fixed Function,selectable clk output from fx2

/* ADC */

input [13:0] D_A;
input [13:0] D_B;
input ADC_OTR_A;
input ADC_OTR_B;
output ADC_DCS;
output ADC_DFS;
input FPGA_CLKOUT_ADC; //clock out for ADC
output ADC_PDWN_A;
output ADC_PDWN_B;
output ADC_OEB_A;
output ADC_OEB_B;
input ADC_CLK;    //used as main clk for all fpga

/* encoder */

input ENC_A;
input ENC_B;
input ENC_SW;

/* Audio DAC */

output DAC_DATAI;
output DAC_DEEM;
output DAC_BCK;
output DAC_WS;
output DAC_PLL;
//input DAC_DATAI;
//input DAC_DEEM;
//input DAC_BCK;
//input DAC_WS;
//input DAC_PLL;

/* Low Speed ADC */

input LADC_DI;
input LADC_DO;
input LADC_CS;
input LADC_CLK;

/* Low Speed DAC */

input LDAC_LD;
input LDAC_DI;
input LDAC_CS;
input LDAC_CLK;

wire clk_10;
wire clk_40;
wire clk_80;
//wire clk_20;
wire clk_5;
//wire clk_div;
wire fx2_clk_locked;
wire [11:0]data_o_a;
wire [15:0]data_filt;
wire data_rdy;
wire cic_data_rdy;
wire sw_output;

//assign ADC_PDWN_A = 1;
//assign ADC_PDWN_B = 1;
//assign ADC_OEB_A= 1;
//assign ADC_OEB_B= 1;

adc_if adc_if_inst (
    .DATA_A(D_A[13:2]), 
    .DATA_B(D_B[13:2]), 
    .OTR_A(ADC_OTR_A), 
    .OTR_B(ADC_OTR_B), 
    .OEB_A(ADC_OEB_A), 
    .OEB_B(ADC_OEB_B), 
    .PDWN_A(ADC_PDWN_A), 
    .PDWN_B(ADC_PDWN_B), 
    .DCS(ADC_DCS), 
    .DFS(ADC_DFS), 
    .clk(clk_40), 
    .DATA_O_A(data_o_a)
);

wire audio_rdy;
wire audio_ack;
wire [17:0]fm_q;
wire [17:0]fm_i;
wire [23:0]audio_data;

ddc ddc_inst(
    .ADC_IN(data_o_a), 
    .ADC_CLK(clk_40), 
    .ENC_SW(sw_output), 
    .ENC_DIR(enc_dir), 
    .ENC_CNT(cnt_out), 
    .ENC_CLK(clk_div), 
    .OUT(data_filt), 
    .DATA_ACK(FX2_SLWR), 
    .CIC_CLK(clk_80), 
    .DATA_RDY(data_rdy),
    .CLK_RDY(fx2_clk_locked),
    .FLAG_F(FX2_FLAGB),
    .AUDIO_D_RDY(audio_rdy),
    .AUDIO_D_ACK(audio_ack),
    .OUT_I(fm_i),
    .OUT_Q(fm_q)
    );

fm_decode fm_dec_inst(
    .INPUT_Q(fm_q), 
    .INPUT_I(fm_i), 
    .CLK(clk_5), 
    .RDY(audio_rdy), 
    .ACK(audio_ack),
    .CLK_RDY(fx2_clk_locked),
    .OUTPUT(audio_data)
);

i2s_driver  
#(
    .BUS_WIDTH(24)) i2s_driver_inst
(
    .BCK(DAC_BCK), 
    .WS(DAC_WS), 
    .DATAI(DAC_DATAI), 
    .RANGE(DAC_PLL), 
    .DEEM(DAC_DEEM), 
    .LATCH(), 
    .DATA_L(audio_data), 
    .DATA_R(audio_data), 
    .CLK(clk_5)
);

//cic_compiler_v2_0 cic_inst (
    //.din(data_o_a), // input [11 : 0] din
    ////.nd(1'b1),
    //.clk(clk_80), // input clk
    //.dout(data_filt), // output [15 : 0] dout
    //.rdy(cic_data_rdy), // output rdy
    //.rfd() // output rfd
//);

//always @ (posedge clk_80) begin
    //if (cic_data_rdy) begin
        //data_rdy <= 1;
    //end else if (!FX2_SLWR) begin
        //data_rdy <= 0;
    //end
//end

`define EXT_FX2
//`define EXT_AUDIO_DAC

clk_wiz_v3_6 clk_inst  	                                   //PLL
(
    .CLK_IN1  (ADC_CLK),
    .CLK_OUT1 (clk_10),		
    .CLK_OUT2 (clk_5),
    .CLK_OUT3 (clk_80),
    .CLK_OUT4 (clk_40),
    //.RESET    (1'b0[>reset_n_in<]),
    .LOCKED   (fx2_clk_locked)
);

//fx2_loopback fx2_loopback_inst
//(
    //.clk_locked(fx2_clk_locked),
    //.data(FD)ADC_CLK,
    //.addr(FIFOADR),
    //.slrd(FX2_SLRD),
    //.slwr(FX2_SLWR),
    //.sloe(FX2_SLOE),
    //.flag_ef(FX2_FLAGA),
    //.flag_ff(FX2_FLAGB),
    //.clk(clk_10),
    //.ifclk(FX2_IFCLK),
    //.done(FX2_SLCS)
//);

`ifdef EXT_FX2

wire clk_output;

ODDR2 #(
    .DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1" 
    .INIT(1'b0),    // Sets initial state of the Q output to 1'b0 or 1'b1
    .SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
) ODDR2_inst (
    .Q(clk_output),   // 1-bit DDR output data
    .C0(!clk_5),   // 1-bit clock input
    .C1(clk_5),   // 1-bit clock input
    .CE(1'b1), // 1-bit clock enable input
    .D0(1'b1), // 1-bit data input (associated with C0)
    .D1(1'b0), // 1-bit data input (associated with C1)
    .R(1'b0),   // 1-bit reset input
    .S(1'b0)    // 1-bit set input
);

assign Ext[0] = FD[0];
assign Ext[1] = FIFOADR[1];
assign Ext[2] = FX2_SLRD;
assign Ext[3] = FX2_SLOE;
assign Ext[4] = FX2_SLWR;
assign Ext[5] = FX2_FLAGB;
assign Ext[6] = FIFOADR[0];
assign Ext[7] = clk_output;
`endif

//wire [15:0]data_l;
//wire [15:0]data_r;
//wire latch;
//reg [7:0]freq=2;
//wire enc_dir;
//wire cnt_out;

//always @ (negedge clk_div) begin
    //if (cnt_out) begin
        //if (enc_dir) begin
            //freq <= freq + 1;
            //if (freq > 253)
                //freq <= 253;
        //end
        //else begin
            //freq <= freq - 1;
            //if (freq < 1)
                //freq <= 1;
        //end
    //end
//end

//wave_gen wave_gen_inst (
    ////.DATA_L(data_l), 
    //.DATA_R(data_r), 
    //.CLK(clk_10), 
    //.FREQ(freq),
    ////.LATCH(1'b1)
    //.LATCH(FX2_FLAGB)
//);

fx2_if fx2_if_inst
(
    .clk_locked(fx2_clk_locked),
    .datai(data_filt),
    //.datai({4'h0,data_o_a}),
    //.datai({4'hf,12'h000}),
    //.datai(16'h0fff),
    .data(FD),
    .addr(FIFOADR),
    .slrd(FX2_SLRD),
    .slwr(FX2_SLWR),
    .sloe(FX2_SLOE),
    .flag_ef(FX2_FLAGA),
    .flag_ff(FX2_FLAGB),
    .clk(clk_5),
    .ifclk(FX2_IFCLK),
    .done(FX2_SLCS),
    .data_rdy(data_rdy)
);




`ifdef EXT_AUDIO_DAC
assign Ext[7:3] = 0;

wire clk_output;

ODDR2 #(
    .DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1" 
    .INIT(1'b0),    // Sets initial state of the Q output to 1'b0 or 1'b1
    .SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
) ODDR2_inst (
    .Q(clk_output),   // 1-bit DDR output data
    .C0(clk_5),   // 1-bit clock input
    .C1(!clk_5),   // 1-bit clock input
    .CE(1'b1), // 1-bit clock enable input
    .D0(1'b1), // 1-bit data input (associated with C0)
    .D1(1'b0), // 1-bit data input (associated with C1)
    .R(1'b0),   // 1-bit reset input
    .S(1'b0)    // 1-bit set input
);

assign Ext[0] = clk_output;
assign Ext[1] = DAC_WS;
assign Ext[2] = DAC_DATAI;
`endif


clk_div clk_div_inst
(
    .clk_in(clk_5),
    .clk_out(clk_div)
);

encoder encoder_inst
(
    .ina(ENC_A),
    .inb(ENC_B),
    .sw(ENC_SW),
    .clk(clk_div),
    .sw_out(sw_output),
    .dir(enc_dir),
    .cnt(cnt_out)
);

assign INIT_B = ~(cnt_out|~sw_output|ADC_OTR_A);
assign DEBUG_LED = FX2_FLAGB;
//assign DEBUG_LED = enc_dir;

endmodule
