`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2017 12:58:57 PM
// Design Name: 
// Module Name: ist
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


module ist(
	input [5:0] fun, op, //Funct&Opcode's 5-0 bits
	output shift, syscall, Opcode, regwrite, memwrite, memread, lbu, bgez,
	output [3:0] aluop,
	output [1:0] Branch, jump
    );
	wire [3:0] fun_alu, op_alu;
	wire funj, fun_regwrite, fun_shift;
	wire op_j, op_j2, op_rw, op_rw2, op_eq, op_eq2, op_regwrite, op_LBU, syscall_sp;
	wire isop, jud_syscall;

	istWithFun Fun1(.i5(fun[5]), .i4(fun[4]), .i3(fun[3]), .i2(fun[2]),
	 .i1(fun[1]), .i0(fun[0]), .op3(fun_alu[3]), .op2(fun_alu[2]),
	  .op1(fun_alu[1]), .op0(fun_alu[0]), .j(funj), .regwrite(fun_regwrite),
	   .shift(fun_shift));
	istWithOp Op1(.i31(op[5]), .i30(op[4]), .i29(op[3]), .i28(op[2]), .i27(op[1]),
	 .i26(op[0]), .j(op_j), .j2(op_j2), .op3(op_alu[3]), .op2(op_alu[2]),
	  .op1(op_alu[1]), .op0(op_alu[0]), .rw(op_rw), .rw2(op_rw2), .eq(op_eq),
	   .eq2(op_eq2), .regwrite(op_regwrite), .LBU(op_LBU));

	assign isop = op[5] | op[4] | op[3] | op[2] | op[1] | op[0]; //judge instruction is Op or Fun
	assign syscall_sp = ~fun[5] & ~fun[4] & fun[3] & fun[2] & ~fun[1] & ~fun[0];
	assign shift = ~isop & fun_shift;
	assign syscall = ~isop & syscall_sp;
	assign aluop = isop?op_alu:fun_alu;
	assign Opcode = isop ^ op_eq;
	assign regwrite = isop?op_regwrite:fun_regwrite;
	assign memwrite = op_rw & op_rw2;
	assign memread = op_rw & ~op_rw2;
	wire tmp1;
	assign tmp1 = op_j & ~op_j2;
	assign jump[1] = tmp1;
	assign jump[0] = isop?op_j:funj;
	assign lbu = memread & op_LBU;
	assign bgez = op_eq & ~op[2] & op[0];
	assign Branch[0] = op_eq2;
	assign Branch[1] = op_eq;
endmodule
