onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TB
add wave -noupdate /tb_mips_processor/CLK
add wave -noupdate /tb_mips_processor/s_iRST
add wave -noupdate /tb_mips_processor/s_iInstLd
add wave -noupdate /tb_mips_processor/s_iInstAddr
add wave -noupdate /tb_mips_processor/s_iInstExt
add wave -noupdate -radix decimal /tb_mips_processor/s_oALUOut
add wave -noupdate -divider Processor
add wave -noupdate -divider {Data Memory Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemWr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemOut
add wave -noupdate -divider {Register File Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrData
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWr
add wave -noupdate -divider {IMEM Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_IMemAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_NextInstAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Inst
add wave -noupdate -divider {Control Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_MemtoReg
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Jump
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Branch
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUOp
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrc
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegDst
add wave -noupdate -divider {Other Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Ovfl
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Zero
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ExtImm
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData1
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData2
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrcMux
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUControl
add wave -noupdate -divider Instructions
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(7)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(6)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(5)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(4)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(3)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(2)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(1)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(0)
add wave -noupdate -divider RegFile
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iCLk
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWA
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWD
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWE
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_FOUT
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_RST
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_Q
add wave -noupdate -divider TB
add wave -noupdate /tb_mips_processor/CLK
add wave -noupdate /tb_mips_processor/s_iRST
add wave -noupdate /tb_mips_processor/s_iInstLd
add wave -noupdate /tb_mips_processor/s_iInstAddr
add wave -noupdate /tb_mips_processor/s_iInstExt
add wave -noupdate -radix decimal /tb_mips_processor/s_oALUOut
add wave -noupdate -divider Processor
add wave -noupdate -divider {Data Memory Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemWr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemOut
add wave -noupdate -divider {Register File Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrData
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWr
add wave -noupdate -divider {IMEM Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_IMemAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_NextInstAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Inst
add wave -noupdate -divider {Control Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_MemtoReg
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Jump
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Branch
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUOp
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrc
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegDst
add wave -noupdate -divider {Other Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Ovfl
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Zero
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ExtImm
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData1
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData2
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrcMux
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUControl
add wave -noupdate -divider Instructions
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(7)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(6)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(5)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(4)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(3)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(2)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(1)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(0)
add wave -noupdate -divider RegFile
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iCLk
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWA
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWD
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWE
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_FOUT
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_RST
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_Q
add wave -noupdate -divider TB
add wave -noupdate /tb_mips_processor/CLK
add wave -noupdate /tb_mips_processor/s_iRST
add wave -noupdate /tb_mips_processor/s_iInstLd
add wave -noupdate /tb_mips_processor/s_iInstAddr
add wave -noupdate /tb_mips_processor/s_iInstExt
add wave -noupdate -radix decimal /tb_mips_processor/s_oALUOut
add wave -noupdate -divider Processor
add wave -noupdate -divider {Data Memory Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemWr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemOut
add wave -noupdate -divider {Register File Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrData
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWr
add wave -noupdate -divider {IMEM Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_IMemAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_NextInstAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Inst
add wave -noupdate -divider {Control Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_MemtoReg
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Jump
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Branch
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUOp
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrc
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegDst
add wave -noupdate -divider {Other Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Ovfl
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Zero
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ExtImm
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData1
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData2
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrcMux
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUControl
add wave -noupdate -divider Instructions
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(7)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(6)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(5)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(4)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(3)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(2)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(1)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(0)
add wave -noupdate -divider RegFile
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iCLk
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWA
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWD
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWE
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_FOUT
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_RST
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_Q
add wave -noupdate -divider TB
add wave -noupdate /tb_mips_processor/CLK
add wave -noupdate /tb_mips_processor/s_iRST
add wave -noupdate /tb_mips_processor/s_iInstLd
add wave -noupdate /tb_mips_processor/s_iInstAddr
add wave -noupdate /tb_mips_processor/s_iInstExt
add wave -noupdate -radix decimal /tb_mips_processor/s_oALUOut
add wave -noupdate -divider Processor
add wave -noupdate -divider {Data Memory Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemWr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemOut
add wave -noupdate -divider {Register File Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrData
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWr
add wave -noupdate -divider {IMEM Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_IMemAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_NextInstAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Inst
add wave -noupdate -divider {Control Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_MemtoReg
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Jump
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Branch
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUOp
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrc
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegDst
add wave -noupdate -divider {Other Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Ovfl
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Zero
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ExtImm
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData1
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData2
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrcMux
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUControl
add wave -noupdate -divider Instructions
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(7)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(6)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(5)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(4)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(3)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(2)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(1)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(0)
add wave -noupdate -divider RegFile
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iCLk
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWA
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWD
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWE
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_FOUT
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_RST
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_Q
add wave -noupdate -divider TB
add wave -noupdate /tb_mips_processor/CLK
add wave -noupdate /tb_mips_processor/s_iRST
add wave -noupdate /tb_mips_processor/s_iInstLd
add wave -noupdate /tb_mips_processor/s_iInstAddr
add wave -noupdate /tb_mips_processor/s_iInstExt
add wave -noupdate -radix decimal /tb_mips_processor/s_oALUOut
add wave -noupdate -divider Processor
add wave -noupdate -divider {Data Memory Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemWr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemOut
add wave -noupdate -divider {Register File Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrData
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWr
add wave -noupdate -divider {IMEM Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_IMemAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_NextInstAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Inst
add wave -noupdate -divider {Control Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_MemtoReg
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Jump
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Branch
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUOp
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrc
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegDst
add wave -noupdate -divider {Other Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Ovfl
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Zero
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ExtImm
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData1
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData2
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrcMux
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUControl
add wave -noupdate -divider Instructions
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(7)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(6)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(5)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(4)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(3)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(2)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(1)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(0)
add wave -noupdate -divider RegFile
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iCLk
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWA
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWD
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWE
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_FOUT
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_RST
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_Q
add wave -noupdate -divider TB
add wave -noupdate /tb_mips_processor/CLK
add wave -noupdate /tb_mips_processor/s_iRST
add wave -noupdate /tb_mips_processor/s_iInstLd
add wave -noupdate /tb_mips_processor/s_iInstAddr
add wave -noupdate /tb_mips_processor/s_iInstExt
add wave -noupdate -radix decimal /tb_mips_processor/s_oALUOut
add wave -noupdate -divider Processor
add wave -noupdate -divider {Data Memory Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemWr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_DMemOut
add wave -noupdate -divider {Register File Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWrData
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegWr
add wave -noupdate -divider {IMEM Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_IMemAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_NextInstAddr
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Inst
add wave -noupdate -divider {Control Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_MemtoReg
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Jump
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Branch
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUOp
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrc
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_RegDst
add wave -noupdate -divider {Other Signals}
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Ovfl
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_Zero
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ExtImm
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData1
add wave -noupdate -radix decimal /tb_mips_processor/MIPS_Processor0/s_RegData2
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUSrcMux
add wave -noupdate /tb_mips_processor/MIPS_Processor0/s_ALUControl
add wave -noupdate -divider Instructions
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(7)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(6)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(5)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(4)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(3)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(2)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(1)
add wave -noupdate /tb_mips_processor/MIPS_Processor0/IMem/ram(0)
add wave -noupdate -divider RegFile
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iCLk
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iRA1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWA
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWD
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/iWE
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR0
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/oR1
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_FOUT
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_RST
add wave -noupdate /tb_mips_processor/MIPS_Processor0/RegFile0/s_Q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 303
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
WaveRestoreZoom {0 ns} {111 ns}
