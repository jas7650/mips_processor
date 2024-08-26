set current_dir [pwd]
set rel_top_dir ..

set hdl_dir "${rel_top_dir}/hdl"


create_project -force mips_processor ${rel_top_dir}/mips_processor -part xczu7ev-ffvc1156-2-e

puts "Adding files from each stage"
set stages [glob -nocomplain $rel_top_dir/stages/*/]
foreach stage $stages {
    set library [file tail $stage]
    set hdl_files [glob -nocomplain $stage/hdl/*.vhd]
    puts [file tail $stage]
    foreach file $hdl_files {
        puts $file
        add_files -norecurse $file
        set_property library $library [get_files $file]
        set_property file_type {VHDL 2008} [get_files $file]
    }
}

# foreach file $hdl_files {
#     set library [file tail [file dirname $file]]
#     add_files -norecurse $file
#     set_property library $library [get_files  $file]

#     puts "Library: $library"
#     puts "File: $file"
# }