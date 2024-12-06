module ALU_tb ();
  reg   [31:0] reg_one , reg_two;
  reg [5:0] op;
  wire [31:0] result;
  reg [31:0] result_expected;
  wire zero_f,negative_f,overflow_f,carry_f;
  integer i=0;
  //============ DUT INIT. ===========================
  ALU dut (.reg_one(reg_one),.reg_two(reg_two),.op(op),.result(result),.zero_f(zero_f),
  .negative_f(negative_f),.overflow_f(overflow_f),.carry_f(carry_f));
  //============= testbench ========================================


  //--------testing logical shift left-----------
  initial begin
    op=0;
    reg_one=1;
    for( i=0; i<20;i=i+1) begin
      reg_two=i;
      result_expected=reg_one << reg_two;
      #2
      if(result !=result_expected) begin
        $display("ERROR in shifting left in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("logical shift left works successfull");
  //--------- testing logical shift right------------------
    op=2;
    reg_one={1,30'b0};
    for( i=0; i<20;i=i+1) begin
      reg_two=i;
      result_expected=reg_one >> reg_two;
      #2
      if(result !=result_expected) begin
        $display("ERROR in shifting right in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("logical shift right works successfull");
  //--------- testing arithmatic shift right------------------
    op=3;
    reg_one={1,30'b0};
    for( i=0; i<20;i=i+1) begin
      reg_two=i;
      result_expected=reg_one >>> reg_two;
      #2
      if(result !=result_expected) begin
        $display("ERROR in shifting right arithmatic in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("arithmatic shift right works successfull");
    //--------- testing addition ---------------------------
    op=32;
    for(  i=0; i<50;i=i+1) begin
      reg_one=$random;
      reg_two=$random;
      result_expected = reg_one + reg_two;
      #2
      if(result !=result_expected) begin
        $display("ERROR in addition in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("addition works successfull");
    //--------- testing subtracion ---------------------------
    op=34;
    for(  i=0; i<50;i=i+1) begin
      reg_one=$random;
      reg_two=$random;
      result_expected = reg_one - reg_two;
      #2
      if(result !=result_expected) begin
        $display("ERROR in subtraction in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("subtracion works successfull");
    //================= testing logical operations =======================


     //--------- testing anding ---------------------------
    op=36;
    for(  i=0; i<50;i=i+1) begin
      reg_one=$random;
      reg_two=$random;
      result_expected = reg_one & reg_two;
      #2
      if(result !=result_expected) begin
        $display("ERROR in anding in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("anding works successfull");
    
     //--------- testing oring ---------------------------
    op=37;
    for(  i=0; i<50;i=i+1) begin
      reg_one=$random;
      reg_two=$random;
      result_expected = reg_one | reg_two;
      #2
      if(result !=result_expected) begin
        $display("ERROR in oring in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("oring works successfull");

     //--------- testing xoring ---------------------------
    op=38;
    for(  i=0; i<50;i=i+1) begin
      reg_one=$random;
      reg_two=$random;
      result_expected = reg_one ^ reg_two;
      #2
      if(result !=result_expected) begin
        $display("ERROR in xoring in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("xoring works successfull");
     //--------- testing noring ---------------------------
    op=39;
    for(  i=0; i<50;i=i+1) begin
      reg_one=$random;
      reg_two=$random;
      result_expected = ~(reg_one | reg_two);
      #2
      if(result !=result_expected) begin
        $display("ERROR in noring in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("noring works successfull");
     //--------- testing set on lessthan ---------------------------
    op=42;
    for(  i=0; i<100;i=i+1) begin
      reg_one=$random;
      reg_two=$random;
      result_expected = (reg_one < reg_two)? 1:0;
      #2
      if(result !=result_expected) begin
        $display("ERROR in set on less than in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("set on less than works successfull");

//--------- testing set on jump register ---------------------------
    op=8;
    for(  i=0; i<100;i=i+1) begin
      reg_one=$random;
      reg_two=$random;
      result_expected = reg_one;
      #2
      if(result !=result_expected) begin
        $display("ERROR in jumping in test %d , result = %b , result expected = %b",i,result,result_expected);
        $stop;
      end
    end
    $display("jumping works successfull");
    #2;
    $stop;
  end

  //================ monitoring flags ============
  // initial begin
  //   $monitor("operand 1 =%b , operand 2 = %b, operation = %b , result = %b , zero flag = %b , overflow flag = %b , negative flag = %b , carry out = %b",
  //   reg_one,reg_two,op,result,zero_f,overflow_f,negative_f,carry_f);
  // end

endmodule