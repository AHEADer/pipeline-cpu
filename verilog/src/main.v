`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2017 12:36:00 PM
// Design Name: 
// Module Name: main
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


module main(
	input clk, rst, asy_rst, INT_1, INT_2, INT_3, sel,
	//output [31:0] out_inst,
	output ck_j,
	output [7:0] which_led,
	output [0:6] led_display
    );
	reg [31:0] circle;
	wire lock, clock, jump, jORrst, isnop, ck_judge, clk_slow;
	wire [31:0] rom_out, pc1_result, pc2_result, ram_data, ld_redir, lbu_data;
	wire [9:0] PC_in, PC_out, PC_jump;
	wire [7:0] lbu_data8;
    dclk d1(clk, clk_slow);
	//ID wire:
	wire [1:0] ID_b_ins_label, ID_memlabel, ID_j_label, ID_int_num;
	wire [3:0] ID_aluop;
	wire ID_OporFun, ID_We, ID_syscall, ID_shift, ID_shift_op_jud,
	 ID_lbu, ID_bgez, ID_jd1, ID_int_sig, ID_mfc0, ID_mtc0, ID_CPR0, ID_eret; //jd means judge
	wire [4:0] ID_R1_sel, ID_R2_sel, ID_RW;
	wire [31:0] ID_PC_out, ID_instr_index, ID_imm16_ext, ID_shamt_ext, ID_ist,
	 ID_R1_af_red, ID_R2_af_red, ID_jal_address, ID_CPR0_value, 
	  ID_tmp1, ID_tmp2, ID_Y_op, PC_jump32, PC_jump32_pre, ID_EPC, ID_IE;
	//ID wire end

	//WB wire:
	wire [4:0] WB_RW;
	wire [31:0] WB_Din, WB_sel1, WB_sel2, WB_PC;
	wire WB_we, WB_ld, WB_syscall, WB_jal;
	//WB wire end:

	//EX wire:
	wire EX_load, EX_We, EX_syscall_out, EX_lbu_out, EX_bgez_out, EX_equal,
	 EX_b, EX_eret, EX_mtc0, EX_int_tri, EX_CPR0, EX_mfc0;
	wire [4:0] EX_RW;
	wire [31:0] ex_redir, EX_jal_addr_out, EX_PC_out, EX_int_num_32,
	 EX_imm16_out, EX_X, EX_Y, EX_ram_write, EX_CPR0_value, EX_result;
	wire [1:0] EX_b_ins_out, EX_mem_out, EX_jump_out, EX_int_num;
	wire [3:0] EX_aluop_out;
	//EX wire end

	//MEM wire:
	wire MEM_We, MEM_syscall, MEM_jal, MEM_lbu;
	wire [4:0] MEM_RW;
	wire [1:0] MEM_mem_label;
	wire [31:0] mem_redir, MEM_PC, MEM_result, MEM_ram_write;
	//MEM wire end

	//interrupt wire:
	wire [31:0] EPC_value, IE_value;
	wire int_sig;
	wire [1:0] which_int;
	//interrupt wire end
	assign jORrst = jump|rst;
	register #(10) PC(.din(PC_in), .we(~lock), .rst(rst), .clk(clock), .dout(PC_out));
	rom rom_ist(.address(PC_out), .sel(1'b1), .data(rom_out));
	alu pc_c1(.x(32'b1), .y({22'b0, PC_out}), .op(4'b0101), .result(pc1_result));
	IFID ifid(.lock(lock), .int_trigger(int_sig), .rst(jORrst), .clk(clock),
	 .PC_plus(pc1_result), .instrction(rom_out), .EPC(EPC_value), 
	  .IE(IE_value), .which_int(which_int), .PC_out(ID_PC_out),
	   .instrction_out(ID_ist), .EPC_out(ID_EPC), .IE_out(ID_IE),
	    .int_sig(ID_int_sig), .int_num_out(ID_int_num) ); //rst diff!
	Controller con(ID_ist, ID_IE, ID_EPC, 
		ID_instr_index, ID_imm16_ext, ID_shamt_ext, ID_CPR0_value,
	ID_b_ins_label, ID_memlabel, ID_j_label,
	ID_aluop,
	ID_OporFun, ID_We, ID_syscall, ID_shift, ID_shift_op_jud, ID_lbu, ID_bgez, 
	ID_mfc0, ID_mtc0, ID_CPR0, ID_eret,
	ID_R1_sel, ID_R2_sel, ID_RW);

	interrupt intrpt(clock, rst, INT_1, INT_2, INT_3, EX_eret, EX_mtc0, EX_int_tri, EX_CPR0,
    EX_PC_out, EX_ram_write,
    EPC_value, IE_value,
    int_sig,
    which_int);

	//regfile wire
	wire [31:0] rgf_reg1, rgf_reg2, rgf_a0, rgf_v0, rgf_s0, rgf_s1;
	//regfile wire end

	regfile rgf(.read_reg1(ID_R1_sel), .read_reg2(ID_R2_sel), .write_reg(WB_RW),
     .write_data(WB_Din), .we(WB_we), .clk(~clock),.asy_rst(asy_rst), .reg1(rgf_reg1),
     .reg2(rgf_reg2), .a0(rgf_a0), .v0(rgf_v0), .s0(rgf_s0), .s1(rgf_s1));

	


	//redirect wire
	wire [1:0] Red_R1, Red_R2;
	//redirect wire end

	assign ID_R1_af_red = Red_R1[1]?(Red_R1[0]?ex_redir:mem_redir):
	(Red_R1[0]?ex_redir:rgf_reg1);
	assign ID_R2_af_red = Red_R2[1]?(Red_R2[0]?ex_redir:mem_redir):
	(Red_R2[0]?ex_redir:rgf_reg2);
	assign ID_jd1 = ID_shift & ID_shift_op_jud;
	assign ID_tmp1 = ID_OporFun?ID_imm16_ext:ID_R2_af_red;
	assign ID_tmp2 = ID_jd1?(ID_R2_af_red&32'h0000001f):ID_shamt_ext;//diff
	assign ID_Y_op = ID_shift?ID_tmp2:ID_tmp1;

	assign ID_jal_address = ID_OporFun?ID_instr_index:ID_R1_af_red;
	redirect red(ID_mtc0, EX_load, ID_OporFun, ID_shift, EX_We, MEM_We,
		ID_R2_sel, ID_R1_sel, EX_RW, MEM_RW, ID_memlabel, lock, Red_R1, Red_R2);
	assign isnop = lock?1'b1:1'b0;
	IDEX idex(ID_PC_out, ID_jal_address, ID_imm16_ext, ID_R1_af_red, 
		ID_Y_op, ID_R2_af_red, ID_CPR0_value, 
	ID_b_ins_label, ID_memlabel, ID_j_label, ID_int_num, 
	ID_We, ID_syscall, ID_lbu, ID_bgez, isnop, clock, jORrst, 
	ID_CPR0, ID_mfc0, ID_mtc0, ID_eret, ID_int_sig,
	ID_RW, ID_aluop,
	EX_PC_out, EX_jal_addr_out, EX_imm16_out, EX_X, EX_Y, EX_ram_write, EX_CPR0_value,
	EX_b_ins_out, EX_mem_out, EX_jump_out, EX_int_num,
	EX_We, EX_syscall_out, EX_lbu_out, EX_bgez_out,
	EX_CPR0, EX_mfc0, EX_mtc0, EX_eret, EX_int_tri,
	EX_RW,
	EX_aluop_out);

	alu pc_c2(.x(EX_PC_out), .y(EX_imm16_out), .op(4'b0101), .result(pc2_result));
	assign EX_load = EX_mem_out[1];
	alu main_cal(.x(EX_X), .y(EX_Y), .op(EX_aluop_out), .result(ex_redir),
    .equal(EX_equal));
    assign EX_b = EX_b_ins_out[1]&((~EX_b_ins_out[0])^(EX_bgez_out?ex_redir[0]:EX_equal));
    assign jump = EX_b|EX_jump_out[0]|EX_int_tri|EX_eret;
    assign PC_jump32_pre = EX_jump_out[0]?EX_jal_addr_out:(EX_b?pc2_result:EX_PC_out);
    assign EX_int_num_32 = {30'b0, EX_int_num};
    assign PC_jump32 = EX_eret?EPC_value:(EX_int_tri?EX_int_num_32:PC_jump32_pre);
    assign PC_jump = PC_jump32[9:0];
    assign EX_result = EX_mfc0?EX_CPR0_value:ex_redir;

    EXMEM exmem(EX_PC_out, EX_result, EX_ram_write,
	EX_We, EX_syscall_out, EX_lbu_out, EX_jump_out[1], rst, clock, 
	EX_RW,
	EX_mem_out,
	MEM_PC, MEM_result, MEM_ram_write,
	MEM_RW,
	MEM_We, MEM_syscall, MEM_lbu, MEM_jal,
	MEM_mem_label);

	ram main_ram(.address(MEM_result[11:2]), .Input(MEM_ram_write), .str(MEM_mem_label[0]), 
     .sel(1'b1), .clk(clock), .ld(MEM_mem_label[1]), .clr(1'b0), .Data(ram_data));
	assign ld_redir = MEM_lbu?(lbu_data):ram_data;
	assign lbu_data8 = MEM_result[0]?(MEM_result[1]?ram_data[31:24]:ram_data[15:8]):
	(MEM_result[1]?ram_data[23:16]:ram_data[7:0]);
	assign lbu_data = {24'b0, lbu_data8};
	assign mem_redir = MEM_mem_label[1]?ld_redir:MEM_result;

	MEMWB memwb(MEM_result, ld_redir, MEM_PC,
	MEM_mem_label[1], MEM_We, MEM_syscall, MEM_jal, clock, rst,
	MEM_RW,
	WB_sel1, WB_sel2, WB_PC,
	WB_ld, WB_we, WB_syscall, WB_jal,
	WB_RW);
	assign WB_Din = WB_jal?WB_PC:(WB_ld?WB_sel2:WB_sel1);
	assign PC_in = jump?PC_jump:pc1_result[9:0];
	assign clock = ck_judge?clk_slow:1'b0;
	//assign clock = ck_judge?clk:1'b0;
	assign ck_judge = ~(WB_syscall & (rgf_v0==32'ha));

	//display:
    parameter zero=7'b1000000,
              one=7'b1111001,
              two=7'b0100100,
              three=7'b0110000,
              four=7'b0011001,
              five=7'b0010010,
              six=7'b0000010,
              seven=7'b1111000,
              eight=7'b0000000,
              nine=7'b0010000,
              ten=7'b0001000,
              eleven=7'b0000011,
              twelve=7'b1000110,
              thirteen=7'b0100001,
              fourteen=7'b0000110,
              fifteen=7'b0001110;  
    reg [7:0] which;    //选择led灯
    reg [0:6] what=0;   //led灯显示
    reg [3:0] value=0;  //显示的数字的二进制值
    reg [20:0] cnt_scan=0;  //控制显示扫描的频率
    
    always @(posedge clock) begin
    	if (rst) begin
    		circle = 0;
    	end
    	circle = circle+1;
    end

    always @(posedge clk)    //这里是显示bcd码
    begin
    cnt_scan  = cnt_scan + 1;
    case(cnt_scan[18:16])
        3'b000:which <= 8'b11111110;
        3'b001:which <= 8'b11111101;
        3'b010:which <= 8'b11111011;
        3'b011:which <= 8'b11110111;
        3'b100:which <= 8'b11101111;
        3'b101:which <= 8'b11011111;
        3'b110:which <= 8'b10111111;
        3'b111:which <= 8'b01111111;
        default:which <= 8'b01111111;
    endcase
    
    case(which)
    8'b11111110:value<=sel?circle[3:0]:rgf_a0[3:0];
    8'b11111101:value<=sel?circle[7:4]:rgf_a0[7:4];
    8'b11111011:value<=sel?circle[11:8]:rgf_a0[11:8];
    8'b11110111:value<=sel?circle[15:12]:rgf_a0[15:12];
    8'b11101111:value<=rgf_a0[19:16];
    8'b11011111:value<=rgf_a0[23:20];
    8'b10111111:value<=rgf_a0[27:24];
    8'b1111111:value<=rgf_a0[31:28];
    endcase
    
    case(value)
    4'b0000: what <= zero;
    4'b0001: what <= one;
    4'b0010: what <= two;
    4'b0011: what <= three;
    4'b0100: what <= four;
    4'b0101: what <= five;
    4'b0110: what <= six;
    4'b0111: what <= seven;
    4'b1000: what <= eight;
    4'b1001: what <= nine;
    4'b1010: what <= ten;
    4'b1011: what <= eleven;
    4'b1100: what <= twelve;
    4'b1101: what <= thirteen;
    4'b1110: what <= fourteen;
    4'b1111: what <= fifteen;
    default: what <= zero;
    endcase                        
    end
    assign which_led = which;
    assign led_display = what;
    assign ck_j = ck_judge;
    //assign out_inst = rom_out;
endmodule

module dclk(
input cp,
output cpo
    );
    reg [0:31] cnt = 0;
    reg cpd=1;
    assign cpo = cpd;
    always @(posedge cp)
    begin
    cnt <= cnt+1'b1;
    if (cnt >= 499999)
    //if (cnt >= 1)
    begin
    cpd <= ~cpd;
    cnt <= 1'b0;
    end
    end
endmodule