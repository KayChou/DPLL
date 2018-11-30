`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:02 11/29/2018 
// Design Name: 
// Module Name:    main 
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
module main(
	input CLK_100MHz,
	input signal,
	
	//output CLK_50KHZ,
	output CLK_500Hz
	//output pulse,
	//output cut_flag,
	//output pre_state,
	//output reg[1:0] offset = 0
    );

//wire CLK_50KHZ;
//wire CLK_500Hz;

wire pulse;
wire add_flag;
wire cut_flag;
wire CLK_500Hz;
reg offset;


clk_div To_1M (
    .clk(CLK_100MHz),
    .N(500),
	 .offset(0),
	 .reset(0),
    .clk_out(CLK_100KHZ)
    );


clk_div To_50K (
    .clk(CLK_100MHz),
    .N(1000),
	 .offset(0),
	 .reset(0),
    .clk_out(CLK_50KHZ)
    );

clk_div To_500 (
    .clk(CLK_100KHZ), 
    .N(100),
	 .offset(offset),
	 .reset(0),
    .clk_out(CLK_500Hz)
    );

over_sample signal_detect (
    .clk_50K(CLK_50KHZ), 
    .signal(signal), 
	 .pre_state(pre_state),
    .pulse(pulse)
    );

and_door And_1 (
    .a1(CLK_500Hz), 
    .a2(pulse),
    .And(cut_flag)
    );

and_door And_2 (
    .a1(~CLK_500Hz), 
    .a2(pulse), 
    .And(add_flag)
    );

always @(posedge CLK_50KHZ) begin
	if (add_flag) begin
		offset = 1;
	end
	if (cut_flag) begin
		offset = 2;
	end
	else begin
		offset = 0;
	end
end
endmodule
