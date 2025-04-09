`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Percentages: 
//    Benjamin Feuerborn (33%)
//    Jacob Missbrenner (33%)
//    Nomar Vazquez (33%)
//
// Number of Pipelined Stages: 5 Stages
// Branch Decision and Resolution Stage: MEM
//////////////////////////////////////////////////////////////////////////////////

module HazardDetectionUnit(
    input [4:0] rs,                 // Source register of current instruction
    input [4:0] rt,                 // Target register of current instruction
    input [4:0] RegDest_ex_mem,     // Desitnation register in EX/MEM stage
    input [4:0] RegDest_mem_wb,     // Destination register in MEM/WB stage
    input RegWrite_ex_mem,          // Register write signal in EX/MEM stage
    input RegWrite_mem_wb,          // Register write signal in MEM/WB stage
    
    output reg pc_write,            // Control for PC write
    output reg if_id_write,         // Control for Register IF/ID write
    output reg stall                // Signal to insert a stall (nop)
    );
    
    initial begin
        // Default values
        pc_write = 1;
        if_id_write = 1;
        stall = 0;
    end
    
    always @(*) begin        
        //Read after write (RAW)
        // Detect hazard: RAW dependency with EX stage
        if (RegWrite_ex_mem && ((RegDest_ex_mem == rs) || (RegDest_ex_mem == rt)) && RegDest_ex_mem != 5'b0) begin
            pc_write = 0;        // Stall PC
            if_id_write = 0;     // Stall IF/ID
            stall = 1;           // Insert nop
        end
        
        // Detect hazard: RAW dependency with MEM stage
        else if (RegWrite_mem_wb && ((RegDest_mem_wb == rs) || (RegDest_mem_wb == rt)) && RegDest_mem_wb != 5'b0) begin
            pc_write = 0;
            if_id_write = 0;
            stall = 1;
        end
        
        else begin
            pc_write = 1;
            if_id_write = 1;
            stall = 0;
        end
    end
    
endmodule
