`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
//////////////////////////////////////////////////////////////////////////////////

module Datapath_tb(

    );
    
    reg Clk, Rst;
    wire [31:0] PC_out, WB_out;
    
    Datapath datapath(
        .Clk(Clk),              // 1-bit input
        .Rst(Rst),              // 1-bit input
        .PC_out(PC_out),        // 32-bit output
        .WB_out(WB_out)         // 32-bit output
    );
    
    initial begin
        Clk <= 1'b0;
        Rst <= 1'b1;
        #20 Rst <= 1'b0;
    end
    
    always begin
        #10 Clk <= ~Clk;
    end
    
endmodule
