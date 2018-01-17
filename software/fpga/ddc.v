`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:47:09 11/28/2015 
// Design Name: 
// Module Name:    ddc 
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
module ddc(
    input signed [11:0] ADC_IN,
    input ADC_CLK,
    input ENC_SW,
    input ENC_DIR,
    input ENC_CNT,
    input ENC_CLK,
    output [15:0] OUT,
    input DATA_ACK,
    input CIC_CLK,
    output DATA_RDY,
    input CLK_RDY,
    input FLAG_F,
    output AUDIO_D_RDY,
    input AUDIO_D_ACK,
    output reg [17:0]OUT_I,
    output reg [17:0]OUT_Q
    );
    // step = step_freq*2^20/fclk
    // for 0.1 Meg Step:
    // step = 0.1 * 2**20 / 40
    parameter STEP = 262*4;
    parameter STEP_FINE = 262/4;

    // 40*2622/(2**20)*10 = 1M
    reg [19:0]freq=2622*10;
    reg signed [27:0]mul_res_i_h;
    reg signed [27:0]mul_res_q_h;
    reg signed [17:0]mul_res_i;
    reg signed [17:0]mul_res_q;

    wire signed [15:0]sine;
    wire signed [15:0]cosine;

    wire cic_rdy_i;
    wire cic_rdy_q;
    wire cic_rfd_i;
    wire cic_rfd_q;

    wire [17:0]cic_data_i;
    wire [17:0]cic_data_q;
    wire [17:0]fir_data_1_i;
    wire [17:0]fir_data_1_q;
    wire [33:0]fir_data_2_i;
    wire [33:0]fir_data_2_q;

    wire fir_1_i_rfd;
    wire fir_2_i_rfd;
    wire fir_1_q_rfd;
    wire fir_2_q_rfd;

    wire fir_1_i_rdy;
    wire fir_2_i_rdy;
    wire fir_1_q_rdy;
    wire fir_2_q_rdy;

    reg [2:0]send_data_step=0;
    reg [2:0]send_audio_step=0;
    reg [15:0]send_data;
    reg [15:0]send_data_q;
    reg [12:0]step = STEP;
    reg data_rdy=0;
    reg audio_rdy=0;

    initial begin
        mul_res_i_h <= 0;
        mul_res_q_h <= 0;
        mul_res_i <= 0;
        mul_res_q <= 0;
    end

    always @ (posedge ENC_CLK) begin
        if (ENC_SW)
            step <= STEP_FINE;
        else
            step <= STEP;
    end


    always @ (negedge ENC_CLK) begin
        if (ENC_CNT) begin
            if (ENC_DIR) begin
                freq <= freq + step;
                //20M*(2**20)/40M
                if (freq > 524288)
                    freq <= 524288;
            end
            else begin
                freq <= freq - step;
                if (freq < STEP*2)
                    freq <= STEP*2;
            end
        end
    end

    // f = fclk*freq/(2^freq_width)
    dds_compiler_v4_0 dds_inst(
        .clk(ADC_CLK), // input clk
        .we(1'b1), // input we
        .data(freq), // input [18 : 0] data
        .cosine(cosine), // output [15 : 0] cosine
        .sine(sine) // output [15 : 0] sine
    );

    always @ (negedge ADC_CLK) begin
        mul_res_i_h <= cosine * ADC_IN;
        mul_res_q_h <= sine * ADC_IN;
        mul_res_i <= {mul_res_i_h[27],mul_res_i_h[25:09]};
        mul_res_q <= {mul_res_q_h[27],mul_res_q_h[25:09]};
    end

    // tested: gain = 1
    cic_compiler_v2_0 cic_inst_i (
        .din(mul_res_i), // input [15 : 0] din
        //.nd(1'b1),
        .clk(!CIC_CLK), // input clk
        .dout(cic_data_i), // output [15 : 0] dout
        .rdy(cic_rdy_i), // output rdy
        .rfd(cic_rfd_i), // output rfd
        .sclr(!CLK_RDY)
    );

    // tested: gain = 0.5
    fir_compiler_v5_0_first fir_inst_1_i(
        .sclr(!CLK_RDY), // input sclr
        .clk(!CIC_CLK), // input clk
        .nd(cic_rdy_i), // input nd
        .rfd(fir_1_i_rfd), // output rfd
        .rdy(fir_1_i_rdy), // output rdy
        .din(cic_data_i), // input [23 : 0] din
        .dout(fir_data_1_i)); // output [23 : 0] dout

    // tested: gain = 31570
    fir_compiler_v5_0_second fir_inst_2_i(
        .sclr(!CLK_RDY), // input sclr
        .clk(!CIC_CLK), // input clk
        .nd(fir_1_i_rdy), // input nd
        .rfd(fir_2_i_rfd), // output rfd
        .rdy(fir_2_i_rdy), // output rdy
        .din(fir_data_1_i), // input [23 : 0] din
        .dout(fir_data_2_i)); // output [15 : 0] dout

    cic_compiler_v2_0 cic_inst_q (
        .din(mul_res_q), // input [15 : 0] din
        //.nd(1'b1),
        .clk(!CIC_CLK), // input clk
        .dout(cic_data_q), // output [15 : 0] dout
        .rdy(cic_rdy_q), // output rdy
        .rfd(cic_rfd_q), // output rfd
        .sclr(!CLK_RDY)
    );

    fir_compiler_v5_0_first fir_qnst_1_q(
        .sclr(!CLK_RDY), // input sclr
        .clk(!CIC_CLK), // input clk
        .nd(cic_rdy_q), // input nd
        .rfd(fir_1_q_rfd), // output rfd
        .rdy(fir_1_q_rdy), // output rdy
        .din(cic_data_q), // input [23 : 0] din
        .dout(fir_data_1_q)); // output [23 : 0] dout

    fir_compiler_v5_0_second fir_qnst_2_q(
        .sclr(!CLK_RDY), // input sclr
        .clk(!CIC_CLK), // input clk
        .nd(fir_1_q_rdy), // input nd
        .rfd(fir_2_q_rfd), // output rfd
        .rdy(fir_2_q_rdy), // output rdy
        .din(fir_data_1_q), // input [23 : 0] din
        .dout(fir_data_2_q)); // output [15 : 0] dout


    assign DATA_RDY = data_rdy;
    assign OUT = send_data;
    always @ (negedge CIC_CLK) begin
        case (send_data_step)
            0:
            begin
                if (fir_2_i_rdy) begin
                    data_rdy <= 1;
                    send_data_step <= 1;
                    send_data <= {fir_data_2_i[33],fir_data_2_i[30:16]};
                    send_data_q <= {fir_data_2_q[33],fir_data_2_q[30:16]};
                end
            end
            1: 
            begin
                if (!DATA_ACK) begin
                    send_data_step <= 2;
                    data_rdy <=0;
                end
                else if (!FLAG_F) begin
                    send_data_step <= 0;
                    data_rdy <=0;
                end
            end
            2:
            begin
                if (DATA_ACK) begin
                    send_data <= send_data_q;
                    send_data_step <= 3;
                    data_rdy <= 1;
                end
            end
            3: 
            begin
                if ((!DATA_ACK) | (!FLAG_F)) begin
                    send_data_step <= 0;
                    data_rdy <=0;
                end
            end
        endcase
    end

    assign AUDIO_D_RDY = audio_rdy;
    always @ (negedge CIC_CLK) begin
        case (send_audio_step)
            0:
            begin
                if (fir_2_i_rdy) begin
                    send_audio_step <= 1;
                    audio_rdy <= 1;
                    OUT_I <= {fir_data_2_i[33],fir_data_2_i[30:14]};
                    OUT_Q <= {fir_data_2_q[33],fir_data_2_q[30:14]};
                end
            end
            1:
            begin
                if (AUDIO_D_ACK) begin
                    send_audio_step <= 0;
                    audio_rdy <= 0;
                end
            end

        endcase
    end


endmodule
