`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:03:30 11/09/2015
// Design Name:   fx2_if
// Module Name:   D:/work/LCSDR/src/xilinx/main1/fx2_if_tb.v
// Project Name:  main1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fx2_if
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fx2_if_tb;

	// Inputs
	reg clk_locked;
	reg flag_ef;
	reg flag_ff;
	reg clk;

	// Outputs
	wire [1:0] addr;
	wire slrd;
	wire slwr;
	wire sloe;
	wire ifclk;
    wire done;

	// Bidirs
	wire [15:0] data;
    reg [15:0] data_in= 0;
    wire [15:0] data_out;

    parameter dcount = 0;
    integer j;

    assign data = (sloe)? 16'bz : data_in;
    assign data_out = data;

	// Instantiate the Unit Under Test (UUT)
	fx2_loopback uut (
		.clk_locked(clk_locked), 
		.data(data), 
		.addr(addr), 
		.slrd(slrd), 
		.slwr(slwr), 
		.sloe(sloe), 
		.flag_ef(flag_ef), 
		.flag_ff(flag_ff), 
		.clk(clk), 
		.ifclk(ifclk),
        .done(done)
	);

	initial begin
		// Initialize Inputs
		clk_locked = 0;
		flag_ef = 0;
		flag_ff = 0;
		clk = 0;
		flag_ff = 1; 

		// Wait 100 ns for global reset to finish
		#100;
        
        #10
        clk_locked = 1;
        #10
        wait (done == 1);

        #90
        flag_ef = 1;
        wait (sloe == 0);
        #10 data_in = 16'h0F01;
        wait (slrd == 0);
        wait (ifclk == 0);
        wait (ifclk == 1);
        #10 data_in = 16'h00F2;
        #10 flag_ef = 0; 
        //wait (ifclk == 1);
        //wait (ifclk == 0);
        //wait (ifclk == 1);
        //wait (ifclk == 0);

        //flag_ff = 1; 

        wait (slwr == 0);
        wait (slwr == 1);

        //#1 flag_ff = 0; 
        
        #100;

        flag_ef = 1;
        wait (sloe == 0);
        #10 data_in = 16'h0001;
        wait (slrd == 0);
        wait (ifclk == 0);
        wait (ifclk == 1);
        #10 data_in = 16'h0002;
        wait (ifclk == 0);
        wait (ifclk == 1);
        #10 data_in = 16'h0003;
        wait (ifclk == 0);
        wait (ifclk == 1);
        #10 data_in = 16'h0004;
        //wait (ifclk == 0);
        #10 flag_ef = 0; 

        wait (slwr == 0);
        wait (slwr == 1);

        #100;
        flag_ef = 1;
        wait (sloe == 0);
        #1 data_in = 16'h0000;
        wait (slrd == 0);
        wait (ifclk == 1);
        wait (ifclk == 0);
        for (j=1;j<=254;j=j+1)
        begin
            data_in = j;
            wait (ifclk == 1);
            wait (ifclk == 0);
        end
        data_in = 255;
        wait (ifclk == 1);
        #10 flag_ef = 0; 

        wait (slwr == 0);
        wait (slwr == 1);

	end

    parameter PERIOD = 1000/10;

    always begin
        clk = 1'b0;
        #(PERIOD/2) clk = 1'b1;
        #(PERIOD/2);
    end       

    reg [2:0]ep;
    always @ (*) begin
       case (addr) 
           2'b00: ep <= 2;
           2'b01: ep <= 4;
           2'b10: ep <= 6;
           2'b11: ep <= 8;
       endcase
    end
      
endmodule

