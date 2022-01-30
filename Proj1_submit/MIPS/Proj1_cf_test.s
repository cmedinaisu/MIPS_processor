.globl Main
Main:
lui $sp, 0x7fff
ori $sp, $sp, 0xeffc
addi $a0, $0, 5		# Check for 5th Fibonacci Number
jal Fibonacci
add $a0, $v0, $0

# syscall 1 prints integer for result
addi $v0, $0, 1 # syscall 1
halt
syscall 
# system call to end
addi $v0, $0, 10
syscall 


.globl Fibonacci
Fibonacci:
# store variables on the stack frame
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)


# Run Fibonacci algorithm 
add $s0, $a0, $0
addi $t1, $zero, 1
beq $s0, $0, endZero # recursive function check 0
beq $s0, $t1, endOne # recursive function check 1

addi $a0, $s0, -1
jal Fibonacci
add $s1, $0, $v0 # fibonacci(n-1)
addi $a0, $s0, -2
jal Fibonacci #fibonacci(n-2)

add $v0, $v0, $s1 # result

FibEnd:
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)	# registers are read from the stack frame
addi $sp, $sp, 12 # set back the stack frame
jr $ra

endZero:
addi $v0, $0, 0
j FibEnd

endOne:
addi $v0, $0, 1
j FibEnd
