`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2017 01:54:27 PM
// Design Name: 
// Module Name: interrupt
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


module interrupt(
    input clk, rst, IR1_in, IR2_in, IR3_in, ex_eret, ex_mtc0, ex_int_tri, reg_jud,
    input [31:0] EX_PC_next, EX_rt,
    output [31:0] EPC_value, IE_value,
    output int_sig,
    output [1:0] which_int
    );
    wire one, two, three, rst1, rst2, rst3;
    wire q_a1, q_b1, q_c1, d_a2, d_b2, d_c2;
    wire reg_one, reg_two, reg_three, int_ins;
    wire [3:0] pri_in;
    wire [1:0] lock_value;
    assign pri_in = {(~reg_three&three),(~reg_two&two),(~reg_one&one),1'b1};
    assign d_a2 = ~rst1 & (one | q_a1);
    assign d_b2 = ~rst2 & (two | q_b1);
    assign d_c2 = ~rst3 & (three | q_c1);
    /*
    data  , // Data Input
    clk    , // Clock Input
    reset , // Reset input 
    q    
    */
    dff_async_reset dff_a1(1'b1, IR1_in, one, q_a1);
    dff_async_reset dff_a2(d_a2, clk, 1'b0, one);
    dff_async_reset dff_b1(1'b1, IR2_in, two, q_b1);
    dff_async_reset dff_b2(d_b2, clk, 1'b0, two);
    dff_async_reset dff_c1(1'b1, IR3_in, three, q_c1);
    dff_async_reset dff_c2(d_c2, clk, 1'b0, three);
    pri_encoder pri(.binary_out(which_int), .enable(1'b1), .encoder_in(pri_in));
    register #(1) reg1((lock_value[0]|lock_value[1]), 1'b1, rst, clk, reg_one);
    register #(1) reg2(lock_value[1], 1'b1, rst, clk, reg_two);
    register #(1) reg3((lock_value[0]&lock_value[1]), 1'b1, rst, clk, reg_three);
    register #(2) cur_int(which_int, (int_sig|ex_eret), rst, clk, lock_value);
    assign rst1 = lock_value[0]&~lock_value[1]&int_sig;
    assign rst2 = ~lock_value[0]&lock_value[1]&int_sig;
    assign rst3 = lock_value[0]&lock_value[1]&int_sig;
    assign int_ins = (~reg_three&three)|(~reg_two&two)|(~reg_one&one);
    assign int_sig = (which_int[0]|which_int[1]) & (~IE_value & int_ins);
    wire epc_jud, IE_out;
    wire [31:0] EPC_in;
    assign epc_jud = ex_mtc0 & reg_jud;
    assign EPC_in = epc_jud?EX_rt:EX_PC_next-1;
    register #(32) EPC_Cache(EPC_in, (ex_int_tri|(reg_jud&ex_mtc0)), rst, clk, EPC_value);
    register #(1) IE_reg(EX_rt[0], (ex_int_tri|(~reg_jud&ex_mtc0)), rst, clk, IE_out);
    assign IE_value = {31'b0, IE_out};
endmodule
