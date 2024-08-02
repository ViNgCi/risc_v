`timescale 100ms/1ms

module single_cycle_tb();
    
    reg clk;
    reg rst_n;
    
    parameter T=8;
    single_cycle uut(.clk(clk),.rst_n(rst_n));

    initial begin
        // $dumpfile("single_cycle_tb.vcd");
        // $dumpvars(1);
        clk=1'b0;
        forever #(T/2) clk = ~clk;
    end

    initial begin
        rst_n=1;
    end

endmodule