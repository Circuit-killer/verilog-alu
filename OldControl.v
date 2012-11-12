module OldControl(opcode, ALUSrc, ALUOp, RegDst, MemWrite, MemRead, Beq, Bne,
                  Jump, MemToReg, RegWrite);
  input [5:0] opcode;
  output reg ALUSrc, RegDst, MemWrite, MemRead, Beq, Bne, Jump, MemToReg,
    RegWrite;
  output reg [1:0] ALUOp;

  always @(*) begin
    case (opcode)
    // R-type
    'b 000000: begin
      ALUSrc <= 0;
      RegDst <= 1;
      MemWrite <= 0;
      MemRead <= 0;
      Beq <= 0;
      Bne <= 0;
      Jump <= 0;
      MemToReg <= 0;
      RegWrite <= 1;
      ALUOp <= 'b 10;
    end

    // lw
    'b 100011: begin
      ALUSrc <= 1;
      RegDst <= 0;
      MemWrite <= 0;
      MemRead <= 1;
      Beq <= 0;
      Bne <= 0;
      Jump <= 0;
      MemToReg <= 1;
      RegWrite <= 1;
      ALUOp <= 'b 00;
    end

    // sw
    'b 101011: begin
      ALUSrc <= 1;
      MemWrite <= 1;
      MemRead <= 0;
      Beq <= 0;
      Bne <= 0;
      Jump <= 0;
      RegWrite <= 0;
      ALUOp <= 'b 00;
    end

    // beq
    'b 000100: begin
      ALUSrc <= 0;
      MemWrite <= 0;
      MemRead <= 0;
      Beq <= 1;
      Bne <= 0;
      Jump <= 0;
      RegWrite <= 0;
      ALUOp <= 'b 01;
    end

    // bne
    'b 000101: begin
      ALUSrc <= 0;
      MemWrite <= 0;
      MemRead <= 0;
      Beq <= 0;
      Bne <= 1;
      Jump <= 0;
      RegWrite <= 0;
      ALUOp <= 'b 01;
    end

    // Jump
    'b 000010: begin
      MemWrite <= 0;
      MemRead <= 0;
      Beq <= 0;
      Bne <= 0;
      Jump <= 2;
      RegWrite <= 0;
    end
    endcase
  end
endmodule
