`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2017 12:58:34 PM
// Design Name: 
// Module Name: Controller
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


module Controller(
	input [31:0] instruction, IE_value, EPC_value,
	output [31:0] instr_index, imm16_ext, shamt_ext, CPR_value,
	output [1:0] b_ins_label, memlabel, j_label,
	output [3:0] aluop,
	output OporFun, We, syscall, shift, shift_op_jud, lbu, bgez, mfc0, mtc0, CPR0, eret,
	output [4:0] R1_sel, R2_sel, RW
    );
	/*
	op:31-26
	rs:25-21
	rt:20-16
	rd:15-11
	shamt:10-6
	funct:5-0
	imm16:15-0
	imm26:25-0
	*/
	wire [5:0] op, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] imm16;
    wire [25:0] imm26;

    wire ist_shift, ist_syscall, ist_Opcode, ist_regwrite,
     ist_memwrite, ist_memread, ist_lbu, ist_bgez;
	wire [3:0] ist_aluop;
	wire [1:0] ist_Branch, ist_jump;

	parser par(.ins(instruction), .op(op), .rs(rs), .rt(rt), .rd(rd),
     .shamt(shamt), .funct(funct), .immediate16(imm16), .immediate26(imm26));
	ist ist_con(.fun(funct), .op(op), .shift(ist_shift), .syscall(ist_syscall),
	 .Opcode(ist_Opcode), .regwrite(ist_regwrite), .memwrite(ist_memwrite),
	  .memread(ist_memread), .lbu(ist_lbu), .bgez(ist_bgez), .aluop(ist_aluop),
	   .Branch(ist_Branch), .jump(ist_jump));

	wire nop, jal;//some tunnel in logisim
	assign nop = instruction==32'b0;
	/*
	 lbu, bgez,
	output [5:0] R1_sel, R2_sel, RW
	*/
	assign instr_index = {6'b0 ,imm26};
	assign imm16_ext = {{16{imm16[15]}},imm16};
	assign shamt_ext = {27'b0 ,shamt};
	assign b_ins_label = ist_Branch;
	assign memlabel[0] = ist_memwrite;
	assign memlabel[1] = ist_memread;
	assign j_label = ist_jump;
	assign jal = ist_jump[1];
	assign aluop = ist_aluop;
	assign OporFun = ist_Opcode;
	assign We = (~nop & (jal?1'b1:ist_regwrite)) | mfc0;
	assign syscall = ist_syscall;
	assign shift = ist_shift;
	assign shift_op_jud = ~(shamt[4] | shamt[3] | shamt[2] | shamt[1] | shamt[0]);
	assign lbu = ist_lbu;
	assign bgez = ist_bgez;
	assign R1_sel = ist_shift?rt:rs;
	assign R2_sel = ist_shift?(shift_op_jud?rs:rt):rt;
	assign RW = jal?5'h1f:(ist_Opcode?rt:rd);
	assign mfc0 = (rs==5'b0) & (op==6'h10);
	assign mtc0 = (rs==5'h4) & (op==6'h10);
	assign CPR_value = rd[0]?EPC_value:IE_value;
	assign CPR0 = rd[0];
	assign eret = ((op==6'h10) & rs[4]) & (funct==6'h18);
endmodule
