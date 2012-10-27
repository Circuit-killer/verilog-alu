module Mux32Bit2To1(a, b, op, result);
  input [31:0] a, b;
  input op;
  output [31:0] result;

  // Duplicate the op bit 32 times and use it as the mask.
  assign result = ~{32{op}} & a | {32{op}} & b;
endmodule
