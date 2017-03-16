`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2017 01:00:28 PM
// Design Name: 
// Module Name: istWithFun
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


module istWithFun(
	input i5, i4, i3, i2, i1, i0,
	output op3, op2, op1, op0, j, regwrite, shift
    );
	assign op3 = i2 & i0 | i3;
	assign op2 = (i5 & ~i4 & ~i3 & ~i2 & ~i1) |
	 (i5 & ~i3 & ~i0);
	assign op1 = (i1 & ~i0) | (i2 & ~i0) | (i5 & i1);
	assign op0 = (~i2 & i0) | i3 | (i5 & ~i1 & ~i0);
	assign j = ~i5 & ~i4 & i3 & ~i2 & ~i1 & ~i0;
	assign regwrite = (~i4 & ~i3 & ~i2 & ~i0) |
	 (~i5 & ~i4 & ~i3 & ~i2 & i1) | (~i4 & ~i3 & i1 & ~i0) |
	  (i5 & ~i4 & ~i3 & ~i1) | (i5 & ~i4 & i3 & ~i2 & i1);
	assign shift = (~i5 & ~i4 & ~i3 & ~i2 & ~i0) |
	 (~i5 & ~i4 & ~i3 & ~i2 & i1) | (~i5 & ~i4 & ~i3 & i1 & ~i0);
endmodule
