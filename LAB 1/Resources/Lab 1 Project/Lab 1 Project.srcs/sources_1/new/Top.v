`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 1
// Module - Top.v
// Description - Top level design for Lab 1
////////////////////////////////////////////////////////////////////////////////


module Top(Reset, Clk, out7, en_out);
    input Reset;
    input wire Clk;
    output wire [6:0] out7;
    output wire [7:0] en_out;
    
    wire [31:0] NumA;
    wire [31:0] NumB;
    wire ClkOut;
    
    // InstructionFetchUnit(Instruction, PCResult, Reset, Clk)
    InstructionFetchUnit IFU(.Instruction(NumA), .PCResult(NumB), .Reset(Reset), .Clk(ClkOut));
    
    // ClkDiv(Clk, Rst, ClkOut)
    ClkDiv CD(.Clk(Clk), .Rst(Reset), .ClkOut(ClkOut));
    
    // Two4DigitDisplay(Clk, NumberA, NumberB, out7, en_out)
    Two4DigitDisplay TDD(.Clk(Clk), .NumberA(NumA), .NumberB(NumB), .out7(out7), .en_out(en_out));
endmodule
