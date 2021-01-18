.data
    array:      .space 80
    totalNo:    .asciiz "\nEnter the total number of integers: "
    elements:   .asciiz "\nEnter elements to be stored in the array: \n"
    displayArr: .asciiz "Array elements: "
    space:      .asciiz "  "
    yesPal:     .asciiz "\nThe array is a palindrome."
    noPal:      .asciiz "\nThe array is NOT a palindrome."
  
      
.text
 
   main:
       # Prompt the user to enter the total number of integers
    	li $v0, 4
       	la $a0, totalNo
       	syscall
       
       	# Get the total number of integers
       	li $v0, 5
       	syscall
       
       	# Moving the value of n to t2
       	addi $t2, $v0, 0 
      
	# Base case for palindrome
      	beqz $v0, isPalindrome 
      	beq  $v0, 1, isPalindrome 
        
	# Loading base address of array into t3  
      	la $a1, array
      	add $t3, $a1, 0

	# Used to hold the next value
      	move $s7, $v0
      	move $t6, $v0
      	move $t5, $a1 
      
      	# Prompt the user to enter array elements
      	li $v0, 4
      	la $a0, elements
      	syscall
      
    # For loop for taking input into the array depending on the value of n
    forToGetInput:
      	li $v0, 5
      	syscall
      
      	sw $v0, 0($t3)
      	seq $t7, $t2, 1
      	beq $t7, 1, inputsTaken 
      	addi $t3, $t3, 4 
      	addi $t2, $t2, -1 
      	j forToGetInput
      
     inputsTaken:
      	li $v0,4
      	la $a0, displayArr
      	syscall
      	j forToDisplay
  
     # For loop to display array elements
     forToDisplay:     
     	lw $a0, 0($a1)
     	li $v0, 1
     	syscall
     
     	li $v0, 4
     	la $a0, space
     	syscall
     
     	beq $t6, 1, holdMiddleElement
     	addi $a1, $a1, 4
     	addi $t6, $t6, -1
     	j forToDisplay
  
    holdMiddleElement:
     	sra $t4, $s7, 1
     
    	j checkIfPalindrome
 
    checkIfPalindrome:
    	
	# Compare the first and last number of the array
    	lw $s4, 0($t5)
    	lw $s5, 0($a1)
    
    	bne $s4, $s5, notPalindrome
    	addi $t5, $t5, 4 
    	subi $a1, $a1, 4 
    	addi $t4,$t4, -1
    	beq  $t4, 0, isPalindrome
  
    	j checkIfPalindrome
    	beq $a1, $t4, isPalindrome
        
    isPalindrome:
     	la $a0, yesPal
     	j quit
 
   notPalindrome:
     	la $a0, noPal
     	j quit
     
   quit:
     	# This signals the end of program
     	li $v0, 4
     	syscall
     	li $v0,10
     	syscall		