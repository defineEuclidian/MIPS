# Finding square root using Newton's method
# $f0 is the estimate ($f0^2 ~= $f2)
# $f2 is the floating point number to find the square root for
# $f4 is equal to 2, as the derivative of x^2 is 2x

li $s0, 0
li $s1, 5

FOR:

mul.d $f6, $f0, $f0
sub.d $f8, $f6, $f2
mul.d $f10, $f4, $f0
div.d $f12, $f8, $f10

sub.d $f0, $f0, $f12

li $v0, 1
add $a0, $s0, $zero
syscall

li $v0, 11
li $a0, 58
syscall

li $v0, 11
li $a0, 32
syscall

li $v0, 3
add.d $f12, $f0, $f14
syscall

li $v0, 11
li $a0, 10
syscall

addi $s0, $s0, 1
beq $s0, $s1, END
j FOR

END:

li $v0, 11
li $a0, 70
syscall

li $v0, 11
li $a0, 58
syscall

li $v0, 11
li $a0, 32
syscall

li $v0, 3
add.d $f12, $f0, $f14
syscall

li $v0, 11
li $a0, 10
syscall
