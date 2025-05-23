`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory.v
// Description - 32-Bit wide data memory.
//
// INPUTS:-
// Address: 32-Bit address input port.
// WriteData: 32-Bit input port.
// Clk: 1-Bit Input clock signal.
// MemWrite: 1-Bit control signal for memory write.
// MemRead: 1-Bit control signal for memory read.
//
// OUTPUTS:-
// ReadData: 32-Bit registered output port.
//
// FUNCTIONALITY:-
// Design the above memory similar to the 'RegisterFile' model in the previous 
// assignment.  Create a 1K memory, for which we need 10 bits.  In order to 
// implement byte addressing, we will use bits Address[11:2] to index the 
// memory location. 
//
//The 'WriteData' value is written into the address 
// corresponding to Address[11:2] in the **positive** clock edge if 'MemWrite' 
// signal is 1. 
//
//'ReadData' is the value of memory location Address[11:2] if 
// 'MemRead' is 1, otherwise, it is 0x00000000. The reading of memory is **not**
// **clocked.**
//
// you need to declare a 2d array. in this case we need an array of 1024 (1K)  
// 32-bit elements for the memory.   
// for example,  to declare an array of 256 32-bit elements, declaration is: reg[31:0] memory[0:255]
// if i continue with the same declaration, we need 8 bits to index to one of 256 elements. 
// however , address port for the data memory is 32 bits. from those 32 bits, least significant 2 
// bits help us index to one of the 4 bytes within a single word. therefore we only need bits [9-2] 
// of the "Address" input to index any of the 256 words. 
////////////////////////////////////////////////////////////////////////////////

module DataMemory(
    input Clk,
    input [31:0] Address,           // Input Address
    input [31:0] WriteData,         // Data that needs to be written into the address
    input MemWrite,                 // Control signal for memory write
    input MemRead,                  // Control signal for memory read
    input [1:0] MemControl,         // 00 is word, 01 is half, 10 is byte
    output reg [31:0] ReadData      // Contents of memory location at Address
    );
    
    reg [31:0] memory [0:1023];
    
    // initialize data memory with instructions
    // modify string to change stating code
    initial begin
        $readmemh("data_memory.mem", memory);
    end
    
    // store and load operations
    always @(posedge Clk) begin
        // store
        if (MemWrite) begin
            // word
            if (MemControl == 2'b00) begin
                memory[Address[11:2]] = WriteData;
            end
            
            // half
            else if (MemControl == 2'b01) begin
                case (Address[1])
                    // first half
                    1'b0: memory[Address[11:2]] = {memory[Address[11:2]][31:16], WriteData[15:0]};
                    // second half
                    1'b1: memory[Address[11:2]] = {WriteData[31:16], memory[Address[11:2]][15:0]};
                endcase
            end
            
            // byte
            else if (MemControl == 2'b10) begin
                case (Address[1:0])
                    2'b00: memory[Address[11:2]] = {memory[Address[11:2]][31:8], WriteData[7:0]};
                    2'b01: memory[Address[11:2]] = {memory[Address[11:2]][31:16], WriteData[15:8], memory[Address[11:2]][7:0]};
                    2'b10: memory[Address[11:2]] = {memory[Address[11:2]][31:26], WriteData[25:16],memory[Address[11:2]][15:0]};
                    2'b11: memory[Address[11:2]] = {WriteData[31:26], memory[Address[11:2]][25:0]};
                endcase
            end
        end
    end
    
    always @(*) begin
        // load
        if (MemRead) begin
            // word
            if (MemControl == 2'b00) begin
                ReadData = memory[Address[11:2]];
            end
            
            // half
            else if (MemControl == 2'b01) begin
                case (Address[1])
                    // first half
                    1'b0: ReadData = {WriteData[31:16], memory[Address[11:2]][15:0]};
                    // second half
                    1'b1: ReadData = {memory[Address[11:2]][31:16], WriteData[15:0]};
                endcase
            end
            
            // byte
            else if (MemControl == 2'b10) begin
                case (Address[1:0])
                    2'b00: ReadData = {WriteData[31:8], memory[Address[11:2]][7:0]};
                    2'b01: ReadData = {WriteData[31:16], memory[Address[11:2]][15:8], WriteData[7:0]};
                    2'b10: ReadData = {WriteData[31:26], memory[Address[11:2]][25:16], WriteData[15:0]};
                    2'b11: ReadData = {WriteData[31:26], WriteData[25:0]};
                endcase
            end
        end
        
        else begin
            ReadData <= 32'b0;
        end
    end
endmodule
