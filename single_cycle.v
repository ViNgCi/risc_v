module single_cycle (
    clk,
    rst_n,
);
    input clk;
    input rst_n;

    wire [31:0] pc;
    wire [31:0] pc_4;
    wire [31:0] inst;
    wire [31:0] dataA;
    wire [31:0] dataB;
    wire [31:0] dataD;
    wire [31:0] imm;
    wire [31:0] alu;
    wire [31:0] mem;


    wire BrEq;
    wire BrLt;
    wire PCSel;
    wire [2:0] immSel;
    wire RegWEn;
    wire BrUn;
    wire Bsel;
    wire Asel;
    wire [3:0] ALUSel;
    wire MemRW;
    wire [1:0] WBSel;


    //IF
    pc_module pc_mod(alu, PCSel, clk, pc, pc_4, rst_n);
    imem imem_mod(pc, inst);
    //ID
    reg_module reg_mod(inst, clk, dataD, dataA, dataB, RegWEn);
    imm_gen imm_mod(inst, immSel, imm);
    //ALU
    branch branch_mod(dataA, dataB, BrUn, BrEq, BrLt);
    alu_module alu_mod(dataA, dataB, pc, imm, alu, Asel, Bsel, ALUSel);
    //Dmem
    dmem dmem_mod(alu, dataB, clk, mem, MemRW);
    //WB
    write_back wb_mod(alu, mem, pc_4, WBSel, dataD); 

    control_unit control(PCSel, inst, immSel, RegWEn, BrUn, BrEq, BrLt, Bsel, Asel, ALUSel, MemRW, WBSel);

    
endmodule