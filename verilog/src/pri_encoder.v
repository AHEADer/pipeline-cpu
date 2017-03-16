`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2017 04:57:28 PM
// Design Name: 
// Module Name: pri_encoder
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


module pri_encoder (
binary_out , //  2 bit binary output
encoder_in , //  4-bit input 
enable       //  Enable for the encoder
);

output [1:0] binary_out ;
input  enable ; 
input [3:0] encoder_in ; 

wire [1:0] binary_out ;
      
assign  binary_out  = (!enable) ? 0 : (
    (encoder_in[3]) ? 3 : 
    (encoder_in[2]) ? 2 : 
    (encoder_in[1]) ? 1 : 0); 

endmodule 