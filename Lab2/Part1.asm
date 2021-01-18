.data 
     newLine:      .asciiz "\n"
     startMsg:     .asciiz "\nEnter 1 to start the program or 0 to exit: "
     inputPrompt:  .asciiz "\nEnter an integer number: "
     nComplement:  .asciiz "\nEnter n to complement n bits: "
     numberPrompt: .asciiz "\nThe interger entered: "
     resultMsg:    .asciiz "\nComplement of the integer in hex: "
     
.text 
  main:
	li $a1, 32  # total bits

	li $t0, 0
	li $t1, 1
    
	# prompt start message
 	li $v0, 4
    	la $a0, startMsg
    	syscall 
    	
    	# take 1 or 0 as input
    	li $v0, 5
    	syscall
    	move $a3, $v0  # $a3 has the value to continue
    
    	# quit program is user selects 0
    	beq $a3, $t0, quit
    
    	# prompt user for input
    	li $v0, 4
    	la $a0, inputPrompt
    	syscall 
    
    	# store the integer
    	li $v0, 5
    	syscall
    	move $a1, $v0  # $a1 has the integer to modify 
    
    	# prompt user to input n 
    	li $v0, 4
    	la $a0, nComplement
    	syscall 
	
	# store the number n 
 	li $v0, 5
    	syscall
    	move $a2, $v0  # $a2 has n - number of bits to complement 
    	
    	jal displayInteger
    	jal complementNumber
    	     	
    	# display output prompt
    	li $v0, 4
    	la $a0, resultMsg
    	syscall 
    
    	# print result in hexadecimal 
    	li $v0, 34
    	move $a0, $v1
    	syscall
    
    	li $v0, 4
    	la $a0, newLine
    	syscall
    	
    	# repeat
    	j main
    	
  displayInteger:
  	# display integer entered
  	li $v0, 4
  	la $a0, numberPrompt
  	syscall
  
  	li $v0, 1
  	move $a0, $a1
  	syscall
  	
  	li $v0, 4
    	la $a0, newLine
    	syscall
  
  	jr $ra

  complementNumber: 
    	addi $sp, $sp, -4
  	sw $s0, 0($sp)
  
    	li $s0, -1
  	sub $t1, $a3, $a2
  	srlv $s0, $s0, $t1
  	xor $v1, $a1, $s0 
  
  	lw $s0, 0($sp)
  	addi $sp, $sp, 4
  
  	jr $ra 
     	
  quit:
	li $v0, 10
	syscall