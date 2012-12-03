module IDStage(
  input [31:0] Inst,
  input EXRegWrite,
  input EXMemRead,
  input [4:0] EXRd,
  input MEMRegWrite,
  input [31:0] MEMData,
  input [4:0] MEMRd,
  input WBRegWrite,
  input [31:0] WBData,
  input [4:0] WBRd,
  input Clk,
  output reg Branch,
  output reg Jump,
  output reg Stall,
  output reg [31:0] BranchOffset,
  output reg [25:0] JumpAddress,
  output reg ALUSrc,
  output reg [2:0] ALUControl,
  output reg MemRead,
  output reg MemWrite,
  output reg RegWrite,
  output reg [31:0] DataA,
  output reg [31:0] DataB,
  output reg [31:0] SignExtend,
  output reg [4:0] Rs,
  output reg [4:0] Rt,
  output reg [4:0] Rd
);
  initial begin
    Branch <= 0; Jump <= 0; Stall <= 0; BranchOffset <= 0; JumpAddress <= 0;
    ALUSrc <= 0; ALUControl <= 0; MemRead <= 0; MemWrite <= 0; RegWrite <= 0;
    DataA <= 0; DataB <= 0; SignExtend <= 0; Rs <= 0; Rt <= 0; Rd <= 0;
  end

  wire [5:0] opcode       = Inst[31:26];
  wire [4:0] rs           = Inst[25:21];
  wire [4:0] rt           = Inst[20:16];
  wire [4:0] rd           = Inst[15:11];
  wire [15:0] imm         = Inst[15:00];
  wire [25:0] jumpaddress = Inst[25:00];
  wire [5:0] funct        = Inst[05:00];

  wire alusrc, regdst, memwrite, memread, beq, bne, jump, memtoreg,
    regwrite;
  wire [2:0] alucontrol;
  Control ctrl(opcode, funct, alusrc, regdst, memwrite, memread, beq, bne, jump,
    memtoreg, regwrite, alucontrol);

  wire [31:0] reg_a, reg_b;
  RegisterFile rf(rs, rt, WBRd, WBData, WBRegWrite, Clk, reg_a, reg_b);

  wire [31:0] sign_ex;
  SignExtension se(imm, sign_ex);

  wire [31:0] cmp_a;
  Mux32Bit2To1 cam(reg_a, MEMData, MEMRegWrite && MEMRd && MEMRd == rs, cmp_a);

  wire [31:0] cmp_b;
  Mux32Bit2To1 cbm(reg_b, MEMData, MEMRegWrite && MEMRd && MEMRd == rt, cmp_b);

  wire cmp = cmp_a == cmp_b;

  wire [4:0] actual_rd;
  Mux5Bit2To1 rdmux(rt, rd, regdst, actual_rd);

  always @(negedge Clk) begin
    // Run one tick after EXStage (three after WBStage).
    #3;

    Branch <= cmp & beq | ~cmp & bne;
    Jump <= jump;

    // Ignore everything else if jumping.
    if (Jump)
      Stall <= 0;
    // Stall on branch forwarding hazard.
    else if (EXRegWrite && EXRd && (EXRd == rs || EXRd == rt))
      Stall <= beq | bne;
    // Stall on load hazard.
    else if (EXMemRead && EXRd && (EXRd == rs || EXRd == rt))
      Stall <= 1;
    else
      Stall <= 0;

    BranchOffset <= sign_ex;
    JumpAddress <= jumpaddress;
    ALUSrc <= alusrc;
    ALUControl <= alucontrol;
    MemRead <= memread;
    DataA <= reg_a;
    DataB <= reg_b;
    SignExtend = sign_ex;
    Rs = rs;
    Rt = rt;
    Rd = actual_rd;

    if (Stall) begin
      MemWrite <= 0;
      RegWrite <= 0;
    end else begin
      MemWrite <= memwrite;
      RegWrite <= regwrite;
    end
  end
endmodule
