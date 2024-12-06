module ALU (
  input   [31:0] reg_one , reg_two,
  input [5:0] op,
  input [4:0] shamt,
  output  [31:0] result,
  output zero_f,negative_f,overflow_f,
  output reg carry_f
);
reg[31:0] result_in;  
wire [31:0] reg_two_chk;
  always @(*) begin
    case (op)
      0:begin  //=======> shift left logic
        result_in= reg_one << shamt;
        carry_f = 0;
      end 
      2:begin  //======> shift right logic
        result_in= reg_one >> shamt;
        carry_f=0;
      end 
      3:begin  //======> shift right arithmatic
        result_in= reg_one >>> shamt;
        carry_f=0;
      end 
      8:begin  //=======>jump register
        result_in= reg_one;
        carry_f=0;
      end 
      32:begin //======> addition
        {carry_f,result_in}= reg_one + reg_two;
      end 
      34:begin //======> subtraction
    
        {carry_f,result_in} = reg_one - reg_two;
      end
    //=============== logical operation ==============
      36:begin //======> anding
        result_in= reg_one & reg_two;
        carry_f=0;
      end 
      37:begin //======> oring
        result_in= reg_one | reg_two;
        carry_f=0;
      end 
      38:begin //======> xoring
        result_in= reg_one ^ reg_two;
        carry_f=0;
      end 
      39:begin //======> noring
        result_in= ~(reg_one | reg_two);
        carry_f=0;
      end 
      42:begin //======> set on less than
        {carry_f,result_in}=reg_one-reg_two;
      end 
      default: begin
        result_in =0;
        carry_f = 0;
      end
    endcase
  end


  //====================== FLAGS ASSIGNMENT ============================
  assign reg_two_chk=(op==42 ||op ==36)?(~reg_two):reg_two;
  assign overflow_f= (~(reg_one[31]^reg_two_chk[31])) & (carry_f ^ result_in [31]); // must be checked
  assign zero_f = &(~result_in);
  assign negative_f= result_in[31] ^ overflow_f;
  assign result=(op==42)?{30'b0,negative_f}:result_in;
endmodule