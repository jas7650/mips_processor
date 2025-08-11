
set syn_list [list  \
    "ip/instruction_fetch/hdl/instruction_memory.vhd"       \
    "ip/instruction_fetch/hdl/instruction_fetch.vhd"        \
]

set verification_list [list \
    "ip/instruction_fetch/verification_ip/instruction_fetch_pkg.sv" \
]

set ip_name "instruction_fetch"
file_pkg::add_syn $ip_name $syn_list
file_pkg::add_verification_files $ip_name $verification_list
