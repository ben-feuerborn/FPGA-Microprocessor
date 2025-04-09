`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Percentages: 
//    Benjamin Feuerborn (33%)
//    Jacob Missbrenner (33%)
//    Nomar Vazquez (33%)
//////////////////////////////////////////////////////////////////////////////////

module DatapathTopDesign(
    input Clk,
    input Rst,
    output wire [6:0] out7,
    output wire [7:0] en_out
    );
    
//////////////////////////////////////////////////////////////////////////////////
// Clock
//////////////////////////////////////////////////////////////////////////////////
    wire ClkOut;
    
    ClkDiv clk_div(
        .Clk(Clk),              // 1-bit input
        .Rst(0),                // 1-bit input
        .ClkOut(ClkOut)         // 1-bit output
    );


//////////////////////////////////////////////////////////////////////////////////
// Datapath
//////////////////////////////////////////////////////////////////////////////////
    wire [31:0] PC_out;
    wire [31:0] WB_out;
    
    Datapath datapath(
        .Clk(ClkOut),           // 1-bit input
        .Rst(Rst),              // 1-bit input
        .PC_out(PC_out),        // 32-bit output
        .WB_out(WB_out)         // 32-bit output
    );


//////////////////////////////////////////////////////////////////////////////////
// Two 4-Digit Display
//////////////////////////////////////////////////////////////////////////////////
    Two4DigitDisplay T4DD(
        .Clk(Clk),              // 1-bit input
        .NumberA(PC_out),       // N-bit input
        .NumberB(WB_out),       // N-bit input
        .out7(out7),            // 7-bit output
        .en_out(en_out)         // 8-bit output
    );
endmodule
