		.data

		.text
		.globl main
main:
	# load x
	li $a0, 4 
	# load y
	li $a1, 4096 
	# load n
	li $a2, 5 
	
	jal funct
	
	add $a0, $0, $v0
	ori $v0, $0, 1
	syscall # print the result
	ori $v0, $0, 10                                                                                                                                                              
    syscall
	
funct:
#initialise the result register
addi $v0, $0, 0

# store the arguments into temporary register
# store x
add $t0, $a0, $0

addi $t1, 0

#initialise the registers
addi $t7, $0, 0 # for 3x4
addi $t8, $0, 0 # for 2^n
addi $t9, $0, 0 # for range check

#store some integers to be used
addi $t3, $0, 1
addi $t4, $0, 3

# check x range
#check x < 10
slti $t9, $a0, 10
bne $t9, $t3, Exit 
# check if x > 0
blez $a0, Exit

# check if y > 0
blez $a1, Exit

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
srav $t1, $a1, $a2

# z = 1
addi $v0, $v0, 1
#z = 1 + (3x)^4
add $v0, $v0, $t0
#z = 1 + (3x)^4+y/2^n
add $v0, $v0, $t1

Exit:
jr $ra