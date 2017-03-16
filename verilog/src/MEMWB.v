`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2017 04:01:32 PM
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(
	input [31:0] sel1, sel2, PC_jal,
	input ld, we, syscall, jal, clk, rst,
	input [4:0] Rw,
	output [31:0] sel1_out, sel2_out, PC_jal_out,
	output ld_out, we_out, syscall_out, jal_out,
	output [4:0] Rw_out
    );
	register #(32) reg1(.din(sel1), .we(1'b1), .rst(rst), .clk(clk), .dout(sel1_out));
	register #(32) reg2(.din(sel2), .we(1'b1), .rst(rst), .clk(clk), .dout(sel2_out));
	register #(1)  reg3(.din(ld), .we(1'b1), .rst(rst), .clk(clk), .dout(ld_out));
	register #(1)  reg4(.din(we), .we(1'b1), .rst(rst), .clk(clk), .dout(we_out));
	register #(1)  reg5(.din(syscall), .we(1'b1), .rst(rst), .clk(clk), .dout(syscall_out));
	register #(1)  reg6(.din(jal), .we(1'b1), .rst(rst), .clk(clk), .dout(jal_out));
	register #(5)  reg7(.din(Rw), .we(1'b1), .rst(rst), .clk(clk), .dout(Rw_out));
	register #(32) reg8(.din(PC_jal), .we(1'b1), .rst(rst), .clk(clk), .dout(PC_jal_out));
endmodule
