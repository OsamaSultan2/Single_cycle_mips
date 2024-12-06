module mips_processor (
  input clk,rst
); 
  //================== internal signal ================
  wire[31:0] instruction ;
  reg[31:0]PC;
  wire [5:0] ALU_op;
  wire ALU_src;
  wire reg_write,mem_read,mem_write,mem_to_reg,reg_dst;
  wire jump,branch_eq,branch_ne,branch;
  wire immediate_shifter;  // to add LUI inistruction
  wire [1:0] memory_access;
  wire [4:0] result_addr, op_one_addr,op_two_addr;
  wire [31:0] op_one,op_two,op_two_addr_in;
  wire [31:0] immediate_number;
  wire  [31:0] result,mem_out,result_in;
  wire zero_f,negative_f,overflow_f;
  wire  carry_f;

  //================= memory & control unit instantiation ===================
  memory instruction_mem (.clk(clk),.wr_en(1'b0),.rd_en(1'b1),.rst(rst),.address(PC[8:0]),.dout(instruction));

  control_unit control (.instruction(instruction),.ALU_src(ALU_src),.ALU_op(ALU_op),.reg_write(reg_write),
  .mem_read(mem_read),.mem_write(mem_write),.mem_to_reg(mem_to_reg),.reg_dst(reg_dst),.jump(jump),
  .branch(branch_eq),.branch_ne(branch_ne),.immediate_shifter(immediate_shifter),.memory_access(memory_access));
//============== regiters inputs and instantiation =============================
assign result_addr=(reg_dst)?(instruction[15:11]):instruction[20:16];
assign op_one_addr=instruction[25:21];
assign op_two_addr=instruction[20:16];
register_file reg_file (.result_addr(result_addr),.op_one_addr(op_one_addr),.op_two_addr(op_two_addr),
.rst(rst),.op_one(op_one),.op_two(op_two),.wr_en(reg_write),.din(result_in),.clk(clk));
//============== ALU / shifter ========================
 //------------ immediate ----------------------------
 assign immediate_number=(immediate_shifter)?{instruction[15:0],16'b0}:{{16{instruction[15]}},instruction[15:0]};
 //------------ alu instantiation -------------------
  assign op_two_addr_in=(ALU_src)?immediate_number:op_two;
  ALU alu (.reg_one(op_one),.reg_two(op_two_addr_in),.result(result),.zero_f(zero_f),.negative_f(negative_f),
  .overflow_f(overflow_f),.carry_f(carry_f),.op(ALU_op),.shamt(instruction[10:6]));
//================ data memory / register result input====================== 
  static_memory data_mem (.rst(rst),.din(op_two),.address(result[8:0]),.dout(mem_out),.rd_en(mem_read),
  .wr_en(mem_write),.access_type(memory_access));
  assign result_in=(mem_to_reg)?(mem_out):(result);
  //================= PC addressing ===================
  // -------------- program counter -------------------
  always @(negedge clk) begin
    if (rst) begin
      PC<=0;
    end
    else if(branch) begin
    PC <= immediate_number+(PC+1);
    end
    else if (jump) begin
      PC <={{PC[31:26]},instruction[25:0]};
    end 
    else
    PC<=PC+1;
  end
  //---------------- branching ---------------------------
  assign branch= (zero_f & branch_eq) |(!zero_f &branch_ne);
endmodule