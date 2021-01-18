.text

main:

# -------------------------- Part 2 --------------------------

	# prompt user to input N
	la $a0, askForN
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s0, $v0

	move $a0, $s0
	li $a1, 0
	jal recursiveSummation
	
	move $s0, $v0
	
	# display sum
	la $a0, displaySum
	li $v0, 4
	syscall	
	
	move $a0, $s0
	li $v0, 1
	syscall

exit:
	# exit 	
	li $v0, 10
	syscall		


recursiveSummation:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a1, 4($sp)
	move $v0, $zero	
	
	# base case
	beq $a1, $a0, recursiveSummationDone
	
	# next 
	addi $a1, $a1, 1
	
	jal recursiveSummation
	add $v0, $t0, $v0
	lw $ra, 0($sp)
	lw $a1, 4($sp)
	add $sp, $sp, 8
	move $t0, $a1
	
recursiveSummationDone:
	jr $ra
	
.data
	askForN: .asciiz "Enter the value of n: "
	displaySum: .asciiz "The sum is "