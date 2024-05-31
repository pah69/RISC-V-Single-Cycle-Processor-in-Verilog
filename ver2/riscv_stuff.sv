`timescale 1ns/1ps

module InstrMem_test();
	reg t_clk, t_rst;
	reg [31:0] addr_stim;
	wire [31:0] instr_out;
	reg [31:0] from_pc_stim;
	wire [31:0] next_pc_out;
	reg [31:0] pc_in_stim;
	wire [31:0] pc_out_out;
	reg [31:0] command_stim;
	wire [3:0] ctrl_out; 
	reg regwrite_stim;
	reg [4:0] rs1_stim, rs2_stim, rd_stim;
	reg [31:0] wr_data_stim;
	wire [31:0] rs1_data_out, rs2_data_out;
	reg [31:0] data1_stim, data2_stim, imm_stim;
	reg [3:0] ALU_control_stim;
	wire [31:0] ALU_result_out;
	wire [31:0] imm_out;
	wire regwrite_out;
	wire [4:0] rs1_out, rs2_out, rd_out;
	
	initial //initialize clock
	begin
		t_clk = 0;
		forever t_clk = #5 ~t_clk; //clock switches value every 5ns -> period = 10ns
	end;
	
	InstrMem dut_1(.clk(t_clk), .rst_n(t_rst), .addr(addr_stim), .instr(instr_out)); //instr mem x
	pc_plus4 dut_2(.from_pc(from_pc_stim), .next_pc(next_pc_out)); //pc x
	pc dut_3(.clk(t_clk), .rst_n(t_rst), .pc_in(pc_in_stim), .pc_out(pc_out_out)); //pc x
	decoder dut_4(.command(command_stim), .ALUcontrol_out(ctrl_out)); //decoder (alu ctrl) x
	RegFile dut_5(.clk(t_clk), .rst_n(t_rst), .RegWrite(regwrite_stim), .rs1(rs1_stim), .rs2(rs2_stim), .rd(rd_stim), .wr_data(wr_data_stim), .rs1_data(rs1_data_out), .rs2_data(rs2_data_out)); //register set control
	alu dut_6(.data1(data1_stim), .data2(data2_stim), .ALU_control(ALU_control_stim), .imm(imm_stim), .ALU_result(ALU_result_out)); //alu.exe
	ImmGen dut7(.instr(command_stim), .ImmOut(imm_out)); //immediate generator x
	registerCtrl dut8(.clk(t_clk), .rst_n(t_rst), .instr(command_stim), .RegWrite(regwrite_out), .rs1(rs1_out), .rs2(rs2_out), .rd(rd_out)); //register ctrl x
	
	initial
	begin //regwrite temporarily set to 1
	t_rst = 0; #1 t_rst = 1; #1 
	pc_in_stim = 0; //assign PC
	//1 clock = 10ns
	from_pc_stim = pc_out_out; //PC = PC + 4
	addr_stim = pc_out_out; #2 //fetch instruction 
	command_stim = instr_out; #2 //fetch register, immediate, alu control
	regwrite_stim = regwrite_out; rs1_stim = rs1_out; rs2_stim = rs2_out; rd_stim = rd_out;  #2 //register file address fetch
	ALU_control_stim = ctrl_out; data1_stim = rs1_data_out; data2_stim = rs2_data_out; imm_stim = imm_out; #2 //alu execute
	wr_data_stim = ALU_result_out; //writeback
	pc_in_stim = next_pc_out; #2 //assign PC
	
	#10
	
	$stop;	
	end
	// for some reason simulation cannot detect data stims.
	
endmodule