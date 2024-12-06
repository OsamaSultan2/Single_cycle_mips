module register_file (
  input rst,wr_en,clk, 
  input [31:0] din,
  input [4:0] result_addr, op_one_addr,op_two_addr,
  output reg [31:0] op_one,op_two
);
reg [31:0] reg_file [31:0];
integer i;
  always @(*) begin
    if(rst)begin
      op_one<=0;
      op_two<=0; 
      for (i =0 ;i<32 ;i=i+1 ) begin
        reg_file[i]=32'b0;
      end
    end
    else begin
      op_one <=reg_file[op_one_addr];
      op_two <=reg_file[op_two_addr];
    end 
  end
  always @(posedge clk) begin
      if(wr_en)
      reg_file[result_addr] <= din;
  end
endmodule