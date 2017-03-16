`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2017 03:59:02 PM
// Design Name: 
// Module Name: IDEX
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


module IDEX(
	input [31:0] PC_plus, jal_addr, imm16_ext, X_op, Y_op, write_value, CPR0_value,
	input [1:0] b_ins_label, mem_label, jump, int_num,
	input we, syscall, lbu, bgez, nop, clk, rst, CPR0, mfc0, mtc0, eret, int_trigger,
	input [4:0] Rw,
	input [3:0] aluop,
	output [31:0] PC_out, jal_addr_out, imm16_out, X, Y, ram_write, CPR0_value_out,
	output [1:0] b_ins_out, mem_out, jump_out, int_num_out,
	output we_out, syscall_out, lbu_out, bgez_out, CPR0_out, mfc0_out, mtc0_out, eret_out,
	int_trigger_out,
	output [4:0] Rw_out,
	output [3:0] aluop_out
    );
	
	wire [31:0] PC_tmp, jal_addr_tmp, imm16_tmp, X_tmp, Y_tmp,
	 ram_write_tmp, CPR0_value_tmp;
	wire [1:0] b_ins_tmp, mem_tmp, jump_tmp, int_num_tmp;
	wire we_tmp, syscall_tmp, lbu_tmp, bgez_tmp, nop_out, CPR0_tmp,
	 mtc0_tmp, mfc0_tmp, eret_tmp, int_trigger_tmp;
	wire [4:0] Rw_tmp;
	wire [3:0] aluop_tmp;

	register #(32) reg1(.din(PC_plus), .we(1'b1), .rst(rst), .clk(clk), .dout(PC_tmp));
	register #(32) reg2(.din(jal_addr), .we(1'b1), .rst(rst), .clk(clk), .dout(jal_addr_tmp));
	register #(32) reg3(.din(imm16_ext), .we(1'b1), .rst(rst), .clk(clk), .dout(imm16_tmp));
	register #(2) reg4(.din(b_ins_label), .we(1'b1), .rst(rst), .clk(clk), .dout(b_ins_tmp));
	register #(32) reg5(.din(X_op), .we(1'b1), .rst(rst), .clk(clk), .dout(X_tmp));
	register #(32) reg6(.din(Y_op), .we(1'b1), .rst(rst), .clk(clk), .dout(Y_tmp));
	register #(32) reg7(.din(write_value), .we(1'b1), .rst(rst), .clk(clk), .dout(ram_write_tmp));
	register #(5) reg8(.din(Rw), .we(1'b1), .rst(rst), .clk(clk), .dout(Rw_tmp));
	register #(1) reg9(.din(we), .we(1'b1), .rst(rst), .clk(clk), .dout(we_tmp));
	register #(4) reg10(.din(aluop), .we(1'b1), .rst(rst), .clk(clk), .dout(aluop_tmp));
	register #(2) reg11(.din(mem_label), .we(1'b1), .rst(rst), .clk(clk), .dout(mem_tmp));
	register #(1) reg12(.din(syscall), .we(1'b1), .rst(rst), .clk(clk), .dout(syscall_tmp));
	register #(1) reg13(.din(lbu), .we(1'b1), .rst(rst), .clk(clk), .dout(lbu_tmp));
	register #(2) reg14(.din(jump), .we(1'b1), .rst(rst), .clk(clk), .dout(jump_tmp));
	register #(1) reg15(.din(bgez), .we(1'b1), .rst(rst), .clk(clk), .dout(bgez_tmp));
	register #(1) reg16(.din(nop), .we(1'b1), .rst(rst), .clk(clk), .dout(nop_out));
	register #(1) reg17(.din(CPR0), .we(1'b1), .rst(rst), .clk(clk), .dout(CPR0_tmp));
	register #(1) reg18(.din(mtc0), .we(1'b1), .rst(rst), .clk(clk), .dout(mtc0_tmp));
	register #(1) reg19(.din(mfc0), .we(1'b1), .rst(rst), .clk(clk), .dout(mfc0_tmp));
	register #(1) reg20(.din(eret), .we(1'b1), .rst(rst), .clk(clk), .dout(eret_tmp));
	register #(32) reg21(.din(CPR0_value), .we(1'b1), .rst(rst), .clk(clk),
	 .dout(CPR0_value_tmp));
	register #(1) reg22(.din(int_trigger), .we(1'b1), .rst(rst), .clk(clk),
	 .dout(int_trigger_tmp));
	register #(2) reg23(.din(int_num), .we(1'b1), .rst(rst), .clk(clk), .dout(int_num_tmp));



	assign PC_out = nop_out?32'b0:PC_tmp;
	assign jal_addr_out = nop_out?32'b0:jal_addr_tmp;
	assign imm16_out = nop_out?32'b0:imm16_tmp;
	assign b_ins_out = nop_out?2'b0:b_ins_tmp;
	assign X = nop_out?32'b0:X_tmp;
	assign Y = nop_out?32'b0:Y_tmp;
	assign ram_write = nop_out?32'b0:ram_write_tmp;
	assign Rw_out = nop_out?5'b0:Rw_tmp;
	assign we_out = nop_out?1'b0:we_tmp;
	assign aluop_out = nop_out?4'b0:aluop_tmp;
	assign mem_out = nop_out?2'b0:mem_tmp;
	assign syscall_out = nop_out?1'b0:syscall_tmp;
	assign lbu_out = nop_out?1'b0:lbu_tmp;
	assign jump_out = nop_out?2'b0:jump_tmp;
	assign bgez_out = nop_out?1'b0:bgez_tmp;
	assign CPR0_out = nop_out?1'b0:CPR0_tmp;
	assign CPR0_value_out = nop_out?32'b0:CPR0_value_tmp;
	assign mfc0_out = nop_out?1'b0:mfc0_tmp;
	assign mtc0_out = nop_out?1'b0:mtc0_tmp;
	assign eret_out = nop_out?1'b0:eret_tmp;
	assign int_trigger_out = nop_out?1'b0:int_trigger_tmp;
	assign int_num_out = nop_out?2'b0:int_num_tmp;
endmodule
