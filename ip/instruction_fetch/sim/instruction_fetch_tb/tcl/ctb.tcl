set rel_top_dir ../../../../..

source $rel_top_dir/scripts/tcl/scripts_pkg.tcl

set libs [list \
    "instruction_fetch" \
]

file_pkg::add_libs $libs

set sim_list [list \
    "ip/instruction_fetch/sim/instruction_fetch_tb/hdl/test.sv"  \
    "ip/instruction_fetch/sim/instruction_fetch_tb/hdl/top_tb.sv"  \
]

file_pkg::add_sim instruction_fetch $sim_list
file_pkg::source_file_lists $rel_top_dir
file_pkg::print_file_summary

sim_pkg::set_top_module instruction_fetch.top
sim_pkg::ctb $rel_top_dir

# sim_pkg::print_sim_libs

# # Set library name
# set libname work

# # Create and map the library
# vlib $libname
# vmap $libname work

# # Compile VHDL files
# vcom -work $libname ../../../hdl/spi_master.vhd

# # Compile SystemVerilog files
# vlog -work $libname ../../../verification_ip/spi_master_pkg.sv
# vlog -work $libname ../hdl/test.sv
# vlog -work $libname ../hdl/top_tb.sv

# puts "yuhh"
# # Load and run simulation
# vsim -L $libname top
# puts "yuhhhh"

# # Run simulation for a set time
# run -all