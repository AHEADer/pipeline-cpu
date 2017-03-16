`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2017 11:21:46 PM
// Design Name: 
// Module Name: redirect
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


module redirect(
	input ID_mtc0, EX_load, ID_OporFun, ID_shift, EX_We, MEM_We, 
	input [4:0] ID_R2, ID_R1, EX_RW, MEM_RW,
	input [1:0] ID_mem,
	output lock, 
	output [1:0] Red_R1, Red_R2
    );
	wire EX_R1_Red, EX_R2_Red, MEM_R1_Red, MEM_R2_Red;
	wire tmp1, sw, tmp2;
	assign EX_R1_Red = ~EX_load & (ID_R1==EX_RW) & EX_We;
	assign tmp1 = ((ID_R2==EX_RW)&tmp2)|ID_mtc0;
	assign tmp2 = ~(ID_shift|ID_OporFun);
	assign EX_R2_Red = ~EX_load & tmp1 & EX_We;
	assign lock = EX_load & ((tmp1|(ID_R1==EX_RW))&EX_We);
	assign MEM_R1_Red = (MEM_RW==ID_R1)&MEM_We;
	assign sw = ID_mem[0];
	assign MEM_R2_Red = ((tmp2|sw)&(MEM_RW==ID_R2))&MEM_We;
	assign Red_R1[0] = EX_R1_Red;
	assign Red_R1[1] = MEM_R1_Red;
	assign Red_R2[0] = EX_R2_Red;
	assign Red_R2[1] = MEM_R2_Red;
endmodule
