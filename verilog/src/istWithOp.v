`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2017 01:00:14 PM
// Design Name: 
// Module Name: istWithOp
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


module istWithOp(
	input i31, i30, i29, i28, i27, i26,
	output j, j2, op3, op2, op1, op0, rw, rw2, eq, eq2, regwrite, LBU
    );
	assign j = ~i31 & ~i30 & ~i29 & ~i28 & i27;
	assign j2 = ~i26;
	assign op3 = (~i31 & ~i30 & ~i29 & ~i28 & ~i27 & i26) |
	 (i28 & i27 & i26) | (~i31 & ~i30 & i29 & ~i28 & i27) |
	  (i29 & i28 & i26) | (i30 & i28 & i26) | (i31 & i28 & i26);
	assign op2 = (~i27 & ~i26) | (~i31 & ~i30 & ~i29 & i28 & ~i27) |
	 (~i30 & i29 & ~i28 & i26) | (i30 & ~i28 & ~i27) | (i31 & ~i30 & ~i28 & i26);
	assign op1 = (~i31 & ~i30 & ~i29 & ~i27 & i26) |
	 (~i31 & i28 & ~i26) | (i28 & i27 & ~i26) |
	  (~i31 & ~i30 & i29 & i27 & ~i26) |
	   (i29 & i28 & ~i26) | (i30 & i28 & ~i26);
	assign op0 = (~i28 & ~i27) | (~i31 & ~i30 & i29 & ~i28 & ~i26) |
	 (i29 & ~i27 & ~i26) | (i30 & ~i27 & ~i26) | (i31 & ~i27 & ~i26) |
	  (i31 & ~i30 & ~i28 & i26);
	assign rw = (i31 & ~i30 & ~i28 & i27 & i26) |
	 (i31 & ~i30 & ~i29 & i28 & ~i27 & ~i26);
	assign rw2 = i29;
	assign eq = (~i31 & ~i30 & ~i29 & ~i27 & i26) |
	 (~i31 & ~i30 & ~i29 & i28 & ~i27);
	assign eq2 = ~i26;
	assign regwrite = (~i31 & ~i30 & i29 & ~i28) |
	 (~i31 & ~i30 & i29 & ~i27) | (i31 & ~i30 & ~i29 & ~i28 & i27 & i26) |
	  (i31 & ~i30 & ~i29 & i28 & ~i27 & ~i26);
	assign LBU = (i31 & ~i30 & ~i29 & i28 & ~i27 & ~i26);
endmodule
