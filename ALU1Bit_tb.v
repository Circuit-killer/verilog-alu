module ALU1Bit_tb();
  reg a, b, cin;
  reg [2:0] op;
  reg less;
  wire result, cout, g, p, set;

  ALU1Bit alu(a, b, cin, less, op, result, cout, g, p, set);

  initial begin
    $monitor("    %b [%b] %b = R: %b   C: %b", a, op, b, result, cout);

    cin <= 0; less <= 0;

    $display("Test AND with b-inverse");
    a <= 1; b <= 0; op <= 'b 100;
    #1;

    $display("Test less passthrough");
    a <= 0; b <= 0; less <= 1; op <= 'b 111;
    #1;

    $display("Test ADD with cout");
    a <= 1; b <= 1; cin <= 0; op <= 'b 010;
    #1;

    $display("Test ADD with cin and cout");
    a <= 1; b <= 1; cin <= 1; op <= 'b 010;
    #1;

    $finish;
  end
endmodule
