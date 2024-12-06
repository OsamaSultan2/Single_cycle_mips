module static_memory #(
  parameter DATA_WIDTH = 32,
  parameter MEMORY_SIZE = 512,
  localparam ADDRESS_WIDTH = $clog2(MEMORY_SIZE)
) (
  input wr_en,rd_en,rst,
  input [ADDRESS_WIDTH-1:0] address,
  input [DATA_WIDTH-1:0] din,
  input [1:0] access_type,
  output reg [DATA_WIDTH-1:0] dout
);

integer i=0;
  reg [DATA_WIDTH-1:0] mem [MEMORY_SIZE-1:0];
  
  always @(*) begin
  if(rst) begin
    for (i =0 ;i<MEMORY_SIZE ;i=i+1 ) begin
        mem[i]=32'b0;
      end
      dout=0;
  end
  else if (rd_en)  begin
    case (access_type)
      2'b11:dout={mem[address],mem[address + 1] , mem[address + 2] ,mem[address + 3]};  // lw instruction
      2'b01:dout={{16{mem[address][7]}} , mem[address],mem[address+1]}; // load half word instuction
      2'b00:dout={{24{mem[address][7]}},mem[address]}; // load byte instruction
      default:dout={mem[address],mem[address + 1] , mem[address + 2] ,mem[address + 3] }; //load word default
    endcase
  end   
  else if(wr_en) begin
   case (access_type)
      2'b11:{mem[address],mem[address + 1], mem[address + 2],mem[address +3]} =din;
      2'b01:{mem[address], mem[ address +1]}=din[15:0]; 
      2'b00: mem[address]=din[7:0];
      default:{mem[address],mem[address + 1], mem[address + 2],mem[address +3]} =din; 
    endcase
    dout=0;
  end
  end
endmodule