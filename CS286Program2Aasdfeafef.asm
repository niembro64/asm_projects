# ############################################################### #
# Program 2B
# Eric Niemeyer 800037756
# 286_001 MWF 9am - 9:50am
# ############################################################### #   

.data

PRINTGET1:	.asciiz		"Enter the first number (1-9999): "
PRINTGET2:	.asciiz		"Enter the second number (1-9999): "
OUTRANGE:	.asciiz		"The value you have entered is out of range. \n"
RECROUND:	.asciiz		"Recursive Round: "
GCDPRINT:	.asciiz		"GCD: "
ENDL:		.asciiz		"\n"

.text
.globl main

main:
	subu $sp, $sp, 32

	sw $ra, 0($sp)	# save $ra

############ GET FIRST NUMBER (1-9999) ############

		j FJUMP		# skip error
			FBAD:	# error
			
			li	$v0, 4
			la	$a0, OUTRANGE
			syscall
			
		FJUMP:

	li	$v0, 4
	la	$a0, PRINTGET1	# prompt FIRST 
	syscall

	li	$v0, 5		# user input is in v0
	syscall
	move	$t1, $v0	# f1 has FIRST 

	li	$t5, 1
	blt	$t1, $t5, FBAD 	# too low -> error	

	li	$t5, 9999
	blt	$t5, $t1, FBAD	# too high -> error
	
# FIRST NUM	t1

############ GET SECOND NUMBER (1-9999) ############



		j SJUMP		# skip error
			SBAD:	# error
			
			li	$v0, 4
			la	$a0, OUTRANGE
			syscall
			
		SJUMP:

	li	$v0, 4
	la	$a0, PRINTGET2	# prompt FIRST 
	syscall

	li	$v0, 5		# user input is in v0
	syscall
	move	$t2, $v0	# f1 has SECOND

	li	$t5, 1
	blt	$t2, $t5, SBAD 	# too low -> error	

	li	$t5, 9999
	blt	$t5, $t2, SBAD	# too high -> error
		

# FIRST NUM	t1
# SECOND NUM	t2

############ ORGANIZE & SUBCALL ############ 
	
	move $s1, $t1
	move $s2, $t2	

	li $s0, 0	# initialize subroutine counter to zero

	li $s4, 0
	li $s5, 1

	li $v0, 4		# string print message
	la $a0,	ENDL		# ENDL
	syscall

# XYZ COUNTER	s0
# FIRST NUM	s1
# SECOND NUM	s2
# REMAINDER	s3
# 0		s4
# 1		s5

	jal xyz

	j ENDJ
	
########################################
############ SUBROUTINE XYZ ############
########################################

xyz:

# XYZ COUNTER	s0
# FIRST NUM	s1
# SECOND NUM	s2
# REMAINDER	s3
# 0		s4
# 1		s5
# GCD		s6

	subu $sp, $sp, 32

	sw $ra, 0($sp)	# save $ra

	sw $s0, 4($sp)	#save $s0
	sw $s1, 8($sp)	#save $s1
	sw $s2, 12($sp)	#save $s2
	sw $s3, 16($sp)	#save $s3
	
		#### PRINT RECROUND ####

		addi $s0, $s0, 1	# increment xyz counter
			
		li $v0, 4		# string print message
		la $a0,	RECROUND	# message
		syscall

		li $v0, 1		# int print message
		la $a0, ($s0)		# xyz counter
		syscall

		li $v0, 4		# string print message
		la $a0,	ENDL		# ENDL
		syscall

		########################

		div $s1, $s2		# divide $s1 by $s2
		mfhi $s3		# copy the remainder to $s3
		
				beq $s3, $s4, SUBJ

					move $s1, $s2		# n2 becomes n1
					move $s2, $s3		# remainder becomes n2

					jal xyz

				SUBJ:

	lw $s3, 16($sp)		#restore $s3
	# lw $s2, 12($sp)	#no restore $s2
	lw $s1, 8($sp)		#restore $s1
	lw $s0, 4($sp)		#restore $s0

	lw $ra, 0($sp)	# restore $ra

	addu $sp, $sp, 32

# GCD		s6

jr $ra

############ DO PRINTS ############ 

	ENDJ:

	li $v0, 4		# string print message
	la $a0,	ENDL		# ENDL
	syscall

	li $v0, 4
	la $a0, GCDPRINT
	syscall
	
	li $v0, 1
	la $a0, ($s2)
	syscall

	lw $ra, 0($sp)	# restore $ra

	addu $sp, $sp, 32

	jr $31		# stops MAIN

############ End Program 2A ############