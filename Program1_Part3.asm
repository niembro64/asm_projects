# ############################################################### #
# Program 1 Part 3
# Eric Niemeyer 800037756
# 286_001 MWF 9am - 9:50am
# ############################################################### #   

.data

ENDL:			.asciiz		"\n"
PRINTONE:	.asciiz	"month "
PRINTTWO:	.asciiz	": current principal = "
OUTRANGE:	.asciiz "The value you have entered is out of range. \n"
ASKP:	.asciiz	"Enter the principal in $ (100.00 - 1,000,000.00): "
ASKI:	.asciiz	"Enter the annual interest rate (0.005 - 0.399): "
ASKM:	.asciiz	"Enter the monthly payment amount in $ (1.00 - 2,000.00): "
ENDCARDONE:	.asciiz "\nIt will take "
ENDCARDTWO:	.asciiz " months to complete the loan. "

THIRTY:	.float	30.0
THREESIXTY: .float 360.0
PMIN:	.float	100.0
PMAX:	.float	1000000.0
IMIN:	.float	0.005
IMAX:	.float	0.399
MMIN:	.float	1.0
MMAX:	.float	2000.0
FZERO:	.float	0.0
ASDF:	.float	0.082190377381


.text
.globl main

main:

	# li $v0, 2		# print float that is
	# l.s $f12, PRINCIPAL 	# stored in f12
	# syscall		# do it

	# li $v0, 2		# print float that is
	# mov.s $f12, $f1	# stored in f12
	# syscall		# do it

	#li	$v0, 6		# take float, store in f0
	#syscall			# do it

	#mov.s	$f1, $f0	# move float
	
	#c.lt.d $f1, $f4 	# if less than 
	#bc1t PBAD		# branch to 
	
	#l.s $f4, FZERO		# load float
	#lwc1 $f4, FZERO	# load float

	l.s $f4, FZERO
	
############ GET PRINCIPAL ############

# Input Stored	f0
# Principal	f1
# Ann Int Rate	f2
# Monthly Pay	f3
# Zero at	f4
# Temp Limit	f5
# Output From	f12 

	
		j PJUMP		# skip error
			PBAD:	# error
			
			
			li	$v0, 4
			la	$a0, OUTRANGE
			syscall
			
		PJUMP:

	li	$v0, 4
	la	$a0, ASKP	# prompt principal
	syscall

	li	$v0, 6		# user input is in f0
	syscall
	mov.s	$f1, $f0	# f1 has principal	

	l.s	$f5, PMIN
	c.lt.s	$f1, $f5 
	bc1t PBAD		# too low -> error

	l.s	$f5, PMAX
	c.lt.s	$f5, $f1
	bc1t PBAD		# too high -> error
	
############ GET ANNUAL INTEREST RATE ############

# Input Stored	f0
# Principal	f1
# Ann Int Rate	f2
# Monthly Pay	f3
# Zero at	f4
# Temp Limit	f5
# Output From	f12 

	
		j IJUMP		# skip error
			IBAD:	# error
			
			
			li	$v0, 4
			la	$a0, OUTRANGE
			syscall
			
		IJUMP:

	li	$v0, 4
	la	$a0, ASKI	# prompt principal
	syscall

	li	$v0, 6		# user input is in f0
	syscall
	mov.s	$f2, $f0	# f2 has interest

	l.s	$f5, IMIN
	c.lt.s	$f2, $f5 
	bc1t IBAD		# too low -> error

	l.s	$f5, IMAX
	c.lt.s	$f5, $f2
	bc1t IBAD		# too high -> error

############ GET MONTHLY PAYMENT ############

# Input Stored	f0
# Principal	f1
# Ann Int Rate	f2
# Monthly Pay	f3
# Zero at	f4
# Temp Limit	f5
# Output From	f12 

	
		j MJUMP		# skip error
			MBAD:	# error
			
			
			li	$v0, 4
			la	$a0, OUTRANGE
			syscall
			
		MJUMP:

	li	$v0, 4
	la	$a0, ASKM	# prompt principal
	syscall

	li	$v0, 6		# user input is in f0
	syscall
	mov.s	$f3, $f0	# f3 has monthly

	l.s	$f5, MMIN
	c.lt.s	$f3, $f5 
	bc1t MBAD		# too low -> error

	l.s	$f5, MMAX
	c.lt.s	$f5, $f3
	bc1t MBAD		# too high -> error
	
############ LOOP MATH PRINT ############

# Input Stored	f0
# Principal	f1
# Ann Int Rate	f2
# Monthly Pay	f3
# Zero at	f4
# Temp Limit	f5
# Month Number		t5
# Curr Princip	f7
# Monthly Intst	f8
# AmntPay2Princpf9
# temp math	f10
# temp math	f11
# Output From	f12

	li $t5, 1
	mov.s $f7, $f1	# initialize current principal
	mov.s $f6, $f4	# initialize month

		MONTHLOOP:

	
	#### PRINT ####

		li	$v0, 4
		la	$a0, PRINTONE
		syscall

		li $v0, 1	# print int
		la $a0, ($t5)	# stored in 
		syscall		# do it

		li	$v0, 4
		la	$a0, PRINTTWO
		syscall

		li $v0, 2	# print float that is
		mov.s $f12, $f7	# stored in 
		syscall		# do it

		li	$v0, 4
		la	$a0, ENDL
		syscall

	#### MATH ####
		move $t4, $t5
		addi $t5, $t5, 1	# month++

	# Monthly Interest Rate
	# $f8 = $f7 * $f2 * 30/360 # ASDF (#.0821917808)
			#l.s $f5, THIRTY
			#l.s $f11, THREESIXTY
			#div.s	$f10, $f5, $f11
		l.s 	$f10, ASDF
		mul.s	$f5, $f2, $f10
		mul.s	$f8, $f5, $f7	# f8 contains mo interest rate


	# Amount for Paying to the Principal
	# $f9 = $f3 - $f8	
		sub.s	$f9, $f3, $f8

	# Remaining Principal
	# $f7 = $f7 - $f9
		mov.s	$f10, $f7
		sub.s	$f7, $f10, $f9


		c.lt.s	$f4, $f7
		bc1t MONTHLOOP		# too high -> error
	
		DONE:

		move $t4, $t5
		addi $t5, $t5, -1	# month++

############ End Card ############

	li	$v0, 4		
	la 	$a0, ENDCARDONE	
	syscall

	li	$v0, 1		
	la 	$a0, ($t5)	
	syscall

	li	$v0, 4		
	la 	$a0, ENDCARDTWO	
	syscall

############ End Program 1 Part 3 ############

jr $31		# stops the program