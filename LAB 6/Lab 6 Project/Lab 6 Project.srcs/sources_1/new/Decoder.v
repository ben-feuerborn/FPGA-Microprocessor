`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// taken from Jacob's decoder with slight modification
//////////////////////////////////////////////////////////////////////////////////

module Decoder(
    // controller inputs
    input [31:26] opcode,
    input [20:16] rt,
    input [5:0] funct,
    
    // controller outputs
    output reg [3:0] AluOp,
    output reg MAT,
    output reg MAB,
    output reg RegDst,
    output reg RegWrite,
    output reg MemWrite,
    output reg MemRead,
    output reg [1:0] WHB,
    output reg MemtoReg,
    output reg Branch,
    output reg [1:0] Jump,
    output reg JAL
    );
    
    // set default output of all control signals
    initial begin
        Branch <= 1'b0;
        Jump <= 2'b00;
        JAL <= 1'b0;
    end
    
    // manage output signals
    always @(opcode, rt, funct) begin
        // handles r-type instructions (when opcode is 000000
        if (opcode == 6'b000000 || opcode == 6'b011100) begin
            case (funct)
                6'b100000: begin /*add*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b100100: begin /*and*/
                    AluOp <= 4'b0011;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b001000: begin /*jr*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b10;
                    JAL <= 1'b0;
                end
                
                6'b000010: begin /*mul*/
                    AluOp <= 4'b0010;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b100111: begin /*nor*/
                    AluOp <= 4'b0101;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b100101: begin /*or*/
                    AluOp <= 4'b0100;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b000000: begin /*sll*/
                    AluOp <= 4'b0111;
                    MAT <= 1'b1;
                    MAB <= 1'b0;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b101010: begin /*slt*/
                    AluOp <= 4'b1001;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b000010: begin /*srl*/
                    AluOp <= 4'b1000;
                    MAT <= 1'b1;
                    MAB <= 1'b0;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b100010: begin /*sub*/
                    AluOp <= 4'b0001;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b100110: begin /*xor*/
                    AluOp <= 4'b0110;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
            endcase
        end
        
        // handles all other instruction types
        else begin
            case (opcode)
                6'b001000: begin /*addi*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b001100: begin /*andi*/
                    AluOp <= 4'b0011;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b000100: begin /*beq*/
                    AluOp <= 4'b1010;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b1;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b000001: begin /*bgez*/
                    AluOp <= 4'b1100;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b1;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b000111: begin /*bgtz*/
                    AluOp <= 4'b1110;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b1;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b000110: begin /*blez*/
                    AluOp <= 4'b1101;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b1;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b000001: begin /*bltz*/
                    AluOp <= 4'b1111;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b1;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b000101: begin /*bne*/
                    AluOp <= 4'b1011;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b1;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b000010: begin /*j*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b01;
                    JAL <= 1'b0;
                end
                
                6'b000011: begin /*jal*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b0;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b01;
                    JAL <= 1'b1;
                end
                
                6'b100000: begin /*lb*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b1;
                    WHB <= 2'b10;
                    MemtoReg <= 1'b1;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b100001: begin /*lh*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b1;
                    WHB <= 2'b01;
                    MemtoReg <= 1'b1;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b100011: begin /*lw*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b1;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b1;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b1;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b001101: begin /*ori*/
                    AluOp <= 4'b0100;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b101000: begin /*sb*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b1;
                    MemRead <= 1'b0;
                    WHB <= 2'b10;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b101001: begin /*sh*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b1;
                    MemRead <= 1'b0;
                    WHB <= 2'b01;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b001010: begin /*slti*/
                    AluOp <= 4'b1001;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b101011: begin /*sw*/
                    AluOp <= 4'b0000;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b0;
                    MemWrite <= 1'b1;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
                
                6'b001110: begin /*xori*/
                    AluOp <= 4'b0110;
                    MAT <= 1'b0;
                    MAB <= 1'b1;
                    RegDst <= 1'b0;
                    RegWrite <= 1'b1;
                    MemWrite <= 1'b0;
                    MemRead <= 1'b0;
                    WHB <= 2'b00;
                    MemtoReg <= 1'b0;
                    Branch <= 1'b0;
                    Jump <= 2'b00;
                    JAL <= 1'b0;
                end
            endcase
        end
    end
    
endmodule