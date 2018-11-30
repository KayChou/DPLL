`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:32:12 11/30/2018 
// Design Name: 
// Module Name:    over_sample 
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
module over_sample(
	input clk_50K,
	input signal,
	output reg pulse = 0
    );
reg pre_state = 0;

always @(posedge clk_50K) begin

	if (signal > 0 && pre_state == 0) begin
		pulse = 1;
	end
	else begin
		pulse = 0;
	end

	if (signal > 0) begin
		pre_state = 1;
	end
	else begin
		pre_state = 0;
	end
	
end

endmodule
