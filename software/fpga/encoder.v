`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:27:51 10/13/2015 
// Design Name: 
// Module Name:    encoder 
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
module encoder(
    input ina,
    input inb,
    input sw,
    input clk,
    output sw_out,
    output dir,
    output cnt
    );

    PULLUP PULLUP_ina (
        .O(ina)
    );

    PULLUP PULLUP_inb (
        .O(inb)
    );

    PULLUP PULLUP_sw (
        .O(sw)
    );

    //reg ina_lat0=0,inb_lat0=0;
    //reg ina_lat1=0,inb_lat1=0;
    //reg ina_lat2=0,inb_lat2=0;
    //reg [1:0]sw_lat=2'b0;
    //reg dir_out=0;
    //reg sw_reg=0;
    
    reg ina_lat0,inb_lat0;
    reg ina_lat1,inb_lat1;
    reg ina_lat2,inb_lat2;
    reg ina_lat3,inb_lat3;
    reg [3:0]sw_lat;
    reg dir_out;
    reg sw_reg;
    reg sw_reg_mon = 0;
    reg [1:0]state = 0;
    reg [1:0]sw_state = 0;
    reg cnt_out;

    parameter NORM = 0, INC = 1, DEC = 2;

    wire ina_lat_tp,ina_lat_tn;
    wire inb_lat_tp,inb_lat_tn;
    wire ina_lead,inb_lead;
    wire inb_lat_p,inb_lat_n;
    wire sw_lat_p;

    always @ (posedge clk) begin
        ina_lat0 <= ina;
        inb_lat0 <= inb;
        ina_lat1 <= ina_lat0;
        inb_lat1 <= inb_lat0;
        ina_lat2 <= ina_lat1;
        inb_lat2 <= inb_lat1;
        ina_lat3 <= ina_lat2;
        inb_lat3 <= inb_lat2;

        sw_lat[0] <= sw;
        sw_lat[1] <= sw_lat[0];
        sw_lat[2] <= sw_lat[1];
        sw_lat[3] <= sw_lat[2];

        //if (ina_lead)
            //dir_out <= 1;
        //else 
            //dir_out <= 0;

        if (sw_lat_p)
            sw_reg<= 1;
        else 
            sw_reg<= 0;

    end

    always @ (posedge clk)
        case (sw_state)
            0:
            begin
                if (sw_reg) begin
                    sw_state <= 1;
                end
            end
            1:
            begin
                sw_reg_mon <= !sw_reg_mon;
                sw_state <= 2;
            end
            2:
            begin
                if (!sw_reg) begin
                    sw_state <= 0;
                end
            end
        endcase



    always @ (posedge clk)
        case (state)
            NORM:
            begin
                cnt_out <= 0;
                if (ina_lead) 
                begin
                    state <= INC;
                    dir_out <= 1;
                end
                else if (inb_lead)
                begin
                    state <= DEC;
                    dir_out <= 0;
                end
            end
            INC:
            begin
                if (inb_lat_tp)
                begin
                    state <= NORM;
                    cnt_out <= 1;
                end
                else if (inb_lat_tn)
                begin
                    state <= NORM;
                    cnt_out <= 1;
                end
            end
            DEC:
            begin
                if (ina_lat_tp)
                begin
                    state <= NORM;
                    cnt_out <= 1;
                end
                else if (ina_lat_tn)
                begin
                    state <= NORM;
                    cnt_out <= 1;
                end
            end

        endcase


    assign ina_lat_tn = ~ina_lat0 & ina_lat1 & ina_lat2 & ina_lat3;
    assign ina_lat_tp = ina_lat0 & ina_lat1 & ina_lat2 & ~ina_lat3;
    assign inb_lat_tn = ~inb_lat0 & inb_lat1 & inb_lat2 & inb_lat3;
    assign inb_lat_tp = inb_lat0 & inb_lat1 & inb_lat2 & ~inb_lat3;
    assign ina_lead = (ina_lat_tp & inb_lat_n) | (ina_lat_tn & inb_lat_p);
    assign inb_lead = (inb_lat_tp & ina_lat_n) | (inb_lat_tn & ina_lat_p);
    assign inb_lat_p = inb_lat0 & inb_lat1 & inb_lat2 & inb_lat3;
    assign inb_lat_n = ~inb_lat0 & ~inb_lat1 & ~inb_lat2 & ~inb_lat3;
    assign ina_lat_p = ina_lat0 & ina_lat1 & ina_lat2 & ina_lat3;
    assign ina_lat_n = ~ina_lat0 & ~ina_lat1 & ~ina_lat2 & ~ina_lat3;

    assign sw_lat_p = sw_lat[0] & sw_lat[1] & sw_lat[2] & sw_lat[3];

    //assign cnt = ina_lead | inb_lead;
    assign cnt = cnt_out;
    assign dir = dir_out;
    assign sw_out = sw_reg_mon;

endmodule
