yosys -import

#!/usr/bin/tclsh

# read verilog
read_verilog RTL/SPM/top.v 

# check hierarchy & set top module
hierarchy -check -top top 

# translate processes (always blocks)
procs; opt

# detect and optimize FSM encodings
#fsm; opt

# implement memories (arrays)
memory; opt

# convert to gate logic
techmap; opt

# flatten
flatten; opt

# mapping flip-flops to mycells.lib
dfflibmap -liberty Tech/nangate/NangateOpenCellLibrary_typical.lib

# mapping logic to mycells.lib
abc -liberty Tech/nangate/NangateOpenCellLibrary_typical.lib

# print gate count
stat

# cleanup
opt_clean -purge

write_verilog -noattr -noexpr Netlists/spm.netlist.v