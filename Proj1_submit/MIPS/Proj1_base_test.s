
add $8, $zero, $zero # $8 = 0
addi $8, $8, 15		# $8 = 15
addiu $9, $8, 15	# $9 = 30
addu $9, $9, $8		# $9 = 45
sub $10, $9, $8		# $10 = 30
subu $10, $10, $8		# $10 = 15
and $11, $10, $zero	# $11 = 0x0000000F
ori $12, $11, 65535	# $12 = 0x0000FFFF
or $8, $8, $12		# $8 = 0x0000FFFF
andi $9, $9, 65535		# $9 = 30
nor $13, $12, $zero	# $13 = 0xFFFF0000
xor $8, $8, $13		# $8 = 0xFFFFFFFF
sra $9, $11, 10		# $9 = 0x00000000
srl $10, $9, 12		# $10 = 0x000FFFFF
sll $10, $10, 12	# $10 = 0xFFFFF000
slt $8, $13, $9		# $8 = 0x00000001
slti $8, $8, -10	# $8 = 0x00000001
lui $8, 65535		# $8 = 0xFFFF0000
xori $8, $8, 65535	# $8 = 0xFFFFFFFF
addi $a0, $zero, 0x10010000
sw $8, 0($a0)
lw $9, 0($a0)


add $8, $zero, $zero
addi $14, $zero, 5
LOOP:
addi $8, $8, 1
bne $8, $14, LOOP
beq $8, $14, END

END:



