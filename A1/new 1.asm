# assume stored in column major format
calculate_element_of_Y:
# get the 5th argumentand put in in $t0. (size of row)
lw $t0, 0($sp)

#initialize FP register pairs $26, $27 with double value 1
addi $t6, $0, 1
mtc1 $t6, $f20
#convert to f26, f27 = 1.0
cvt.d.w $f26, f20

#initialize FP register pairs $28, $29 with double value 8
addi $t6, $0, 8
mtc1 $t6, $f20
#convert to f28, f29 = 8.0
cvt.d.w $f28, f20

# calculate the address of X[i][j]
# address of X[i][j] = base address of X + ((j * size of row) + i) * size of data
# (j * size of row)
mult $a3, $t0
# no overflow so, HI = 0
mflo $t1
# ((j * size of row) + i)
add $t1, $t1, $a2
# ((j * size of row) + i) * size of data
# size of data is 8 bytes = 8 bytes = 2 words
sll $t1, $t1, 3
# $t1 = address of X[i][j]
addu $t1, $t1, $a0

# read X[i][j] (the processor is little-endian)
# $f16,$f17 = X[i][j]
lwc1 $f16, 4($t1)
lwc1 $f17, 0($t1)

# $f16, $f17 = X[i][j] / 8
div.d $f16, $f16, $f28

# Y[i][j] = 1-(X[i][j]/8)
sub $f26 , $f26, $16

jr $ra
