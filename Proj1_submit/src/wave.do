onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Processor
add wave -noupdate -divider {Required Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/iCLK
add wave -noupdate /tb_mips_processor/MIPS_Processor0/iRST
add wave -noupdate /tb_mips_processor/MIPS_Processor0/iInstLd
add wave -noupdate /tb_mips_processor/MIPS_Processor0/iInstAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/iInstExt
add wave -noupdate /tb_mips_processor/MIPS_Processor0/oALUOut
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemWr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemData
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemOut
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrData
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_IMemAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_NextInstAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Inst
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Ovfl
add wave -noupdate -divider {Control Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_MemtoReg
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Jump
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Branch
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUOp
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrc
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegDst
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_SignExt
add wave -noupdate -divider {Other Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Zero
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ExtImm
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegData1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrcMux
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUControl
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {40 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 305
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {88 ns}
mem load -infile imem.hex -format hex /tb_mips_processor/MIPS_Processor0/IMem/ram
