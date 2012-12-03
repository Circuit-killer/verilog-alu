module Mux32Bit3To1(a, b, c, op, result);
  input [31:0] a, b, c;
  input [2:0] op;
  output reg [31:0] result;

  always @(*) begin
    case (op)
    'b 00: result = a;
    'b 01: result = b;
    'b 10: result = c;
    endcase
  end
endmodule
