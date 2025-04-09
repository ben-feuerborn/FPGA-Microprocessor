`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////


module ControlMux(
    // input signal
    input stall,

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
    
    always @(*) begin
        if (stall) begin
            AluOp_out <= 4'b0;
            MAT_out <= 1'b0;
            MAB_out <= 1'b0;
            RegDst_out <= 1'b0;
            RegWrite_out <= 1'b0;
            MemWrite_out <= 1'b0;
            MemRead_out <= 1'b0;
            WHB_out <= 2'b0;
            MemtoReg_out <= 1'b0;
            Branch_out <= 1'b0; 
        end
        
        else begin
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
    end
endmodule
