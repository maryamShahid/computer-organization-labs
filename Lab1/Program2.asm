.data
	message:    .asciiz "The equation is x = a * ( b - c ) % d \n"
	input:      .asciiz "Enter integers a, b, c, d sequentially: \n"
	result:     .asciiz "Result: "	

.text

    main:
	li $v0, 4
	la $a0, message
	syscall

	# Prompt the user to input a, b, c, d
	li $v0, 4 
	la $a0, input
	syscall
	
	# Store integers a, b, c, d
	# $a0 = a, $a1 = b, $a2 = c, $a3 = d 
	li $v0, 5
	syscall
	add $a0, $v0, 0
	
	li $v0, 5
	syscall
	add $a1, $v0, 0
	
	li $v0, 5
	syscall
	add $a2, $v0, 0
	
	li $v0, 5
	syscall
	add $a3, $v0, 0
	
	# Calling function computeEquation
	jal computeEquation
	move $v1, $v0
	
	# Displaying result
	addi $s0, $v0, 0
	li $v0, 4 
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $v1
	syscall
	
	# This signals the end of program
	li $v0, 10
    	syscall
    	

    computeEquation: 
	sub $t0, $a1, $a2 # b - c
	mult $a0, $t0 # a * (b - c)
	mflo $t1 # quotient
	div $t1, $a3 # a * (b - c) / d
	mfhi $v0 # remainder

	jr $ra