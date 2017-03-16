`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Junda Zhang
// 
// Create Date: 02/27/2017 02:51:40 PM
// Design Name: 
// Module Name: ram
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


module ram(
    input [9:0] address,
    input [31:0] Input,
    input str, sel, clk, ld, clr,
    output [31:0] Data
    );
    
    reg [31:0] mem [0:1023];
    
    assign Data = ld?mem[address]:32'b0;
    
    integer i; 
    initial begin    
            for (i = 0; i < 1024; i = i + 1)
            begin
                mem[i] <= 0;
            end
    end
    always @ (posedge clk)
    begin //mem store
        if (str && sel) begin
            mem[address] = Input;
        end
    end
    
endmodule
