`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 1
// Module - InstructionFetchUnit_tb.v
// Description - Test the 'InstructionFetchUnit.v' module.
////////////////////////////////////////////////////////////////////////////////


module InstructionFetchUnit_tb();
    reg Reset, Clk;
    wire [31:0] Instruction, PCResult;
    
    // InstructionFetchUnit(Instruction, PCResult, Reset, Clk)
    InstructionFetchUnit tb(.Instruction(Instruction), .PCResult(PCResult), .Reset(Reset), .Clk(Clk));
    
    initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end
	
	initial begin
	   @(posedge Clk);
	   #5 Reset = 1;
	   @(posedge Clk);
	   #5 Reset = 0;
	end
    
endmodule
