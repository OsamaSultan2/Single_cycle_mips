module mips_processor_tb ();
  reg clk ,rst;
  integer i;
  //============== dut init. ==========================
  mips_processor DUT (.clk(clk),.rst(rst));
  //============= clock generation ====================
  initial begin
    clk=0;
    forever begin
      #1 clk = ~clk;
    end
  end
//========================================================
initial begin
  $readmemh("memory_instructions.dat",DUT.instruction_mem.mem);
  rst=1;
  @(negedge clk);
  rst=0;  
  for ( i=0 ;i<200 ;i=i+1 ) begin
    @(negedge clk);
  end
  $stop;
end
endmodule