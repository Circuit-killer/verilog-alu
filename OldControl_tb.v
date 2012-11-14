module OldControl_tb();
  reg [5:0] opcode;
  wire ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite;
  wire [1:0] ALUOp;

  OldControl oc(opcode, ALUSrc, ALUOp, RegDst, MemWrite, MemRead, Beq, Bne, Jump,
    MemToReg, RegWrite);

  initial begin
    $monitor("  opcode:%b A:%b R:%b MW:%b MR:%b Beq:%b Bne:%b J:%b MTR:%b RW%b ALUOp%b", opcode, ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg, RegWrite, ALUOp);

    $display("Test R-type");
    opcode = 'b 000000;
    #1;

    $display("Test lw)");
    opcode = 'b 100011;
    #1;

    $display("Test sw");
    opcode = 'b 101011;
    #1;

    $display("Test Beq");
    opcode = 'b 000100;
    #1;

    $display("Test Bne");
    opcode = 'b 000101;
    #1;

    $display("Test Jump");
    opcode = 'b 000010;
    #1;

    $finish;
  end
endmodule
