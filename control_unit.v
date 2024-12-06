module control_unit (
  input [31:0] instruction,
  output reg [5:0] ALU_op,
  output reg ALU_src,   // I -instructon offset - R format 2nd operand
  output reg reg_write,mem_read,mem_write,mem_to_reg,reg_dst,
  output reg jump,branch,branch_ne,
  output reg immediate_shifter,  // to add LUI inistruction
  output reg [1:0] memory_access
);
wire [5:0] op_code;

assign op_code =instruction[31:26];

always @(instruction) begin
  casex (op_code)
  //============= R instructions =============================
    0: begin
      ALU_src=0;
      reg_write=1;
      mem_read=0;
      mem_write=0;
      mem_to_reg=0;
      reg_dst=1;
      jump=0;
      branch=0;
      branch_ne=0;
      ALU_op=instruction[5:0];
      immediate_shifter=0;
      memory_access=2'b11;
    end  
  //================== I instructions ========================
  //------------ IMMEDIATE operations ---------------------
    6'b001xxx: begin   
      ALU_src=1;
      reg_write=1;
      mem_read=0;
      mem_write=0;
      mem_to_reg=0;
      reg_dst=0;
      jump=0;
      branch=0;
      branch_ne=0;
      memory_access=2'b11;
      if (op_code[2:0]=='b010) begin //Slti instruction 
        ALU_op={3'b101,op_code[2:0]};
        immediate_shifter=0;
      end
      else if (op_code[2:0] == 'b111) begin //LUI instruction
        ALU_op=6'b10_0000;  // adding the immediate
        immediate_shifter=1; 
      end
      else begin
      ALU_op={3'b100,op_code[2:0]};
      immediate_shifter=0;
      end
    end
    //--------------loading instruction-------------
    6'b1000xx: begin
      ALU_src=1;
      reg_write=1;
      mem_read=1;
      mem_write=0;
      mem_to_reg=1;
      reg_dst=0;
      jump=0;
      branch=0;
      immediate_shifter=0;  
      ALU_op=6'b10_0000;
      memory_access=op_code[1:0];
    end 
    //--------------storing instruction-------------
    6'b101xxx: begin
      ALU_src=1;
      reg_write=0;
      mem_read=0;
      mem_write=1;
      mem_to_reg=0;
      reg_dst=0;
      jump=0;
      branch=0;
      immediate_shifter=0;   
      ALU_op=6'b10_0000;    
      memory_access=op_code[1:0];
    end 
    //--------------- branching instruction ---------
    6'b00010x: begin
      ALU_src=0;
      reg_write=0;
      mem_read=0;
      mem_write=0;
      mem_to_reg=0;
      reg_dst=0;
      jump=0;
      immediate_shifter=0;   
      ALU_op=6'b10_0010;    // subtraction
      memory_access=2'b11;
      if(op_code[0] ==0) begin
      branch=1;
      branch_ne=0;
      end
      else begin
        branch=0;
        branch_ne=1;
      end
    end 
    //------------- jumping instruction --------------
    6'b00_001x: begin
      ALU_src=0;
      reg_write=0;
      mem_read=0;
      mem_write=0;
      mem_to_reg=0;
      reg_dst=0;
      jump=1;
      branch=0;
      branch_ne=0;
      immediate_shifter=0;   
      ALU_op=6'b10_0000;
      memory_access=2'b11;  
    end 
    default: begin
      ALU_src=0;
      reg_write=0;
      mem_read=0;
      mem_write=0;
      mem_to_reg=0;
      reg_dst=0;
      jump=0;
      branch=0;
      branch_ne=0;
      immediate_shifter=0;   
      ALU_op=0;  
      memory_access=2'b11;
    end
  endcase
end  
endmodule