# This is a simple program which adds two single-precision floating-point
# floating-point numbers.

		.data
str1: 	.asciiz "Betty Helped him. "

		.text
		.globl main
main:
	la $a0, str1 # array base address should be in $a0
	ori $a1, $0, 20 # array size should be in $a1
	jal func1
	add $a0, $0, $v0
	ori $v0, $0, 1
	syscall # print the result
	li $v0, 10                                                                                                                                                               
    syscall
func1: 
	# base address of the string is in reg. $a0
	# Size of array in reg. $a1 and no. of 'H' or ‘h’ or ‘B’ letters is returned in reg. $v0
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	add $t0, $a0, $0 # save $a0
	add $t1, $a1, $0 # save $a1
	addi $v0, $0, 0 # initialize $v0
	addi $t5, $0, 0x48 # ASCII code of letter H
	addi $t6, $0, 0x42 # ASCII code of letter B
	addi $t7, $0, 0x68 # ASCII code of letter h
L1: 
	lbu $t2, 0($t0)
	beq $t2, $t5, L2 # test if it is letter 'H'
	beq $t2, $t6, L2 # test if it is letter 'B'
	bne $t2, $t7, L3 # test if it is letter 'h' or not
L2: 
	addi $v0, $v0, 1 # if the right char increment the counter
L3:
	addi $t0, $t0, 1 # increment $t0 to point to the next char
	addi $t1, $t1, -1
	bne $t1, $0, L1 # exit the loop if end of string
	
	
	jr $ra