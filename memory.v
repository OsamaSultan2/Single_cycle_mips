module memory #(
  parameter DATA_WIDTH = 32,
  parameter MEMORY_SIZE = 512,
  localparam ADDRESS_WIDTH = $clog2(MEMORY_SIZE)
) (
  input clk,wr_en,rd_en,rst,
  input [ADDRESS_WIDTH-1:0] address,
//  input [DATA_WIDTH-1:0] din,
  output reg [DATA_WIDTH-1:0] dout
);

  reg [DATA_WIDTH-1:0] mem [MEMORY_SIZE-1:0];
  always @(posedge clk) begin
  if (rd_en)  begin
    dout <= mem[address];
  end   
  else if(wr_en) begin
    //mem[address] <=din;
  end
  end
endmodule
/*module memory_tb ();
  parameter DATA_WIDTH = 32;
  parameter MEMORY_SIZE = 512;
  localparam ADDRESS_WIDTH = $clog2(MEMORY_SIZE);
  reg clk,wr_en,rd_en;
  reg [ADDRESS_WIDTH-1:0] address;
  reg [DATA_WIDTH-1:0] din;
  wire [DATA_WIDTH-1:0] dout;
  //=============== DUT INIT. ===============================
  memory DUT (.clk(clk),.wr_en(wr_en),.rd_en(rd_en),.address(address),.din(din),.dout(dout));
  //============== clock generation ============================
  initial begin
    clk=0;
    forever begin
      #1 clk = ~clk;
    end
  end
  // ================= testbench =====================================
  initial begin
    $readmemh("memory.dat",DUT.mem);
    wr_en=0;
    rd_en=1;
    address=0;
    din=30;
    @(negedge clk);
    wr_en=1;rd_en=0;
    @(negedge clk);
    address =3;
    din = 35;
    @(negedge clk);
    address = 512;
    @(negedge clk);
    address=0;
    wr_en=0;rd_en=1;
    @(negedge clk);
    $stop;
  end
endmodule*/