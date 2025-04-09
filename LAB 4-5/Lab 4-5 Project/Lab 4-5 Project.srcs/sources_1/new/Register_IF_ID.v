`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// @ posedge, out <= in
// no need for step in between
//////////////////////////////////////////////////////////////////////////////////

module Register_IF_ID(
    // clock input
    input Clk,
    
    // input signals
    input [31:0] PC_in,
    input [31:0] instruction_in,
    
    // output signals
    output reg [31:0] PC_out,
    output reg [31:0] instruction_out
    );
    
    // modified functionality from original submission
    // write on posedge
    always @(posedge Clk) begin
        PC_out <= PC_in;
        instruction_out <= instruction_in;
    end
    
endmodule
