`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////

module Register_MEM_WB(
    // clock input
    input Clk,
    
    // input signals
    input [31:0] alu_result_in,
    input [31:0] read_data_in,
    input [4:0] reg_dest_in,
    
    // output signals
    output reg [31:0] alu_result_out,
    output reg [31:0] read_data_out,
    output reg [4:0] reg_dest_out,
    
    // control signals
    // inputs
    input RegWrite_in,
    input MemtoReg_in,
    
    // outputs
    output reg RegWrite_out,
    output reg MemtoReg_out
    );
    
    always @(posedge Clk) begin
        alu_result_out <= alu_result_in;
        read_data_out <= read_data_in;
        reg_dest_out <= reg_dest_in;
        
        // control signals
        RegWrite_out <= RegWrite_in;
        MemtoReg_out <= MemtoReg_in;
    end
    
endmodule
