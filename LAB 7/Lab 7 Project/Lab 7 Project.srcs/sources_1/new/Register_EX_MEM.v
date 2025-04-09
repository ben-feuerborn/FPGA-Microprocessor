`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////

module Register_EX_MEM(
    // clock input
    input Clk,
    
    // input signals
    input [31:0] pc_branch_in,
    input [31:0] alu_result_in,
    input zero_in,
    input [4:0] reg_dest_in,
    input [31:0] write_data_in,
    
    // output signals
    output reg [31:0] pc_branch_out,
    output reg [31:0] alu_result_out,
    output reg zero_out,
    output reg [4:0] reg_dest_out,
    output reg [31:0] write_data_out,
    
    // control signals
    // inputs
    input RegWrite_in,
    input MemWrite_in,
    input MemRead_in,
    input [1:0] WHB_in,
    input MemtoReg_in,
    input Branch_in,
    
    // outputs
    output reg RegWrite_out,
    output reg MemWrite_out,
    output reg MemRead_out,
    output reg [1:0] WHB_out,
    output reg MemtoReg_out,
    output reg Branch_out
    );
    
    always @(posedge Clk) begin
        pc_branch_out <= pc_branch_in;
        alu_result_out <= alu_result_in;
        zero_out <= zero_in;
        reg_dest_out <= reg_dest_in;
        write_data_out <= write_data_in;
        
        // control signals
        RegWrite_out <= RegWrite_in;
        MemWrite_out <= MemWrite_in;
        MemRead_out <= MemRead_in;
        WHB_out <= WHB_in;
        MemtoReg_out <= MemtoReg_in;
        Branch_out <= Branch_in;
    end
    
endmodule
