# ############################################################### #
# Program 3A
# Eric Niemeyer 800037756
# 286_001 MWF 9am - 9:50am
# ############################################################### #   

.data

IP_ROUTING_TABLE_SIZE:
.word 10

IP_ROUTING_TABLE:
# line #, x.x.x.x -------------------------------------
.word 0, 146, 163, 255, 255 	# 146.163.255.255
.word 1, 147, 163, 255, 255 	# 147.163.255.255
.word 2, 201, 88, 88, 90 	# 201.88.88.90
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 4, 24, 125, 100, 100 	# 24.125.100.100
.word 10, 146, 163, 140, 80 	# 146.163.170.80
.word 11, 146, 163, 147, 80 	# 146.163.147.80
.word 12, 146, 164, 147, 80	# 146.164.147.80
.word 20, 148, 146, 170, 80 	# 148.146.170.80
.word 30, 193, 77, 77, 10 	# 193.77.77.10

ENTERIP:	.asciiz		"Enter an IP address: \n\n"
FIRST:		.asciiz		"   First: " 
SECOND:		.asciiz		"  Second: "
THIRD:		.asciiz		"   Third: "
FOURTH:		.asciiz		"  Fourth: "
IPPRINT:	.asciiz		"The IP address you entered: "
TOOBIG:		.asciiz		"The entered number is larger than 255. \n"
TOOSMALL:	.asciiz		"The entered number is less than 0. \n"
BADNUM:		.asciiz		"This number must be (0 - 255).\n"
BADNUM1:	.asciiz		"The first number must be (1 - 255).\n"
ENDL:		.asciiz		"\n"
DOT:		.asciiz		"."
CLASSA:		.asciiz		"Class A address."
CLASSB:		.asciiz		"Class B address."
CLASSC:		.asciiz		"Class C address."
CLASSD:		.asciiz		"Class D address."
CLASSE:		.asciiz		"Class E address."

.text
.globl main

main:

	subu $sp, $sp, 32

	sw $ra, 0($sp)	# save $ra

############ ENTER IP ############ 

# s1 = first ip num
# s2 = second num
# s3 = third num
# s4 = fourth num
# s5= 255
# s6 = 0
# s7 = 1

	li	$s6, 0
	li	$s7, 1
	li	$s5, 255
	
	##### SPLASH PROMPT #####
	
	li	$v0, 4
	la	$a0, ENTERIP	# prompt IP
	syscall





	##### FIRST NUM #####
		j FIRSTJUMP

			FIRSTBAD:

			li	$v0, 4
			la	$a0, BADNUM1	# bad input
			syscall
	
		FIRSTJUMP:
				li	$v0, 4
				la	$a0, FIRST	# first prompt
				syscall
	
				li	$v0, 5		# user input is in v0
				syscall
				move	$s1, $v0	# s1 has FIRST 

		##### FIRST CHECK #####

		blt	$s1, $s7, FIRSTBAD
		blt	$s5, $s1, FIRSTBAD


	##### SECOND NUM #####
		j SECONDJUMP

			SECONDBAD:

			li	$v0, 4
			la	$a0, BADNUM	
			syscall
	
		SECONDJUMP:
				li	$v0, 4
				la	$a0, SECOND	
				syscall
	
				li	$v0, 5		
				syscall
				move	$s2, $v0	 

		##### SECOND CHECK #####

		blt	$s2, $s6, SECONDBAD
		blt	$s5, $s2, SECONDBAD


	##### THIRD NUM #####
		j THIRDJUMP

			THIRDBAD:

			li	$v0, 4
			la	$a0, BADNUM
			syscall
	
		THIRDJUMP:
				li	$v0, 4
				la	$a0, THIRD	
				syscall
	
				li	$v0, 5		
				syscall
				move	$s3, $v0	

		##### THIRD CHECK #####

		blt	$s3, $s6, THIRDBAD
		blt	$s5, $s3, THIRDBAD


	##### FOURTH NUM #####
		j FOURTHJUMP

			FOURTHBAD:

			li	$v0, 4
			la	$a0, BADNUM	# bad input
			syscall
	
		FOURTHJUMP:
				li	$v0, 4
				la	$a0, FOURTH	# fourth prompt
				syscall
	
				li	$v0, 5		# user input is in v0
				syscall
				move	$s4, $v0	# s4 has FOURTH

		##### FOURTH CHECK #####

		blt	$s4, $s6, FOURTHBAD
		blt	$s5, $s4, FOURTHBAD


		li $v0, 4		# string print message
		la $a0, ENDL		# message
		syscall

############ DISPLAY IP ADDRESS ############

# s1 = first ip num
# s2 = second num
# s3 = third num
# s4 = fourth num
# s5= 255
# s6 = 0
# s7 = 1

		li $v0, 4		# string print message
		la $a0,	IPPRINT		# message
		syscall
		
		li $v0, 1		# int print message
		la $a0, ($s1)		# xyz counter
		syscall

		li $v0, 4		# string print message
		la $a0,	DOT		# message
		syscall

		li $v0, 1		# int print message
		la $a0, ($s2)		# xyz counter
		syscall

		li $v0, 4		# string print message
		la $a0,	DOT		# message
		syscall

		li $v0, 1		# int print message
		la $a0, ($s3)		# xyz counter
		syscall

		li $v0, 4		# string print message
		la $a0,	DOT		# message
		syscall

		li $v0, 1		# int print message
		la $a0, ($s4)		# xyz counter
		syscall


		li $v0, 4		# string print message
		la $a0, ENDL		# message
		syscall

		li $v0, 4		# string print message
		la $a0, ENDL		# message
		syscall

############ FIND AND PRINT CLASS ############ 

# s1 = first ip num
# s2 = second num
# s3 = third num
# s4 = fourth num
# s5= 255
# s6 = 0
# s7 = 1

	li	$t0, 128
	blt	$s1, $t0, AAA

	li	$t0, 192
	blt	$s1, $t0, BBB

	li	$t0, 224
	blt	$s1, $t0, CCC

	li	$t0, 240
	blt	$s1, $t0, DDD

	li	$t0, 256
	blt	$s1, $t0, EEE
	

	j AJUMP
		AAA:
		li $v0, 4		# string print message
		la $a0,	CLASSA		# message
		syscall
	AJUMP:
	
	j BJUMP
		BBB:
		li $v0, 4		# string print message
		la $a0,	CLASSB		# message
		syscall
	BJUMP:
	
	j CJUMP
		CCC:
		li $v0, 4		# string print message
		la $a0,	CLASSC		# message
		syscall
	CJUMP:
	
	j DJUMP
		DDD:
		li $v0, 4		# string print message
		la $a0,	CLASSD		# message
		syscall
	DJUMP:

	j EJUMP
		EEE:
		li $v0, 4		# string print message
		la $a0,	CLASSE		# message
		syscall
	EJUMP:


		li $v0, 4		# string print message
		la $a0, ENDL		# message
		syscall

		li $v0, 4		# string print message
		la $a0, ENDL		# message
		syscall

############ END ############ 

	lw $ra, 0($sp)	# restore $ra

	addu $sp, $sp, 32

	jr $31		# stops MAIN

############ End Program 3A ############


















