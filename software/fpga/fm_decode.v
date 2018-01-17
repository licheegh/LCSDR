`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:08:16 12/02/2015 
// Design Name: 
// Module Name:    fm_decode 
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
module fm_decode(
    input [17:0] INPUT_Q,
    input [17:0] INPUT_I,
    input CLK,
    input RDY,
    output reg ACK,
    input CLK_RDY,
    output [23:0]OUTPUT

    );

    reg [3:0]state = 0;
    reg signed [17:0]q_lat=0;
    reg signed [17:0]i_lat=0;
    reg signed [17:0]q_lat_pr=0;
    reg signed [17:0]i_lat_pr=0;
    reg signed [17:0]q_lat_diff=0;
    reg signed [17:0]i_lat_diff=0;
    reg signed [35:0]temp1=0;
    reg signed [23:0]temp2=0;
    wire [35:0]audio;
    wire [37:0]audio_dec;
    //reg div_rdy=0;
    wire div_rdy;
    reg div_ce=0;
    wire fir_rdy;

    reg newdata = 0;


    // high radix
    div_gen_v3_0 div_inst(
        .clk(!CLK), // input clk
        .sclr(!CLK_RDY), // input sclr
        .nd(newdata), // input nd
        .rdy(div_rdy), // output rdy
        //.ce(1'b1),
        //.rfd(div_rfd), // output rfd
        .dividend(temp1), // input [35: 0] dividend
        .divisor(temp2), // input [23: 0] divisor
        //.divisor({temp2[17],14'b0,temp2[16:0]}), // input [17 : 0] divisor
        .quotient(audio) // output [35: 0] quotient
    );
    //div_gen_v3_0 div_inst(
        //.clk(!CLK), // input clk
        //.sclr(!CLK_RDY), // input sclr
        //.ce(div_ce),
        ////.rfd(div_rfd), // output rfd
        ////.dividend({temp1[31],temp1[14:0]}), // input [17 : 0] dividend
        ////.divisor({temp2[31],temp2[14:0]}), // input [17 : 0] divisor
        //.dividend(temp1), // input [17 : 0] dividend
        //.divisor(temp2), // input [17 : 0] divisor
        //.quotient(audio) // output [17 : 0] quotient
   
			
    // gain: 117375 about 2**17
    fir_compiler_v5_0_audio audio_fir(
        .sclr(!CLK_RDY), // input sclr
        .clk(CLK), // input clk
        .nd(div_rdy), // input nd
        //.rfd(fir_rfd), // output rfd
        .rdy(fir_rdy), // output rdy
        .din({audio[23],audio[22:6]}), // input [18: 0] din
        //.din({temp1[31],temp1[23:7]}), // input [24 : 0] din
        .dout(audio_dec)); // output [42 : 0] dout

    assign OUTPUT = {audio_dec[37],audio_dec[36:14]};

    always @ (posedge CLK) begin
        case (state)
            0: 
            begin
                ACK <= 0;
                //div_rdy <= 0;
                if (RDY) begin
                    q_lat <= INPUT_Q;
                    i_lat <= INPUT_I;
                    state <= 1;
                end
                newdata <= 0;
            end
            1:
            begin
                ACK <= 1;
                q_lat_diff <= (q_lat-q_lat_pr);
                i_lat_diff <= (i_lat-i_lat_pr);
                state <= 2;
            end
            2:
            begin
                //temp1 <= i_lat*q_lat_diff - q_lat*i_lat_diff;
                temp1 <= i_lat*q_lat_diff;
                temp2 <= (q_lat*q_lat)/(2**8);
                i_lat_pr <= i_lat;
                q_lat_pr <= q_lat;
                state <= 3;
            end
            3:
            begin
                //temp2 <= (q_lat*q_lat)/(4) +(i_lat*i_lat)/(4);
                temp1 <= temp1 - q_lat*i_lat_diff;
                temp2 <= temp2 + (i_lat*i_lat)/(2**8);
                state <= 4;
                //if (fir_rdy) begin
                    //state <= 4;
                //end
            end
            4:
            begin
                temp1 <= temp1*(2**8);
                if (temp2 == 0) begin
                    temp2 <= 1;
                end
                div_ce <= 1;
                state <= 5;
            end
            5:
            begin
                newdata <= 1;
                div_ce <= 0;
                //div_rdy <= 1;
                state <= 0;
            end
        endcase
    end
    endmodule
