`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////

module Mux32Bit2To1(
    input select,               // select signal for output
    input [31:0] in_A,          // input 0
    input [31:0] in_B,          // input 1
    
    output reg [31:0] out       // selected output
    );
    
    always @(select, in_A, in_B) begin
        if (select == 1'b1) begin out <= in_B; end
        else begin out <= in_A; end
    end
    
endmodule