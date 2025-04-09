`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);

	input [3:0] ALUControl;        // control bits for ALU operation
                                   // you need to adjust the bitwidth as needed
	input [31:0] A, B;             // inputs

	output reg [31:0] ALUResult;   // answer
	output reg Zero;               // Zero=1 if ALUResult == 0

    always @(ALUControl, A, B, ALUResult) begin
        ALUResult <= 0;
        
        case (ALUControl)
            // ARITHMETIC
            4'b0000: ALUResult <= A + B; // add
            4'b0001: ALUResult <= A - B; // subtract
            4'b0010: ALUResult <= A * B; // multiply
            
            // LOGICAL
            4'b0011: ALUResult <= A & B;    // and
            4'b0100: ALUResult <= A | B;    // or
            4'b0101: ALUResult <= ~(A | B); // nor
            4'b0110: ALUResult <= A ^ B;    // xor
            4'b0111: ALUResult <= B << A;   // shift B left by A
            4'b1000: ALUResult <= B >> A;   // shift B right by A
            
            4'b1001: ALUResult <= A < B ? 1:0;          // slt
            4'b1010: ALUResult <= A == B ? 1:0;         // beq
            4'b1011: ALUResult <= A != B ? 1:0;         // bne
            4'b1100: ALUResult <= A >= 32'b0 ? 1:0;     // bgez
            4'b1101: ALUResult <= A <= 32'b0 ? 1:0;     // blez
            4'b1110: ALUResult <= A > 32'b0 ? 1:0;      // bgtz
            4'b1111: ALUResult <= A < 32'b0 ? 1:0;      // bltz
            
        endcase
        
        // if ALUResult = 0, Zero = 1
        Zero <= (ALUResult == 0);
    end

endmodule

