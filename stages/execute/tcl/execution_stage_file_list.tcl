set syn_list [list  \
"stages/execute_stage/hdl/arithmetic_logic_unit.vhd"                            \
"stages/execute_stage/hdl/arithmetic_shift_right_unit.vhd"                      \
"stages/execute_stage/hdl/execute_stage.vhd"                                    \
"stages/execute_stage/hdl/full_adder.vhd"                                       \
"stages/execute_stage/hdl/logic_shift_left_unit.vhd"                            \
"stages/execute_stage/hdl/logic_shift_right_unit.vhd"                           \
"stages/execute_stage/hdl/multiplier.vhd stages/execute_stage/hdl/notN.vhd"     \
"stages/execute_stage/hdl/ripple_carry_full_adder.vhd"                          \
"stages/execute_stage/hdl/TwoInputXor.vhd"                                      \
]

puts "Location: [pwd]"

# foreach file $syn_list {
#     add_files -norecurse C:/projects/mips_processor/partial_mips_processor/stages/mips/hdl/mips.vhd
#     set_property library mips [get_files  C:/projects/mips_processor/partial_mips_processor/stages/mips/hdl/mips.vhd]
# }