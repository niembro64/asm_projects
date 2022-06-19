# ############################################################### #
# Program 1 Part 2
# Eric Niemeyer 800037756
# 286_001 MWF 9am - 9:50am
# ############################################################### #   

.data

ENDL:			.asciiz		"\n"
ASKFIRSTNUMBER:		.asciiz		"Enter the first number (0-50): "
ASKSECONDNUMBER:	.asciiz		"Enter the second number (0-50): "
TELLNOTOK:		.asciiz		"The number entered is not in 0-50. Enter another number. \n"
ZERO:			.asciiz		"0"
LESSTHANMIN:		.asciiz		"The entered number is less than 0.\n"
GREATERTHANMAX:		.asciiz		"The entered number is greater than 50.\n"

.text
.globl main

main:

# GET FIRST NUMBER ###############################################

		FIRSTNOTOK:
	li	$v0, 4		
	la 	$a0, ASKFIRSTNUMBER	
	syscall

	li	$v0, 5		# load user input
	syscall
	move	$t0, $v0

	li	$v0, 4
	la	$a0, ENDL
	syscall

	li 	$t1, 0		# initialize to zero
	li	$t2, 0
	slt	$t1, $t0, 0
	sgt	$t2, $t0, 50
	or	$t3, $t2, $t1	# t5 is 1 if problem
	
	beq $t3, 0, FIRSTOK

#		li	$v0, 4
#		la	$a0, TELLNOTOK
#		syscall

			beq $t1, 0, NOTLESS
				li $v0, 4
				la $a0, LESSTHANMIN
				syscall
			NOTLESS:
			beq $t2, 0, NOTGREATER
				li $v0, 4
				la $a0, GREATERTHANMAX
				syscall
			NOTGREATER:
		j FIRSTNOTOK
	FIRSTOK:

# GET SECOND NUMBER ###############################################

		SECONDNOTOK:
	li	$v0, 4		
	la 	$a0, ASKSECONDNUMBER	
	syscall

	li	$v0, 5		# load user input
	syscall
	move	$t4, $v0

	li	$v0, 4
	la	$a0, ENDL
	syscall

	li 	$t1, 0		# initialize to zero
	li	$t2, 0
	slt	$t1, $t4, 0
	sgt	$t2, $t4, 50
	or	$t3, $t2, $t1	# t5 is 1 if problem
	
	beq $t3, 0, SECONDOK

			beq $t1, 0, NOTLESSB
				li $v0, 4
				la $a0, LESSTHANMIN
				syscall
			NOTLESSB:
			beq $t2, 0, NOTGREATERB
				li $v0, 4
				la $a0, GREATERTHANMAX
				syscall
			NOTGREATERB:

		j SECONDNOTOK
	SECONDOK:

# MULTIPLY ###############################################

	# $t0 and $t4 have numbers to multiply
	# modify $t5 for product

	li	$t5, 0
	li	$t6, 1
		
		MULTLOOP:	
	add	$t5, $t5, $t4
	sub	$t0, $t0, $t6

	beq $t0, 0, BREAKMULT
		
		j MULTLOOP
		
	BREAKMULT:
			

	li	$v0, 1
	move 	$a0, $t5
	syscall



		jr $31		# stops the program

# End Program 1 Part 1 ###############################################