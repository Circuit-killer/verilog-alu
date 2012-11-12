module ALUOpToALUControl(ALUOp, Funct, ALUControl);
  input [1:0] ALUOp;
  input [5:0] Funct;
  output reg [2:0] ALUControl;

  always @(*) begin
    case (ALUOp)
    // Load and Store: ADD
    'b 00: ALUControl <= 'b 010;
    // Branch: SUB
    'b 01: ALUControl <= 'b 110;
    // R-type
    'b 10:
      case (Funct)
      // ADD
      'b 100000: ALUControl <= 'b 010;
      // SUB
      'b 100010: ALUControl <= 'b 110;
      // AND
      'b 100100: ALUControl <= 'b 000;
      // OR
      'b 100101: ALUControl <= 'b 001;
      // SLT
      'b 101010: ALUControl <= 'b 111;
      endcase
    endcase
  end
endmodule
