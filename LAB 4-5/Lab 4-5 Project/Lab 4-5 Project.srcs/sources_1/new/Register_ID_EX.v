`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////

module Register_ID_EX(
    // clock input
    input Clk,
    
    // input signals
    input [31:0] pc_next_in,
    input [31:0] instruction_in,
    input [31:0] read_data_1_in,
    input [31:0] read_data_2_in,
    input [31:0] immediate_in,
    
    // output signals
    output reg [31:0] pc_next_out,
    output reg [31:0] instruction_out,
    output reg [31:0] read_data_1_out,
    output reg [31:0] read_data_2_out,
    output reg [31:0] immediate_out,
    
    // control signals
    // inputs
    input [3:0] AluOp_in,
    input MAT_in,
    input MAB_in,
    input RegDst_in,
    input RegWrite_in,
    input MemWrite_in,
    input MemRead_in,
    input [1:0] WHB_in,
    input MemtoReg_in,
    input Branch_in,
    
    // outputs
    output reg [3:0] AluOp_out,
    output reg MAT_out,
    output reg MAB_out,
    output reg RegDst_out,
    output reg RegWrite_out,
    output reg MemWrite_out,
    output reg MemRead_out,
    output reg [1:0] WHB_out,
    output reg MemtoReg_out,
    output reg Branch_out
    );
    
    always @(posedge Clk) begin
        pc_next_out <= pc_next_in;
        instruction_out <= instruction_in;
        read_data_1_out <= read_data_1_in;
        read_data_2_out <= read_data_2_in;
        immediate_out <= immediate_in;
        
        // control signals
        AluOp_out <= AluOp_in;
        MAT_out <= MAT_in;
        MAB_out <= MAB_in;
        RegDst_out <= RegDst_in;
        RegWrite_out <= RegWrite_in;
        MemWrite_out <= MemWrite_in;
        MemRead_out <= MemRead_in;
        WHB_out <= WHB_in;
        MemtoReg_out <= MemtoReg_in;
        Branch_out <= Branch_in;
    end
    
endmodule
