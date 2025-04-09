`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Percentages: 
//    Benjamin Feuerborn (33%)
//    Jacob Missbrenner (33%)
//    Nomar Vazquez (33%)
//////////////////////////////////////////////////////////////////////////////////

module Datapath(
    input Clk,                  // Clk input signal, taken from test bench
    input Rst,                  // Reset for program counter
    output reg [31:0] PC_out,   // PC output, current instruction val
    output reg [31:0] WB_out    // WB output, output from instruction operation
    );
    
//////////////////////////////////////////////////////////////////////////////////
// THE HELL HOLE (wires for connecting)
//////////////////////////////////////////////////////////////////////////////////
    initial begin
        PC_out <= 32'b0;
        WB_out <= 32'b0;
    end
    
    // Instruction Fetch
    wire [31:0] mux_branch_out;
    wire [31:0] pc_src;
    wire [31:0] pc_out;
    wire [31:0] pc_add_out;
    wire [31:0] instruction;
    
    // Register IF/ID
    wire [31:0] pc_next_if_id;
    wire [31:0] instruction_if_id;
    
    // Instruction Decode
    wire [31:0] shift_left_out;
    wire [31:0] read_data_1;
    wire [31:0] read_data_2;
    wire [31:0] immediate;
    wire [31:0] pc_jal_out;
    wire [4:0] write_register_out;
    wire [31:0] write_data_out;
    
    wire [3:0] alu_op;
    wire mat;
    wire mab;
    wire reg_dst;
    wire reg_write;
    wire mem_write;
    wire mem_read;
    wire [1:0] whb;
    wire mem_to_reg;
    wire branch;
    wire [1:0] jump;
    wire jal;
    
    // Register ID/EX
    wire [31:0] pc_next_id_ex;
    wire [31:0] instruction_id_ex;
    wire [31:0] read_data_1_id_ex;
    wire [31:0] read_data_2_id_ex;
    wire [31:0] immediate_id_ex;
    
    wire [3:0] alu_op_id_ex;
    wire mat_id_ex;
    wire mab_id_ex;
    wire reg_dst_id_ex;
    wire reg_write_id_ex;
    wire mem_write_id_ex;
    wire mem_read_id_ex;
    wire [1:0] whb_id_ex;
    wire mem_to_reg_id_ex;
    wire branch_id_ex;
    
    // Execute
    wire [31:0] immediate_shifted;
    wire [31:0] pc_branch;
    wire [31:0] alu_top_out;
    wire [31:0] alu_bottom_out;
    wire [31:0] alu_result;
    wire zero;
    wire [4:0] reg_dest;
    
    // Register EX/MEM
    wire [31:0] pc_branch_ex_mem;
    wire [31:0] alu_result_ex_mem;
    wire zero_ex_mem;
    wire [4:0] reg_dest_ex_mem;
    wire [31:0] write_data_ex_mem;
    
    wire reg_write_ex_mem;
    wire mem_write_ex_mem;
    wire mem_read_ex_mem;
    wire [1:0] whb_ex_mem;
    wire mem_to_reg_ex_mem;
    wire branch_ex_mem;
    
    // Memory
    wire branch_select;
    wire [31:0] read_data;
    
    // Register MEM/WB
    wire [31:0] alu_result_mem_wb;
    wire [31:0] read_data_mem_wb;
    wire [4:0] reg_dest_mem_wb;
    
    wire reg_write_mem_wb;
    wire mem_to_reg_mem_wb;
    
    // Write Back
    wire [31:0] write_back;
    
    always @(posedge Clk) begin
        PC_out <= pc_out;
        WB_out <= write_data_out;
    end
    
//////////////////////////////////////////////////////////////////////////////////
// Instruction Fetch (IF)
//////////////////////////////////////////////////////////////////////////////////
    Mux32Bit2To1 mux_branch_pc(
        .select(branch_select),                     // 1-bit input
        .in_A(pc_add_out),                          // 32-bit input
        .in_B(pc_branch_ex_mem),                    // 32-bit input
        .out(mux_branch_out)                        // 32-bit output
    );
    
    Mux32Bit3To1 mux_jump_pc(
        .select(jump),                                      // 1-bit input
        .in_A(mux_branch_out),                              // 32-bit input
        .in_B({pc_next_if_id[31:28], shift_left_out[27:0]}),     // 32-bit input
        .in_C(read_data_1),                                 // 32-bit input
        .out(pc_src)                                        // 32-bit output
    );
    
    ProgramCounter pc(
        .Clk(Clk),                                  // 1-bit input
        .Reset(Rst),                                // 1-bit input
        .Address(pc_src),                           // 32-bit input
        .PCResult(pc_out)                           // 32-bit output
    );
    
    PCAdder pc_adder(
        .PCResult(pc_out),                          // 32-bit input
        .PCAddResult(pc_add_out)                    // 32-bit output
    );
    
    InstructionMemory imu(
        .Address(pc_out),                           // 32-bit input
        .Instruction(instruction)                   // 32-bit output
    );


//////////////////////////////////////////////////////////////////////////////////
// Register IF/ID
//////////////////////////////////////////////////////////////////////////////////
    Register_IF_ID register_if_id(
        .Clk(Clk),                                  // 1-bit input
        
        .PC_in(pc_add_out),                         // 32-bit input
        .instruction_in(instruction),               // 32-bit input
        
        .PC_out(pc_next_if_id),                     // 32-bit output
        .instruction_out(instruction_if_id)         // 32-bit output
    );


//////////////////////////////////////////////////////////////////////////////////
// Instruction Decode (ID)
//////////////////////////////////////////////////////////////////////////////////
    ShiftLeft shift_left_2_pc(
        .in(instruction_if_id),                     // 32-bit input
        .out(shift_left_out)                        // 32-bit output
    );
    
    RegisterFile register_file(
        .Clk(Clk),// 1-bit input
        
        .ReadRegister1(instruction_if_id[25:21]),   // 5-bit input
        .ReadRegister2(instruction_if_id[20:16]),   // 5-bit input
        
        .WriteRegister(write_register_out),         // 5-bit input
        .WriteData(write_data_out),                 // 32-bit input
        .RegWrite(reg_write_mem_wb),                // 1-bit input
        
        .ReadData1(read_data_1),                    // 32-bit output
        .ReadData2(read_data_2)                     // 32-bit output
    );
    
    SignExtension sign_extended(
        .in(instruction_if_id[15:0]),               // 16-bit input
        .out(immediate)                             // 32-bit output
    );
    
    Decoder controller(
        .opcode(instruction_if_id[31:26]),          // 6-bit input
        .rt(instruction_if_id[20:16]),              // 5-bit input
        .funct(instruction_if_id[5:0]),             // 6-bit input
        
        .AluOp(alu_op),                             // 4-bit output
        .MAT(mat),                                  // 1-bit output
        .MAB(mab),                                  // 1-bit output
        .RegDst(reg_dst),                           // 1-bit output
        .RegWrite(reg_write),                       // 1-bit output
        .MemWrite(mem_write),                       // 1-bit output
        .MemRead(mem_read),                         // 1-bit output
        .WHB(whb),                                  // 2-bit output
        .MemtoReg(mem_to_reg),                      // 1-bit output
        .Branch(branch),                            // 1-bit output
        .Jump(jump),                                // 2-bit output
        .JAL(jal)                                   // 1-bit output
    );
    
    Mux5Bit2To1 mux_write_register(
        .select(jal),                               // 1-bit input
        .in_A(reg_dest_mem_wb),                     // 5-bit input
        .in_B(5'd31),                               // 5-bit input
        .out(write_register_out)                    // 5-bit output
    );
    
    PCAdder pc_adder_jal(
        .PCResult(pc_next_if_id),                   // 32-bit input
        .PCAddResult(pc_jal_out)                    // 32-bit output
    );
    
    Mux32Bit2To1 mux_write_data(
        .select(jal),                               // 1-bit input
        .in_A(write_back),                          // 32-bit input
        .in_B(pc_jal_out),                          // 32-bit input
        .out(write_data_out)                        // 32-bit output
    );


//////////////////////////////////////////////////////////////////////////////////
// Register ID/EX
//////////////////////////////////////////////////////////////////////////////////
    Register_ID_EX register_id_ex(
        .Clk(Clk),                                  // 1-bit input
        
        .pc_next_in(pc_next_if_id),                 // 32-bit input
        .instruction_in(instruction_if_id),         // 32-bit input
        .read_data_1_in(read_data_1),               // 32-bit input
        .read_data_2_in(read_data_2),               // 32-bit input
        .immediate_in(immediate),                   // 32-bit input
        
        .pc_next_out(pc_next_id_ex),                // 32-bit output
        .instruction_out(instruction_id_ex),        // 32-bit output
        .read_data_1_out(read_data_1_id_ex),        // 32-bit output
        .read_data_2_out(read_data_2_id_ex),        // 32-bit output
        .immediate_out(immediate_id_ex),            // 32-bit output
        
        .AluOp_in(alu_op),                          // 4-bit input
        .MAT_in(mat),                               // 1-bit input
        .MAB_in(mab),                               // 1-bit input
        .RegDst_in(reg_dst),                        // 1-bit input
        .RegWrite_in(reg_write),                    // 1-bit input
        .MemWrite_in(mem_write),                    // 1-bit input
        .MemRead_in(mem_read),                      // 1-bit input
        .WHB_in(whb),                               // 2-bit input
        .MemtoReg_in(mem_to_reg),                   // 1-bit input
        .Branch_in(branch),                         // 1-bit input
        
        .AluOp_out(alu_op_id_ex),                   // 4-bit output
        .MAT_out(mat_id_ex),                        // 1-bit output
        .MAB_out(mab_id_ex),                        // 1-bit output
        .RegDst_out(reg_dst_id_ex),                 // 1-bit output
        .RegWrite_out(reg_write_id_ex),             // 1-bit output
        .MemWrite_out(mem_write_id_ex),             // 1-bit output
        .MemRead_out(mem_read_id_ex),               // 1-bit output
        .WHB_out(whb_id_ex),                        // 2-bit output
        .MemtoReg_out(mem_to_reg_id_ex),                // 1-bit output
        .Branch_out(branch_id_ex)                   // 1-bit output
    );


//////////////////////////////////////////////////////////////////////////////////
// Execute (EX)
//////////////////////////////////////////////////////////////////////////////////
    ShiftLeft shift_left_2_branch(
        .in(immediate_id_ex),                       // 32-bit input
        .out(immediate_shifted)                     // 32-bit output
    );
    
    Adder adder_branch(
        .input1(pc_next_id_ex),                     // 32-bit input
        .input2(immediate_shifted),                 // 32-bit input
        .out(pc_branch)                             // 32-bit output
    );
    
    Mux32Bit2To1 mux_alu_top(
        .select(mat_id_ex),                         // 1-bit input
        .in_A(read_data_1_id_ex),                   // 32-bit input
        .in_B({27'b0, instruction_id_ex[10:6]}),    // 32-bit input
        .out(alu_top_out)                           // 32-bit output
    );
    
    Mux32Bit2To1 mux_alu_bottom(
        .select(mab_id_ex),                         // 1-bit input
        .in_A(read_data_2_id_ex),                   // 32-bit input
        .in_B(immediate_id_ex),                     // 32-bit input
        .out(alu_bottom_out)                        // 32-bit output
    );
    
    ALU32Bit alu(
        .ALUControl(alu_op_id_ex),                  // 4-bit input
        .A(alu_top_out),                            // 32-bit input
        .B(alu_bottom_out),                         // 32-bit input
        .ALUResult(alu_result),                     // 32-bit input
        .Zero(zero)                                 // 1-bit input
    );
    
    Mux5Bit2To1 mux_reg_destination(
        .select(reg_dst_id_ex),                     // 1-bit input
        .in_A(instruction_id_ex[20:16]),            // 5-bit input
        .in_B(instruction_id_ex[15:11]),            // 5-bit input
        .out(reg_dest)                              // 5-bit output
    );


//////////////////////////////////////////////////////////////////////////////////
// Register EX/MEM
//////////////////////////////////////////////////////////////////////////////////
    Register_EX_MEM register_ex_mem(
        .Clk(Clk),                                  // 1-bit input
        
        .pc_branch_in(pc_branch),                   // 32-bit input
        .alu_result_in(alu_result),                 // 32-bit input
        .zero_in(zero),                             // 1-bit input
        .reg_dest_in(reg_dest),                     // 5-bit input
        .write_data_in(read_data_2_id_ex),          // 32-bit input
        
        .pc_branch_out(pc_branch_ex_mem),           // 32-bit output
        .alu_result_out(alu_result_ex_mem),         // 32-bit output
        .zero_out(zero_ex_mem),                     // 1-bit output
        .reg_dest_out(reg_dest_ex_mem),             // 5-bit output
        .write_data_out(write_data_ex_mem),         // 32-bit output
        
        .RegWrite_in(reg_write_id_ex),              // 1-bit input
        .MemWrite_in(mem_write_id_ex),              // 1-bit input
        .MemRead_in(mem_read_id_ex),                // 1-bit input
        .WHB_in(whb_id_ex),                         // 2-bit input
        .MemtoReg_in(mem_to_reg_id_ex),             // 1-bit input
        .Branch_in(branch_id_ex),                   // 1-bit input
        
        .RegWrite_out(reg_write_ex_mem),            // 1-bit output
        .MemWrite_out(mem_write_ex_mem),            // 1-bit output
        .MemRead_out(mem_read_ex_mem),              // 1-bit output
        .WHB_out(whb_ex_mem),                       // 2-bit output
        .MemtoReg_out(mem_to_reg_ex_mem),               // 1-bit output
        .Branch_out(branch_ex_mem)                  // 1-bit output
    );


//////////////////////////////////////////////////////////////////////////////////
// Memory (MEM)
//////////////////////////////////////////////////////////////////////////////////
    AndGate and_gate(
        .in_A(zero_ex_mem),                         // 1-bit input
        .in_B(branch_ex_mem),                       // 1-bit input
        .out(branch_select)                         // 1-bit output
    );
    
    DataMemory data_memory(
        .Clk(Clk),                                  // 1-bit input
        .Address(alu_result_ex_mem),                // 32-bit input
        .WriteData(write_data_ex_mem),              // 32-bit input
        .MemWrite(mem_write_ex_mem),                // 1-bit input
        .MemRead(mem_read_ex_mem),                  // 1-bit input
        .MemControl(whb_ex_mem),                    // 2-bit input
        .ReadData(read_data)                        // 32-bit output
    );
    

//////////////////////////////////////////////////////////////////////////////////
// Register MEM/WB
//////////////////////////////////////////////////////////////////////////////////
    Register_MEM_WB register_mem_wb(
        .Clk(Clk),                                  // 1-bit input
        
        .alu_result_in(alu_result_ex_mem),          // 32-bit input
        .read_data_in(read_data),                   // 32-bit input
        .reg_dest_in(reg_dest_ex_mem),              // 5-bit input
        
        .alu_result_out(alu_result_mem_wb),         // 32-bit output
        .read_data_out(read_data_mem_wb),           // 32-bit output
        .reg_dest_out(reg_dest_mem_wb),             // 5-bit output
        
        .RegWrite_in(reg_write_ex_mem),             // 1-bit input
        .MemtoReg_in(mem_to_reg_ex_mem),            // 1-bit input
        
        .RegWrite_out(reg_write_mem_wb),            // 1-bit output
        .MemtoReg_out(mem_to_reg_mem_wb)            // 1-bit output
    );


//////////////////////////////////////////////////////////////////////////////////
// Write Back (WB)
//////////////////////////////////////////////////////////////////////////////////
    Mux32Bit2To1 mux_write_back(
        .select(mem_to_reg_mem_wb),                 // 1-bit input
        .in_A(alu_result_mem_wb),                   // 32-bit input
        .in_B(read_data_mem_wb),                    // 32-bit input
        .out(write_back)                            // 32-bit output
    );

endmodule