set current_dir [pwd]
set rel_top_dir ..

set hdl_dir "${rel_top_dir}/hdl"

set hdl_files [glob -nocomplain -directory $hdl_dir */*.vhd]

if { [file exists ${rel_top_dir}/mips_processor/mips_processor.xpr] } {
    puts "Opening existing project"
    open_project ${rel_top_dir}/mips_processor/mips_processor.xpr
} else {
    puts "Creating new project"
    create_project -force mips_processor ${rel_top_dir}/mips_processor -part xc7a35tcpg236-1
}

foreach file $hdl_files {
    set library [file tail [file dirname $file]]
    add_files -norecurse $file
    set_property library $library [get_files  $file]

    puts "Library: $library"
    puts "File: $file"
}