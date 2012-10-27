module Mux32Bit2To1_tb();
  reg [31:0] a, b;
  reg op;
  wire [31:0] result;

  Mux32Bit2To1 mux(a, b, op, result);

  initial begin
    $monitor("    %h [%b] %h = %h", a, op, b, result);

    a <= 'h DEAD_BEEF; b <= 'h DEAD_DAD5;

    $display("Test mux with op 0");
    op <= 0;
    #1;

    $display("Test mux with op 1");
    op <= 1;
    #1;
  end
endmodule

