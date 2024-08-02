`timescale 100ms/1ms
module dmem (
    addr,
    dataW,
    clk,
    dataB,
    MemRW,
);

    input [31:0] addr;
    input [31:0] dataW;
    input clk;
    input MemRW;
    output reg [31:0] dataB;

    parameter read = 0;
    parameter write = 1;

    reg [31:0] mem_arr [31:0];
    
    initial begin
        $readmemh("file.txt", mem_arr);
    end

    always @(MemRW or addr) begin
        #2;
        if (MemRW==read) begin
            dataB=mem_arr[addr[31:2]];
        end else begin
            dataB = 32'h00000000;
        end
    end

    always @(posedge clk) begin
        if (MemRW==write) begin
            mem_arr[addr[31:2]]<=dataW;
            //$writeh("file.txt", mem_arr);
        end
    end
endmodule