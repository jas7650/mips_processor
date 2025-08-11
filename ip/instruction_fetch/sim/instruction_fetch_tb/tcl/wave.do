onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group top /top/clock
add wave -noupdate -group top /top/reset
add wave -noupdate -group top /top/instruction
add wave -noupdate -group dut /top/dut/clk
add wave -noupdate -group dut /top/dut/rst
add wave -noupdate -group dut /top/dut/instruction
add wave -noupdate -group dut /top/dut/pc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1044750 ps}
