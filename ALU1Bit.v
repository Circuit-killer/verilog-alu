module ALU1Bit(a, b, cin, less, op, result, cout, g, p, set);
  input a, b, cin, less;
  input [2:0] op;
  output result;
  output cout;
  output g, p;
  output set;

  reg result;
  reg cout;
  reg g, p;
  reg set;

  reg bval;

  always @(*) begin
    bval = b ^ op[2];

    // AND
    g = a & bval;
    // OR
    p = a | bval;
    // Sum
    set = a ^ bval ^ cin;
    // Carry out
    cout = a & bval | a & cin | bval & cin;

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
