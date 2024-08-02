`timescale 100ms/1ms
module imem (
    pc,
    inst,
);
    input [31:0] pc;
    output reg [31:0] inst;

    reg [31:0] mem_arr [31:0];
    
    initial begin
        $readmemb("file.txt", mem_arr);
    end

    always @(pc) begin
        #2;
        inst = mem_arr[pc[31:2]];  
    end


endmodule