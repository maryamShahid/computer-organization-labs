.data
	message:    .asciiz "The equation is A = (B / C + D * B - C ) Mod B \n"
	input:      .asciiz "Enter integers B, C, D sequentially to calculate A: \n"
	result:     .asciiz "Result: "	

.text

    main:
    	# Displaying the equation
	li $v0, 4
	la $a0, message
	syscall

	# Prompt the user to input B, C, D
	li $v0, 4 
	la $a0, input
	syscall
	
	# Store integers B, C, D
	# $a0 = B, $a1 = C, $a2 = D
	li $v0, 5
	syscall
	add $a0, $v0, 0
	
	li $v0, 5
	syscall
	add $a1, $v0, 0
	
	li $v0, 5
	syscall
	add $a2, $v0, 0
	
	div $a0, $a1 # B / C
	mflo $t0 
	
	mult $a2, $a0 # D * B
	mflo $t1
	
	add $t2, $t0, $t1 # (B / C) + (D * B)
	sub $t3, $t2, $a1 # ((B / C) + (D * B)) - C 
	
	div $t3, $a0 # (B / C + D * B - C ) Mod B
	mfhi $t4
	
	
	# Displaying result
	addi $s0, $v0, 0
	li $v0, 4 
	la $a0, result
	syscall
	
	li $v0, 1
	move $a0, $t4
	syscall
	
	# This signals the end of program
	li $v0, 10
	syscall