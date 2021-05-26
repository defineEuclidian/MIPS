# MIPS Selection Sort; O(n^2) average

##### $s1 is the size of allocated stack; change allocation size here with increments of 4, as 4 bytes is one integer
##### $s1 also acts as the terminating condition for later iterators (with beq)
li $s1, 48
#####

# Allocate $s1 bytes of stack space for ($s1 / 4) words/integers
sub $sp, $sp, $s1

##### Add code here to insert additional integers
## Each two line insertion code snippet is in the following form:
# li $t0, x
# sw $t0, y($sp)
## x is the integer to insert, y is the index starting from 0 and incrementing by 4, so 0, 4, 8, 12, etc

li $t0, 9
sw $t0, 0($sp)

li $t0, -1
sw $t0, 4($sp)

li $t0, 10
sw $t0, 8($sp)

li $t0, -9
sw $t0, 12($sp)

li $t0, 9
sw $t0, 16($sp)

li $t0, -1
sw $t0, 20($sp)

li $t0, 10
sw $t0, 24($sp)

li $t0, -9
sw $t0, 28($sp)

li $t0, 9
sw $t0, 32($sp)

li $t0, -1
sw $t0, 36($sp)

li $t0, 10
sw $t0, 40($sp)

li $t0, -9
sw $t0, 44($sp)

###########################

# Call PRINTSTACK function
jal PRINTSTACK

# Print a new line twice
li $v0, 11
li $a0, 10
syscall

li $v0, 11
li $a0, 10
syscall

# $s0 is the main iterator which will keep track of what number will be swapped
li $s0, 0

iFOR:
beq $s0, $s1, iEND

# Retrieve integer stored at index $s0 in $sp and store in $t0, then go back to starting index
add $sp, $sp, $s0
lw $t0, ($sp)
sub $sp, $sp, $s0
	
	# $s2 is the iterator for the second nested loop, which will keep track of integers after $s0 that could be swapped
	# Also, change the starting index of $sp to each integer to the right of the current $s0 index integer
	add $s2, $s0, 4
	add $sp, $sp, $s2
	
	kFOR:
	beq $s2, $s1, kEND
	
	# Load integer located at index $s2 into $t1
	lw $t1, ($sp)
	
	# Check if $t1 < $t0; if not true, skip all swapping operations
	slt $t2, $t1, $t0
	beq $t2, $zero, kFORSkip
	
	# Print integer stored in $t0
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	# Print a space
	li $v0, 11
	li $a0, 32
	syscall
	
	# Print integer stored in $t1
	li $v0, 1
	add $a0, $zero, $t1
	syscall
	
	li $v0, 11
	li $a0, 10
	syscall
	
	# Call SWAP function with parameter $t0 into argument $a1 and parameter $t1 into argument $a2
	add $a1, $zero, $t0
	add $a2, $zero, $t1
	jal SWAP
	add $t0, $zero, $a1
	add $t1, $zero, $a2
	
	# Store swapped $t1 integer at current $sp index
	sw $t1, ($sp)
	
	# Decrement current $sp index back to $s0 from $s2, store integer from $t0 into reverted $sp index, then increment to original index
	sub $t2, $s2, $s0
	sub $sp, $sp, $t2
	sw $t0, ($sp)
	add $sp, $sp, $t2
	
	kFORSkip:
	
	# Increment $s2 iterator and $sp index, then repeat all previous operations within this loop
	addi $s2, $s2, 4
	addi $sp, $sp, 4
	j kFOR
	kEND:
	
	# Reset $s2 iterator and $sp index back to 0, for the next main iteration
	li $s2, 0
	sub $sp, $sp, $s1

# Increment $s0 iterator, then repeat all previous operations
addi $s0, $s0, 4
j iFOR
iEND:

li $v0, 11
li $a0, 10
syscall

jal PRINTSTACK

# Deallocate stack space
add $sp, $sp, $s1

# Terminate program
li $v0, 10
syscall

# SWAP function; arguments are $a1 and $a2 for registers to swap values with
SWAP:
	add $t0, $zero, $a1
	add $a1, $zero, $a2
	add $a2, $zero, $t0
	jr $ra

# PRINTSTACK function; void function with $s1 as a global variable/register; $sp index must be at 0
PRINTSTACK:
	# $t0 is the main iterator which will keep track of what integer will be printed
	li $t0, 0
	
	PRINTloop:
	beq $t0, $s1, PRINTloopEND
	
	# Print integer at current $sp index
	li $v0, 1
	lw $a0, ($sp)
	syscall
	
	# Print a space
	li $v0, 11
	li $a0, 32
	syscall
	
	addi $sp, $sp, 4
	addi $t0, $t0, 4
	j PRINTloop
	PRINTloopEND:
	
	# Reset $sp index
	sub $sp, $sp, $s1
	
	jr $ra
