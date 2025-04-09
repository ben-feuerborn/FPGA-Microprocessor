`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////

module Mux32Bit4To1(
    input [1:0] select,         // select singal for output
    input [31:0] in_A,          // input 0
    input [31:0] in_B,          // input 1
    input [31:0] in_C,          // input 2
    input [31:0] in_D,          // input 3
    
    output reg [31:0] out       // selected output
    );
    
    always @(select, in_A, in_B, in_C, in_D) begin
        if (select == 2'b00) begin out <= in_A; end
        else if (select == 2'b01) begin out <= in_B; end
        else if (select == 2'b10) begin out <= in_C; end
        else if (select == 2'b11) begin out <= in_D; end
    end
    
endmodule
