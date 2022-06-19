# ############################################################### #
# Program 3A (finished)
# Eric Niemeyer 800037756
# 286_001 MWF 9am - 9:50am
# ############################################################### #   

.data

IP_ROUTING_TABLE_SIZE:
.word 22

IP_ROUTING_TABLE:
# line #, x.x.x.x -------------------------------------
.word 999, 146, 163, 255, 255 	# 146.163.255.255
.word 1, 147, 163, 255, 255 	# 147.163.255.255
.word 2, 201, 88, 88, 90 	# 201.88.88.90
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 3, 182, 151, 44, 56 	# 182.151.44.56
.word 4, 24, 125, 100, 100 	# 24.125.100.100
.word 10, 146, 163, 140, 80 	# 146.163.170.80
.word 11, 146, 163, 147, 80 	# 146.163.147.80
.word 12, 146, 164, 147, 80	# 146.164.147.80
.word 20, 148, 146, 170, 80 	# 148.146.170.80
.word 30, 193, 77, 77, 10 	# 193.77.77.10
.word 31, 193, 77, 77, 10 	# 193.77.77.10
.word 32, 193, 77, 77, 10 	# 193.77.77.10

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
MATCH:		.asciiz		"Match on line "
IPADDRESS:	.asciiz		", IP address is: "
NOTFOUND:	.asciiz		"Matching domain was NOT found."
SUCCESS:	.asciiz		"Program successfully completed."
LINE:		.asciiz		"______________________________"

.text
.globl main

main:

	subu $sp, $sp, 32

	sw $ra, 0($sp)	# save $ra

############ ENTER USER IP ############ 

# s1 = first ip num
# s2 = second num
# s3 = third num
# s4 = fourth num
# s5= 255
# s6 = 0
# s7 = 1

# t0 = i
# t1 = j
# t2 = IP_ROUTING_TABLE_SIZE (10)
# t3 = NUM_COLUMNS (5)

	li	$s6, 0
	li	$s7, 1
	li	$s5, 255
	li	$s8, 5
	la	$t2, IP_ROUTING_TABLE_SIZE
	lw	$t2, 0($t2)
	li	$t3, 5
	
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

############ DISPLAY USER IP ADDRESS ############

# s1 = first ip num
# s2 = second num
# s3 = third num
# s4 = fourth num
# s5= 255
# s6 = 0
# s7 = 1
# s8 = 5
# s9 = IP_ROUTING_TABLE_SIZE

# t0 = i
# t1 = j

		li $v0, 4		# string print message
		la $a0,	IPPRINT		# message
		syscall
		
	# start nums

		li $v0, 1		# int print message
		la $a0, ($s1)		
		syscall

		li $v0, 4		# string print message
		la $a0,	DOT		
		syscall

		li $v0, 1		# int print message
		la $a0, ($s2)		
		syscall

		li $v0, 4		# string print message
		la $a0,	DOT		
		syscall

		li $v0, 1		# int print message
		la $a0, ($s3)		
		syscall

		li $v0, 4		# string print message
		la $a0,	DOT		
		syscall

		li $v0, 1		# int print message
		la $a0, ($s4)		
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
# s8 = 5
# s9 = IP_ROUTING_TABLE_SIZE

# t0 = i
# t1 = j

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

##########################################
############ SEARCH FOR MATCH ############ 
##########################################

	li	$t0, 128
	blt	$s1, $t0, AAAA

	li	$t0, 192
	blt	$s1, $t0, BBBB

	li	$t0, 224
	blt	$s1, $t0, CCCC

	li	$t0, 240
	blt	$s1, $t0, DDDD

	li	$t0, 256
	blt	$s1, $t0, EEEE
	
##### s1.s2.s3.s4 #####
##### t1.t2.t3.t4 #####
#########################
	j AAJUMP
		AAAA:
# Class A Search:
# Check if first number of myIP matches with any first tableIP

la 	$t8, IP_ROUTING_TABLE	# load table


######### populating t0 - t1.t2.t3.t4 #########
li $t6, 0
# li $t7, 10 

la $t7, IP_ROUTING_TABLE_SIZE
aRows:

			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t0, $t5
			la $t8, 4($t8)

		# first

			lw $t5, ($t8)
	
			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t1, $t5
			la $t8, 4($t8)

		# second
	
			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t2, $t5
			la $t8, 4($t8)

		# third
			
			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t3, $t5
			la $t8, 4($t8)

		# fourth

			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t4, $t5
			la $t8, 4($t8)


	#### CHECK S v T #####
	#### XX - s1.s2.s3.s4 #####
	#### t0 - t1.t2.t3.t4 #####

	beq $s1, $t1, print

	######################

