`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2017 03:58:47 PM
// Design Name: 
// Module Name: IFID
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IFID(
	input lock, int_trigger, rst, clk,
	input [31:0] PC_plus, instrction, EPC, IE,
	input [1:0] which_int,
	output [31:0] PC_out, instrction_out, EPC_out, IE_out,
	output int_sig,
	output [1:0] int_num_out
    );
	register #(32) reg1(.din(PC_plus), .we(~lock), .rst(rst), .clk(clk), .dout(PC_out));
	register #(32) reg2(.din(instrction), .we(~lock), .rst(rst), .clk(clk), 
		.dout(instrction_out));
	register #(1) reg3(.din(int_trigger), .we(~lock), .rst(rst), .clk(clk), .dout(int_sig));
	register #(2) reg4(.din(which_int), .we(~lock), .rst(rst), .clk(clk), .dout(int_num_out));
	register #(32) reg5(.din(EPC), .we(~lock), .rst(rst), .clk(clk), .dout(EPC_out));
	register #(32) reg6(.din(IE), .we(~lock), .rst(rst), .clk(clk), .dout(IE_out));
endmodule
