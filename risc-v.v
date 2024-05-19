module cpu(
	input clk,
	input rst_n,
	input [31:0] data_in,
	output[31:0] data_out,
);
// important data used

reg [31:0] res;


// IF - instruction fetch || contains PC, MUX, IMEM

// ID - instruction decode || IMEM - Reg[]

// Execute(EX) - ALU || ALU

// MEM - Memory Access || DMEM

// WB - Write back to register || DMEM back to PC

endmodule : cpu

// Program counter
module PC(
	input clk
	input rst_n
	input [31:0] PC_in,
	input [1:0] sel,
	output [31:0] PC_out


);

always @(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		PC_out <= PC_in;
	end
	else begin 
		case(sel)
		1'b0: PC_out = PC_in;
		1'b1: PC_out = PC_in + 4; // Next clock cycle +4 byte = 32 bits
	end
end
endmodule : pc


// Instruction Memory
module InstrMem (
	input clk,    // Clock
	input clk_en, // Clock Enable
	input rst_n,  // Asynchronous reset active low
);
reg [31:0] Addr_IMem
always @(Addr_IMem) begin
	PC_out = Addr_IMem;
end

endmodule : InstrMem




// REG file
reg [31:0] reg_file [0:31]; // 32 regs in RegFile block
integer i;
generate
	genvar i;
	for(i = 0; i < 32; i = i + 1) begin
		
	end
endgenerate




// Data Memory



// COntrol
module control(
 	input clk,    // Clock
 	input clk_en, // Clock Enable
 	input rst_n,  // Asynchronous reset active low
 );

input ImmSel;
input RegWEn;
input ALUSel;
input Bsel;


endmodule : control