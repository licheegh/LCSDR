`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:39:21 10/21/2015 
// Design Name: 
// Module Name:    audio 
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
module i2s_driver
    #(parameter BUS_WIDTH = 16)(
    output BCK,
    output WS,
    output DATAI,
    output RANGE,
    output DEEM,
    output LATCH,
    input [0:BUS_WIDTH-1] DATA_L,
    input [0:BUS_WIDTH-1] DATA_R,
    input CLK
    );

    // ODDR2: Output Double Data Rate Output Register with Set, Reset
    //        and Clock Enable.
    //        Spartan-6
    // Xilinx HDL Language Template, version 14.7

    ODDR2 #(
        .DDR_ALIGNMENT("NONE"), // Sets output alignment to "NONE", "C0" or "C1" 
        .INIT(1'b0),    // Sets initial state of the Q output to 1'b0 or 1'b1
        .SRTYPE("SYNC") // Specifies "SYNC" or "ASYNC" set/reset
    ) ODDR2_inst (
        .Q(BCK),   // 1-bit DDR output data
        .C0(!CLK),   // 1-bit clock input
        .C1(CLK),   // 1-bit clock input
        .CE(1'b1), // 1-bit clock enable input
        .D0(1'b1), // 1-bit data input (associated with C0)
        .D1(1'b0), // 1-bit data input (associated with C1)
        .R(1'b0),   // 1-bit reset input
        .S(1'b0)    // 1-bit set input
    );

					
    // 0: 16~50kHz
    // 1: 50~100kHz
    assign RANGE = 1;
    // 0: de-emphasis off
    assign DEEM = 1;

    reg [0:BUS_WIDTH*2-1]data_lat;
    reg [5:0]counter = 0;
    reg data_out;
    reg ws_out;
    reg lat_out;

    assign DATAI = data_out;
    assign WS = ws_out;
    assign LATCH = lat_out;

    always @ (posedge CLK) begin
        data_out <= data_lat[0];

        if (counter == BUS_WIDTH*2 + 1) begin
            data_lat <= {DATA_L,DATA_R};
            counter <= 0;
            ws_out <= 0;
            lat_out <= 0;
        end
        else if (counter == BUS_WIDTH) begin
            //data_lat <= data_lat<<1;
            data_lat <= data_lat;
            counter <= counter + 1;
            ws_out <= 1;
            lat_out <= 0;
        end
        else if (counter == BUS_WIDTH*2) begin
            data_lat <= data_lat<<1;
            counter <= counter + 1;
            ws_out <= ws_out;
            lat_out <= 1;
        end
        else begin
            data_lat <= data_lat<<1;
            counter <= counter + 1;
            ws_out <= ws_out;
            lat_out <= 0;
        end
    end


endmodule
