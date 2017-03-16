`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Junda Zhang
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


module rom(
    input [9:0] address,
    input sel,
    output [31:0] data
    );
    reg [31:0] mem [0:1023];
    assign data = sel?mem[address]:32'b0;
    
    initial begin
        $readmemh("/home/david/tmp/pipeline_int.hex",mem);
    end  
endmodule
