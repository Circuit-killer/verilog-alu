module ALUOpToALUControl_tb();
  reg [1:0] ALUOp;
  reg [5:0] Funct;
  wire [2:0] ALUControl;

  ALUOpToALUControl c(ALUOp, Funct, ALUControl);

  initial begin
    $monitor("  ALUOp:%b  Funct:%b  ALUControl:%b", ALUOp, Funct, ALUControl);

    $display("Test Load and Store");
    ALUOp = 'b 00;
    #1;

    $display("Test Branch)");
    ALUOp = 'b 01;
    #1;

    $display("Test R-type ADD");
    ALUOp = 'b 10;
    Funct = 'b 100000;
    #1;

    $display("Test R-type SUB");
    ALUOp = 'b 10;
    Funct = 'b 100010;
    #1;

    $display("Test R-type AND");
    ALUOp = 'b 10;
    Funct = 'b 100100;
    #1;

    $display("Test R-type OR");
    ALUOp = 'b 10;
    Funct = 'b 100101;
    #1;

    $display("Test R-type SLT");
    ALUOp = 'b 10;
    Funct = 'b 101010;
    #1;

    $finish;
  end
endmodule
