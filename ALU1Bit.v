module ALU1Bit(a, bin, cin, less, op, result, cout, g, p, set);
  input a, bin, cin, less;
  input [2:0] op;
  output reg result;
  output cout, g, p, set;

  // Invert b if necessary.
  wire b = bin ^ op[2];

  // AND
  assign g = a & b;
  // OR
  assign p = a | b;
  // Sum
  assign set = a ^ b ^ cin;
  // Carry out
  assign cout = a & b | a & cin | b & cin;

  always @(*) begin
    casez (op)
    // a AND b
    'b ?00: result = g;
    // a OR b
    'b ?01: result = p;
    // a ADD/SUB b
    'b ?10: result = set;
    // a SLT b
    'b ?11: result = less;
    endcase
  end
endmodule
