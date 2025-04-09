`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 1 
// Module - PCAdder_tb.v
// Description - Test the 'PCAdder.v' module.
////////////////////////////////////////////////////////////////////////////////

module PCAdder_tb();

    reg [31:0] PCResult;

    wire [31:0] PCAddResult;

    PCAdder u0(
        .PCResult(PCResult), 
        .PCAddResult(PCAddResult)
    );

	initial begin
	   PCResult <= 0; // PCAddResult = 4
	   #100 PCResult <= 8; // PCAddResult = 12
	   #100 PCResult <= 2; // PCAddResult = 6
	   #100 PCResult <= 100; // PCAddResult = 104
	   #100 PCResult <= 416; // PCAddResult = 420
	   #100 PCResult <= 2147483647; // PCAddResult = 2147483651
	end

endmodule

