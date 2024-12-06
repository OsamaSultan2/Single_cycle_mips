vlib work 
vlog ALU.v control_unit.v memory.v register_file.v static_memory.v mips_processor.v processor_tb.v
vsim  -voptargs=+acc work.mips_processor_tb
add wave -position insertpoint  \
sim:/mips_processor_tb/DUT/clk \
sim:/mips_processor_tb/DUT/rst \
sim:/mips_processor_tb/DUT/instruction \
sim:/mips_processor_tb/DUT/PC \
sim:/mips_processor_tb/DUT/ALU_op \
sim:/mips_processor_tb/DUT/ALU_src \
sim:/mips_processor_tb/DUT/reg_write \
sim:/mips_processor_tb/DUT/mem_read \
sim:/mips_processor_tb/DUT/mem_write \
sim:/mips_processor_tb/DUT/mem_to_reg \
sim:/mips_processor_tb/DUT/reg_dst \
sim:/mips_processor_tb/DUT/jump \
sim:/mips_processor_tb/DUT/branch_eq \
sim:/mips_processor_tb/DUT/branch_ne \
sim:/mips_processor_tb/DUT/branch \
sim:/mips_processor_tb/DUT/immediate_shifter \
sim:/mips_processor_tb/DUT/memory_access \
sim:/mips_processor_tb/DUT/result_addr \
sim:/mips_processor_tb/DUT/op_one_addr \
sim:/mips_processor_tb/DUT/op_two_addr \
sim:/mips_processor_tb/DUT/op_two_addr_in \
sim:/mips_processor_tb/DUT/op_one \
sim:/mips_processor_tb/DUT/op_two \
sim:/mips_processor_tb/DUT/immediate_number \
sim:/mips_processor_tb/DUT/result \
sim:/mips_processor_tb/DUT/mem_out \
sim:/mips_processor_tb/DUT/result_in \
sim:/mips_processor_tb/DUT/zero_f \
sim:/mips_processor_tb/DUT/negative_f \
sim:/mips_processor_tb/DUT/overflow_f \
sim:/mips_processor_tb/DUT/carry_f \
sim:/mips_processor_tb/DUT/instruction_mem/mem \
sim:/mips_processor_tb/DUT/reg_file/reg_file
run -all
