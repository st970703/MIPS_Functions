
		.data
str1: 	.asciiz "Shervin was in the garden in the morning. "

		.text
		.globl main
		
main:
	la $a0, str1 # array base address should be in $a0
	ori $a1, $0, 254 # array size should be in $a1
	jal funct
	add $a0, $0, $v0
	ori $v0, $0, 1
	syscall # print the result
	li $v0, 10                                                                                                                                                               
    syscall
	
funct: 
# store first argument to temporary register
add $t0, $a0, $0
#store 253 to temporary register, the max length of array
addi $t1, $a1, 253
#initialise the result register
addi $v0, $0, 0

# store ASCII ‘i’ to temporary register
addi $t5, $0, 0x69
# store ASCII ‘n’ to temporary register
addi $t6, $0, 0x6E
# store ASCII ‘null’ to temporary register
addi $t7, $0, 0x00

L1:
# from temporary register
lb $t2, 0($t0)
# test if it is ‘i’
bne $t2, $t5, L2

# load next
lb $t3 ,1($t0) 

#check t3 is null
beq $t7, $t3, L3

# test if the next character is ‘n’
bne $t3, $t6, L2
# increment result by 1.
addi $v0, $v0, 1

L2:
#increment to point to next char
addi $t0, $t0, 1
#decrement loop counter
addi $t1, $t1, -1

#check loop counter is not zero
bne $t1, $0, L1
#check t2 is not null
bne $t7, $t2, L1

L3:
jr $ra
