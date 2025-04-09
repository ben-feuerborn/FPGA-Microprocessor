`timescale 1ns/1ps
`include "ALU32Bit.v"

module ALU32Bit_tb;
reg [31:0] A;
reg [31:0] B;
reg [3:0] ALUControl;
wire [31:0] ALUResult;
wire Zero;

ALU32Bit alu32(ALUControl, A, B, ALUResult, Zero);

initial begin
    $dumpfile("alutest.vcd");
    $dumpvars(0, alu32);

    A = 32'h00000000;
    B = 32'h00000000;
    ALUControl = 4'h0;

    #20;
    ALUControl <= 4'b0000; A <= 32'h0000000A;  B <= 32'h00000008; //and
    #20;
    ALUControl <= 4'b0001; A <= 32'h0000000A;  B <= 32'h00000008; //or
    #20;
    ALUControl <= 4'b0010; A <= 32'h00000002;  B <= 32'h00000002; //add
    #20;
    ALUControl <= 4'b0110; A <= 32'h0000000A;  B <= 32'h00000008; //sub
    #20;
    ALUControl <= 4'b0111; A <= 32'h0000000A;  B <= 32'h00000008; //slt
    #20;
    ALUControl <= 4'b1100; A <= 32'h0000000A;  B <= 32'h00000008; //nor
    #20;   

    $finish;
end

endmodule