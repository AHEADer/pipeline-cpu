`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2017 04:00:58 PM
// Design Name: 
// Module Name: EXMEM
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


module EXMEM(
	input [31:0] PC, result, write_value,
	input we, syscall, lbu, jal, rst, clk, 
	input [4:0] Rw,
	input [1:0] mem_label,
	output [31:0] PC_out, result_out, ram_write,
	output [4:0] Rw_out,
	output we_out, syscall_out, lbu_out, jal_out,
	output [1:0] mem_out 
    );

	register #(32) reg1(.din(PC), .we(1'b1), .rst(rst), .clk(clk), .dout(PC_out));
	register #(32) reg2(.din(result), .we(1'b1), .rst(rst), .clk(clk), .dout(result_out));
	register #(32) reg3(.din(write_value), .we(1'b1), .rst(rst), .clk(clk), .dout(ram_write));
	register #(5) reg4(.din(Rw), .we(1'b1), .rst(rst), .clk(clk), .dout(Rw_out));
	register #(1) reg5(.din(we), .we(1'b1), .rst(rst), .clk(clk), .dout(we_out));
	register #(2) reg6(.din(mem_label), .we(1'b1), .rst(rst), .clk(clk), .dout(mem_out));
	register #(1) reg7(.din(syscall), .we(1'b1), .rst(rst), .clk(clk), .dout(syscall_out));
	register #(1) reg8(.din(lbu), .we(1'b1), .rst(rst), .clk(clk), .dout(lbu_out));
	register #(1) reg9(.din(jal), .we(1'b1), .rst(rst), .clk(clk), .dout(jal_out));
endmodule
