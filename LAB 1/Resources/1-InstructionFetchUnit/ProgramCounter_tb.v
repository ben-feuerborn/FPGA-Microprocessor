`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 1
// Module - ProgramCounter_tb.v
// Description - Test the 'ProgramCounter.v' module.
////////////////////////////////////////////////////////////////////////////////

module ProgramCounter_tb(); 

	reg [31:0] Address;
	reg Reset, Clk;

	wire [31:0] PCResult;

    ProgramCounter u0(
        .Address(Address), 
        .PCResult(PCResult), 
        .Reset(Reset), 
        .Clk(Clk)
    );

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	   @(posedge Clk);
	   #5 Reset <= 1;
	   @(posedge Clk);
	   #5 Reset <= 0;
	   @(posedge Clk);
       #5 Address <= 8;
       @(posedge Clk);
       #5 Address <= 32;
       @(posedge Clk);
       #5 Address <= 0;
       @(posedge Clk);
       #5 Reset <= 1;
       @(posedge Clk);
       #5 Reset <= 0;
       @(posedge Clk);
       #5 Address <= 8;
	end

endmodule

