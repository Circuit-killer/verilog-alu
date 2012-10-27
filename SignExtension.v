module SignExtension(a, result);
  input [15:0] a;
  output [31:0] result;

  // Duplicate the MSB 16 times and prepend it to the rest of a.
  assign result = {{16{a[15]}}, a};
endmodule
