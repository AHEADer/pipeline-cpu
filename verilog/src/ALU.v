`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Guanyu Li
// 
// Create Date: 2017/02/26 13:14:14
// Design Name: 
// Module Name: alu
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


module alu(
    input [31:0] x,
    input [31:0] y,
    input [3:0] op,
    output [31:0] result,
    output [31:0] result2,
    output equal
    );
    wire [63:0] product;
    
    assign product = x * y; 
    
    assign result = (op == 4'h0) ? x << y[4:0] : 32'hz;
    assign result = (op == 4'h1) ? {{32{x[31]}}, x} >>> y[4:0] : 32'hz;
    assign result = (op == 4'h2) ? x >> y[4:0] : 32'hz;
    assign result = (op == 4'h3) ? product[31:0] : 32'hz;
    assign result = (op == 4'h4) ? x / y : 32'hz;
    assign result = (op == 4'h5) ? x + y : 32'hz;
    assign result = (op == 4'h6) ? x - y : 32'hz;
    assign result = (op == 4'h7) ? x & y : 32'hz;
    assign result = (op == 4'h8) ? x | y : 32'hz;
    assign result = (op == 4'h9) ? x ^ y : 32'hz;
    assign result = (op == 4'ha) ? ~(x | y) : 32'hz;
    assign result = (op == 4'hb) ? $signed(x) < $signed(y) : 32'hz;
    assign result = (op == 4'hc) ? x < y : 32'hz;
    assign result = (op >= 4'hd) ? 32'h0 : 32'hz;
    
    assign result2 = (op == 4'h3) ? product[63:32] : 32'hz;
    assign result2 = (op == 4'h4) ? x % y : 32'hz;
    assign result2 = (op <= 2 || op >= 5) ? 32'h0 : 32'hz;
    
    assign equal = (x == y);
endmodule
