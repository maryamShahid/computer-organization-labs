	 .text
menu:	
	la $a0, msgOption1
	li $v0, 4
	syscall

	la $a0, msgOption2
	li $v0, 4
	syscall
	
	la $a0, msgOption3
	li $v0, 4
	syscall
	
	la $a0, msgOption4
	li $v0, 4
	syscall
	
	la $a0, exitOption
	li $v0, 4
	syscall
	
	la $a0, chooseOption
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	beq $v0, 1, createMatrixSizeN
	beq $v0, 2, displayElement
	beq $v0, 3, rowMajorSum
	beq $v0, 4, columnMajorSum
	beq $v0, 5, exit

	j menu
	
createMatrixSizeN:
	li $v0, 4
 	la $a0, promptForN 
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0    
	mul $s2, $s0, $s0 
	mul $a0, $s2, 4
	
	li $v0, 9
	syscall
	
	move $s1, $v0
	jal fillMatrix
 	j menu
 	
fillMatrix:
   	addi $sp, $sp, -12
  	sw $ra, 0($sp)
   	sw $s1, 4($sp)
   	sw $s2, 8($sp)
   	li $t1, 1

writeElements:
	sw $t1, 0($s1) 
	addi $s1, $s1, 4 
	addi $t1, $t1, 1 
	sle  $t3, $t1, $s2
	beq $t3, 1, writeElements
	
writingDone:
   	lw $s2, 8($sp)
  	lw $s1, 4($sp)
  	lw $ra, 0($sp)
        addi $sp, $sp, 12
   	jr $ra
  
displayElement:
	la $a0, enterRowNo
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t4, $v0 
	
	la $a0, enterColNo
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	move $t5, $v0 

 	addi $t4, $t4, -1 
 	mul $t4, $t4, $s0  
 	mul $t4, $t4, 4    
 	addi $t5, $t5, -1  
 	mul $t5, $t5, 4    
 	add $t4, $t4, $t5  
 	add $t3, $t4, $s1
 
 	la $a0, displayMsg
	li $v0, 4
	syscall
	
 	lw $a0, 0($t3)
 	li $v0, 1
 	syscall

	j menu

rowMajorSum:
	move $t0, $s1    
	mul $t1, $s0, $s0
	li $t2, 0 	
	
rowMajorLoop:
	lw $a0, ($t0)
	add $t2, $t2, $a0
		
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	bgt $t1, $0, rowMajorLoop

	la $a0, rowResult
	li $v0, 4
	syscall	
	
	move $a0, $t2
	li $v0, 1          
	syscall
	
 	j menu

columnMajorSum:
	li $t0, 1
	li $t1, 1 
	move $s2, $0 
	move $s3, $s1

columnMajorLoop:
	add  $s4, $t0, -1
	mul  $s5, $s0, 4
	mul  $s4, $s4, $s5
	
	add  $s6, $t1, -1
	mul  $s6, $s6, 4
	add  $s4, $s4, $s6
	
	add  $s3, $s3, $s4    
	lw   $a0, ($s3)
	add  $s2, $s2, $a0

	addi $t0, $t0, 1
	move $s3, $s1 
	addi $s7, $t0, -1
	bne  $s7, $s0, columnMajorLoop
	
	li   $t0, 1 
	addi $t1, $t1, 1
	addi $t3, $t1, -1 
	bne  $t3, $s0, columnMajorLoop

	la $a0, colResult
	li $v0, 4
	syscall

	addi $a0, $s2, 0
	li $v0, 1
	syscall
	
	j menu
	
exit:
	li $v0, 10
	syscall

	     .data
msgOption1:  .asciiz "\n1. Enter the matrix size in terms of its dimensions (N)"
msgOption2:  .asciiz "\n2. Display desired elements of the matrix by its row and column number"
msgOption3:  .asciiz "\n3. Obtain summation of matrix elements by row-major (row by row) summation"
msgOption4:  .asciiz "\n4. Obtain summation of matrix elements by column-major (column by column) summation"
exitOption:  .asciiz "\n5. Exit"
chooseOption:.asciiz "\nPlease choose one of the above: "
promptForN:  .asciiz "\nEnter N for dimension of matrix: "
enterRowNo:  .asciiz "\nEnter row number: "
enterColNo:  .asciiz "Enter column number: "
displayMsg:  .asciiz "Element in the given row/column is: "
rowResult:   .asciiz "Row-major summation: "
colResult:   .asciiz "Column-major summation: "