# This is a simple program which adds two single-precision floating-point
# floating-point numbers.

		.data

		.text
		.globl main
main:
	li $a0, 1 # load x
	li $a1, 8 # load y
	li $a2, 3 # load n
	
	jal funct
	
	add $a0, $0, $v0
	ori $v0, $0, 1
	syscall # print the result
	ori $v0, $0, 10                                                                                                                                                              
    syscall
	
funct: 
# store the arguments into temporary register
# store x
add $t0, $a0, $0

ori $t1, 0

#initialise the result register
ori $t7, $0, 0 # for 3x4
ori $t8, $0, 0 # for 2^n
ori $t9, $0, 0 # for range check

#store some integers to be used
addi $t3, $0, 1
addi $t4, $0, 3

# check x range
#check x < 10
slti $t9, $a0, 10
bne $t9, $t3, Exit 
# check if x > 0
blez $a0, Exit

# check n range
# check n < 7
slti $t9, $a2, 7
bne $t9, $t3, Exit 
# check n > 0
blez $a2, Exit

#multiply to get 3x and put back to register
mult $a0, $t4
# no overflow so, HI = 0
mflo $t0	

#multiply to get (3x)^2 
mult $t0, $t0
# no overflow so, HI = 0
mflo $t0

#multiply to get (3x)^4
mult $t0, $t0
# no overflow so, HI = 0
mflo $t0

#shift y right by n to get y/2^n
sra $t1, $a1, $a2

#initialise the result register
addi $v0, $0, 0

# z = 1
addi $v0, $v0, 1
#z = 1 + (3x)^4
add $v0, $v0, $t0
#z = 1 + (3x)^4+y/2^n
add $v0, $v0, $t1

Exit:
jr $ra



