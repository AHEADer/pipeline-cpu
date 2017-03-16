`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Guanyu Li
// 
// Create Date: 2017/02/26 15:47:59
// Design Name: 
// Module Name: register
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


module register 
    #(parameter WIDTH = 32)
    (
    input [WIDTH-1:0] din,
    input we,
    input rst,
    input clk,
    output reg [WIDTH-1:0] dout
    );
    always @ (posedge clk)
    begin
        if (rst)
        begin
            dout <= 0;
        end
        else if (we)
        begin
            dout <= din;
        end
    end
endmodule
