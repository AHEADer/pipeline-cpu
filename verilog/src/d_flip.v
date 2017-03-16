`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/12/2017 04:44:52 PM
// Design Name: 
// Module Name: d_flip
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


//-----------------------------------------------------
// Design Name : dff_async_reset
// File Name   : dff_async_reset.v
// Function    : D flip-flop async reset
// Coder       : Deepak Kumar Tala
//-----------------------------------------------------
module dff_async_reset (
data  , // Data Input
clk    , // Clock Input
reset , // Reset input 
q         // Q output
);
//-----------Input Ports---------------
input data, clk, reset ; 

//-----------Output Ports---------------
output q;

//------------Internal Variables--------
reg q;

//-------------Code Starts Here---------
initial
begin
 	q <= 0;	
end

always @ (posedge clk or posedge reset)
if (reset) begin
  q <= 1'b0;
end  else begin
  q <= data;
end

endmodule //End Of Module dff_async_reset