`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension.v
// Description - Sign extension module.
////////////////////////////////////////////////////////////////////////////////

module SignExtension(
    input [15:0] in,            // 16-bit input word
    output reg [31:0] out       // 32-bit output word 
    );
    
    always @(in) begin
        if (in[15] == 1) begin out <= {32'hffff, in}; end
        else begin out <= {32'h0000, in}; end
    end
    
endmodule