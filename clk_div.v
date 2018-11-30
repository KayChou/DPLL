`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:45 11/29/2018 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div(
	input clk,
	input wire[31:0] N,
	input wire[1:0] offset,
	input wire[31:0] reset,
	output reg clk_out = 0
    );
	 
reg[31:0] cnt = 32'b0000 ;

always @(posedge clk) begin

	if (reset) begin
		cnt = 0;
		clk_out = 0;
	end
	
	case(offset)
		1: cnt = cnt + 5;
		2: if(cnt > 5) begin 
				cnt = cnt - 5;
			end
		default: cnt = cnt + 1;
	endcase
	
	if (cnt >= N) begin
		cnt = 0;
		clk_out = ~clk_out;
	end

end

endmodule
