`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 1
// Module - pc_register.v
// Description - 32-Bit program counter (PC) register.
//
// INPUTS:-
// Address: 32-Bit address input port.
// Reset: 1-Bit input control signal.
// Clk: 1-Bit input clock signal.
//
// OUTPUTS:-
// PCResult: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design a program counter register that holds the current address of the 
// instruction memory.  This module should be updated at the positive edge of 
// the clock. The contents of a register default to unknown values or 'X' upon 
// instantiation in your module.  
// You need to enable global reset of your datapath to point 
// to the first instruction in your instruction memory (i.e., the first address 
// location, 0x00000000H).
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter(
    input Clk,
    input Reset,
    input pc_write,
    input [31:0] Address,
    output reg [31:0] PCResult
    );
    
    // contents of register default to unknown values or '0' upon instantiation
    initial begin
        PCResult <= 32'b0;
    end
    
    // enable global reset
    always @(posedge Clk) begin
        if (Reset == 1) begin
            PCResult <= 32'b0;
        end
        
        else begin
            PCResult <= Address;
        end
    end
endmodule
