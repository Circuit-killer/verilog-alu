module Mux5Bit2To1(a, b, op, result);
  input [4:0] a, b;
  input op;
  output [4:0] result;

  // Duplicate the op bit 5 times and use it as the mask.
  assign result = ~{5{op}} & a | {5{op}} & b;
endmodule
