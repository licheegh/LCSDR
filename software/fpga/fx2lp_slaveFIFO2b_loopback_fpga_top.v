module fx2_slaveFIFO_loopback(
    clk_locked,
    fdata,  
    faddr,  
    slrd,   
    slwr,   
    sloe,              
    flag_ff,  
    flag_ef, 
    done,	
    clk,    
    clk_out
);

input clk_locked;
inout [15:0]fdata;
input flag_ef;
input flag_ff;
input clk;

output clk_out; 
output [1:0]faddr;
output sloe;
output slwr;
output slrd;
output done;

reg slrd_n;
reg slwr_n;
reg sloe_n;

reg [15:0] fifo_data_in;
wire [15:0] fifo_data_out;
reg [15:0] data_out;

reg done_d;
reg [3:0]wait_s;

//wire clk;
//wire clk_out_90;
//wire clk_out_180;
//wire clk_out_270;
reg [1:0]faddr_n;

parameter [1:0] loop_back_idle       = 2'd0;
parameter [1:0] loop_back_read       = 2'd1;
parameter [1:0] loop_back_wait_flag_ff = 2'd2;
parameter [1:0] loop_back_write      = 2'd3;

reg [1:0]current_loop_back_state;
reg [1:0]next_loop_back_state;

wire fifo_full;
wire fifo_empty;
wire fifo_push;
wire fifo_pop;


ODDR2 oddr2_inst
(
    .D0(1'b1),
    .D1(1'b0),
    .CE(1'b1),
    .C0(clk),  
    .C1(!clk), 
    .R (1'b0),
    .S (1'b0),
    .Q (clk_out)
);

assign slwr = slwr_n;
assign slrd = slrd_n;
assign sloe = sloe_n;
assign faddr = faddr_n;

assign fdata = data_out;
assign done = done_d;


always@(posedge clk, negedge clk_locked) begin
    if(clk_locked == 1'b0)begin
        done_d <= 1'b0;
    end else if(wait_s == 4'd10) begin
        done_d <= 1'b1;

    end
end	

always@(posedge clk, negedge clk_locked) begin
    if(clk_locked == 1'b0)begin
        wait_s <= 4'd0;
    end else if(wait_s < 4'd10) begin
        wait_s <= wait_s + 1'b1;

    end
end	



always@(*)begin
    if((current_loop_back_state == loop_back_idle) | (current_loop_back_state == loop_back_read))begin
        faddr_n = 2'b00;
    end else begin
        faddr_n = 2'b10;
    end
end	



//read control signal generation
//always@(negedge clk)begin
//always@(posedge clk)begin
always@(*)begin
    if((current_loop_back_state == loop_back_read) & (flag_ef == 1'b1))begin
        slrd_n = 1'b0;
        sloe_n = 1'b0;
    end else begin
        slrd_n = 1'b1;
        sloe_n = 1'b1;
    end
end	

assign fifo_push = ((slrd_n == 1'b0) & (fifo_full == 1'b0));

always@(*)begin
    if(slrd_n == 1'b0)
        fifo_data_in = fdata;
    else
        fifo_data_in = "00000000";

end	

//write control signal generation
always@(*)begin
    if((current_loop_back_state == loop_back_write) & (flag_ff == 1'b1) & (fifo_empty == 1'b0))
        slwr_n <= 1'b0;
    else
        slwr_n <= 1'b1;
end

assign fifo_pop = ((slwr_n == 1'b0) & (fifo_empty == 1'b0));

//loopback mode state machine 
always@(posedge clk, negedge clk_locked) begin
    if(clk_locked == 1'b0)
        current_loop_back_state <= loop_back_idle;
    else
        current_loop_back_state <= next_loop_back_state;
end

//LoopBack mode state machine combo
always@(*) begin
    next_loop_back_state = current_loop_back_state;
    case(current_loop_back_state)
        loop_back_idle:begin
            if(flag_ef == 1'b1)
                next_loop_back_state = loop_back_read;
            else
                next_loop_back_state = loop_back_idle;
        end
        loop_back_read:begin
            if(flag_ef == 1'b0)
                next_loop_back_state = loop_back_wait_flag_ff;
            else
                next_loop_back_state = loop_back_read;
        end
        loop_back_wait_flag_ff:begin
            if(flag_ff == 1'b1)
                next_loop_back_state = loop_back_write;
            else 
                next_loop_back_state = loop_back_wait_flag_ff;
        end
        loop_back_write:begin
            if((flag_ff == 1'b0) | (fifo_empty == 1'b1))
                next_loop_back_state = loop_back_idle;
            else 
                next_loop_back_state = loop_back_write;
        end
        default: 
            next_loop_back_state = loop_back_idle;
    endcase		
end

always@(*)begin
    if(slwr_n == 1'b1)
        data_out = 16'dz;
    else
        data_out = fifo_data_out;
end

//fifo instantiation for loopback
fifo_512x8 fifo_inst
(
    .din	     (fifo_data_in),	
    .write_busy (fifo_push),
    .fifo_full  (fifo_full), 
    .dout	     (fifo_data_out),
    .read_busy  (fifo_pop),
    .fifo_empty (fifo_empty),
    .fifo_clk   (clk),
    .reset_   (clk_locked),
    .fifo_flush (current_loop_back_state == loop_back_idle)
);


endmodule
