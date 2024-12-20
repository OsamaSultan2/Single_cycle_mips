module static_memory #(
  parameter DATA_WIDTH = 32,
  parameter MEMORY_SIZE = 512,
  localparam ADDRESS_WIDTH = $clog2(MEMORY_SIZE)
) (
  input clk,wr_en,rd_en,
  input [ADDRESS_WIDTH-1:0] address,
  input [DATA_WIDTH-1:0] din,
  output reg [DATA_WIDTH-1:0] dout
);

  reg [DATA_WIDTH-1:0] mem [MEMORY_SIZE-1:0];
  
  always @(*) begin
  if (rd_en)  begin
    dout = mem[address];
  end   
  else if(wr_en) begin
    mem[address] =din;
  end
  end
endmodule