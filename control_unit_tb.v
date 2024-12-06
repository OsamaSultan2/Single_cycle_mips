module control_unit_tb ();
  reg [31:0] instruction;
  wire [5:0] ALU_op;
  wire ALU_src;   // I -instructon offset - R format 2nd operand
  wire reg_write,mem_read,mem_write,mem_to_reg,reg_dst;
  wire jump,branch;
  wire immediate_shifter;  // to add LUI inistruction
  integer i=0;
//=============== DUT init ============================
control_unit dut (.instruction(instruction),.ALU_op(ALU_op),.ALU_src(ALU_src),.reg_write(reg_write),
.mem_read(mem_read),.mem_write(mem_write),.mem_to_reg(mem_to_reg),.reg_dst(reg_dst),
.jump(jump),.branch(branch),.immediate_shifter(immediate_shifter));
//========================================================
initial begin
  for (i =0 ;i<100 ;i=i+1 ) begin
    instruction=$random;
    #5;
  end
  $stop;
end
//=========================================================
initial begin
  $monitor("opcode = %b , Alu op = %d , Alu source = %b , reg_write= %b , mem_read= %b , mem_write = %b , mem_to_reg = %b , reg_dst=%b, jump=%b , branch=%b ,immediate shifter=%b",
  instruction[31:26],ALU_op,ALU_src,reg_write,mem_read,mem_write,mem_to_reg,reg_dst,jump,branch,
  immediate_shifter);
end
endmodule