module register_file_tb ();
  reg rst,wr_en,clk;
  reg [31:0] din;
  reg [4:0] result_addr, op_one_addr,op_two_addr;
  wire [31:0] op_one,op_two;
  integer i=0;
  //============ DUT INIT.====================
  register_file dut (.clk(clk),.rst(rst),.wr_en(wr_en),.din(din),.result_addr(result_addr),.op_one_addr(op_one_addr),
  .op_two_addr(op_two_addr),.op_one(op_one),.op_two(op_two));
  // ============ clock generation ============
  initial begin
    clk=0;
    forever begin
    #1  clk = ~clk;
    end
  end
  //=====================================================
  initial begin
    $readmemh("memory.dat" , dut.reg_file);
    rst=1;result_addr=0;op_one_addr=0;op_two_addr=0;wr_en=0;din=0;
    
    
    rst=0;
    wr_en=1; din=25;
    @(negedge clk);
    for (i = 0; i<32;i=i+1 ) begin
      result_addr=i;
      din=$random;
      @(negedge clk);
    end
    wr_en=0;
    for (i =0 ;i<20 ;i=i+1 ) begin
      op_one_addr=$random;
      op_two_addr=$random;
      @(negedge clk);
    end
    $stop;
  end
endmodule