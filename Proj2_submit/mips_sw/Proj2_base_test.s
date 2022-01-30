.data

.text
add $8, $zero, $zero # $8 = 0
nop
nop
nop
addi $8, $8, 15		# $8 = 15
nop
nop
nop
addiu $9, $8, 15	# $9 = 30
nop
nop
nop
addu $9, $9, $8		# $9 = 45
nop
nop
nop
sub $10, $9, $8		# $10 = 30
nop
nop
nop
subu $10, $10, $8	# $10 = 15
nop
nop
nop
and $11, $10, $zero	# $11 = 0x0000000F
nop
nop
nop
ori $12, $11, 65535	# $12 = 0x0000FFFF
nop
nop
nop
or $8, $8, $12		# $8 = 0x0000FFFF
andi $9, $9, 65535		# $9 = 30
nor $13, $12, $zero	# $13 = 0xFFFF0000
nop
nop
nop
xor $8, $8, $13		# $8 = 0xFFFFFFFF
sra $9, $11, 10		# $9 = 0x00000000
nop
nop
nop
srl $10, $9, 12		# $10 = 0x000FFFFF
nop
nop
nop
sll $10, $10, 12	# $10 = 0xFFFFF000
slt $8, $13, $9		# $8 = 0x00000001
nop
nop
nop
slti $8, $8, -10	# $8 = 0x00000001
lui $8, 65535		# $8 = 0xFFFF0000
nop
nop
nop
xori $8, $8, 65535	# $8 = 0xFFFFFFFF
lui $a0, 0x1001
nop
nop
nop
ori $a0, $a0, 0
nop
nop
nop
sw $8, 0($a0)
lw $9, 0($a0)
add $8, $zero, $zero
addi $14, $zero, 5
nop
nop
LOOP:
addi $8, $8, 1
nop
nop
nop
bne $8, $14, LOOP
nop
nop
nop
beq $8, $14, END
nop
nop
nop
END:
halt


