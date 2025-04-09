`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 1
// Module - Top_tb.v
// Description - Test the 'Top.v' module.
////////////////////////////////////////////////////////////////////////////////


module Top_tb();
    reg Reset, Clk;
    wire [6:0] out7;
    wire [7:0] en_out;
    
    // Top(Reset, Clk)
    Top tb(.Reset(Reset), .Clk(Clk), .out7(out7), .en_out(en_out));
    
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