addi $t6, $t6, 1		
blt $t6, $t7, aRows







	AAJUMP:
#########################
	j BBJUMP
		BBBB:

la 	$t8, IP_ROUTING_TABLE	# load table

######### populating t0 - t1.t2.t3.t4 #########

li $t6, 0
# li $t7, 10 

la $t7, IP_ROUTING_TABLE_SIZE


bRows:

			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t0, $t5
			la $t8, 4($t8)

		# first

			lw $t5, ($t8)
	
			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t1, $t5
			la $t8, 4($t8)

		# second
	
			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t2, $t5
			la $t8, 4($t8)

		# third
			
			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t3, $t5
			la $t8, 4($t8)

		# fourth

			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t4, $t5
			la $t8, 4($t8)


	#### CHECK S v T #####
	#### XX - s1.s2.s3.s4 #####
	#### t0 - t1.t2.t3.t4 #####
	beq $s1, $t1, bbaby
	j BBBJ
	bbaby:
	beq $s2, $t2, print
	BBBJ:
	######################

addi $t6, $t6, 1		
blt $t6, $t7, bRows










	BBJUMP:
#########################
	j CCJUMP
		CCCC:
# Class C Search:



la 	$t8, IP_ROUTING_TABLE	# load table

######### populating t0 - t1.t2.t3.t4 #########

li $t6, 0
# li $t7, 10 

la $t7, IP_ROUTING_TABLE_SIZE

cRows:

			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t0, $t5
			la $t8, 4($t8)

		# first

			lw $t5, ($t8)
	
			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t1, $t5
			la $t8, 4($t8)

		# second
	
			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t2, $t5
			la $t8, 4($t8)

		# third
			
			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t3, $t5
			la $t8, 4($t8)

		# fourth

			lw $t5, ($t8)	

			li $v0, 1		# print int 	
			move $a0, $t5
			#syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			#syscall

			move $t4, $t5
			la $t8, 4($t8)


	#### CHECK S v T #####
	#### XX - s1.s2.s3.s4 #####
	#### t0 - t1.t2.t3.t4 #####
	beq $s1, $t1, CBABY
	j CCCJ
	CBABY:
	beq $s2, $t2, CSECOND
	j CCCJJJ
	CSECOND:
	beq $s3, $t3, print
	CCCJJJ:
	CCCJ:
	######################

addi $t6, $t6, 1		
blt $t6, $t7, cRows









	CCJUMP:
#########################
	j DDJUMP
		DDDD:
# Class D Search:







	DDJUMP:
#########################
	j EEJUMP
		EEEE:
# Class E Search:







	EEJUMP:

########### NO MATCH PRINT ##########

			li $v0, 4		# print string 
			la $a0, NOTFOUND
			syscall

			li $v0, 4		# print string 
			la $a0, ENDL
			syscall

			li $v0, 4		# print string 
			la $a0, ENDL
			syscall

################ PRINT BRANCH ################
j smallPrintJ
print:

			li $v0, 4		# print string 
			la $a0, MATCH		
			syscall

			li $v0, 1		# print int 	
			move $a0, $t0
			syscall

			li $v0, 4		# print string 
			la $a0, IPADDRESS
			syscall

			li $v0, 1		# print int 	
			move $a0, $t1
			syscall

			li $v0, 4		# print string 
			la $a0, DOT
			syscall

			li $v0, 1		# print int 	
			move $a0, $t2
			syscall

			li $v0, 4		# print string 
			la $a0, DOT
			syscall

			li $v0, 1		# print int 	
			move $a0, $t3
			syscall

			li $v0, 4		# print string 
			la $a0, DOT
			syscall

			li $v0, 1		# print int 	
			move $a0, $t4
			syscall


			li $v0, 4		# print string 
			la $a0, ENDL		
			syscall

			li $v0, 4		# print string 
			la $a0, ENDL		
			syscall


smallPrintJ:
############ END CARD ############ 


	li $v0, 4		# print string 
	la $a0, SUCCESS
	syscall

	li $v0, 4		# print string 
	la $a0, ENDL		
	syscall

	li $v0, 4		# print string 
	la $a0, LINE
	syscall

	li $v0, 4		# print string 
	la $a0, ENDL		
	syscall

	li $v0, 4		# print string 
	la $a0, ENDL		
	syscall


	lw $ra, 0($sp)	# restore $ra

	addu $sp, $sp, 32

	jr $31		# stops MAIN

############ End Program 3A ############


















