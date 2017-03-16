`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Guanyu Li
// 
// Create Date: 2017/02/27 01:44:18
// Design Name: 
// Module Name: InsAnalyse
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


module parser(
    input [31:0] ins,
    output [5:0] op,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [4:0] shamt,
    output [5:0] funct,
    output [15:0] immediate16,
    output [25:0] immediate26
    );
    
    assign op = ins[31:26];
    assign rs = ins[25:21];
    assign rt = ins[20:16];
    assign rd = ins[15:11];
    assign shamt = ins[10:6];
    assign funct = ins[5:0];
    assign immediate16 = ins[15:0];
    assign immediate26 = ins[25:0];    
endmodule
