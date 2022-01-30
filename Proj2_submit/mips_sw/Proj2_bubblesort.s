# Bubble Sort
# test with array of integers - {2, 7, 5, 3, 1, 9}
.data 0x10010000
Array: .word 2, 7, 5, 3, 1, 9
.text
main:
# show inputs
lw $t1, 0x10010000
lw $t1, 0x10010004
lw $t1, 0x10010008
lw $t1, 0x1001000C
lw $t1, 0x10010010
lw $t1, 0x10010014
# sort loop iterator(outer loop)  i = 1
addi $t9, $0, 1
# Copy the Array address
lui $a0, 0x1001
nop
nop
nop
ori $a0, $a0, 0x0000
# Base address of array
add $t1, $a0, $0
nop
nop
nop
# 6 - 1 elements
# base address + (4 * 5) to track end of Array
add $t6, $t1, 20

# check all sorting iterations
outer_loop:
add $a0, $t1, $0	# outer loop will reset inner loop
addi $t8, $0, 6		# size = 6 elements
nop
nop
nop
nop
beq $t9, $t8, end	# iterations = size; leave loop - array is sorted
nop
nop
nop
nop

# iterate over the array to sort elements
inner_loop:
lw  $t2, 0($a0)         # $t2 = Array[j]
lw  $t3, 4($a0)         # $t3 = Array[j + 1]
nop
nop
nop
nop
slt $t5, $t2, $t3       # $t5 = 1 if Array[j] < Array[j + 1]
nop
nop
nop
bne $t5, $0, cont   	# if $t5 = 0, then swap them
nop
nop
nop
nop
sw  $t2, 4($a0)         # swap numbers for sorting
sw  $t3, 0($a0)         

cont:
addi $a0, $a0, 4		# increment array position 
nop
nop
nop
nop
bne  $a0, $t6, inner_loop	# check if at end of the array
nop
nop
nop
nop
addi $t9, $t9, 1		# i++
j outer_loop
nop
nop
nop
nop

end:
# system call to end
lw $t1, 0x10010000
lw $t1, 0x10010004
lw $t1, 0x10010008
lw $t1, 0x1001000C
lw $t1, 0x10010010
lw $t1, 0x10010014
halt
# system call to end
addi $v0, $0, 10
syscall
