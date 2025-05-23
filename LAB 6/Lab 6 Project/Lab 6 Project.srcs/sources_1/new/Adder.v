`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////

module Adder(
    input [31:0] input1,// top input
    input [31:0] input2,// bottom input
    output reg [31:0] out// adder output
    );
    
    always @(input1, input2) begin
        out <= input1 + input2;
    end
    
endmodule
