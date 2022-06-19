# ############################################################### #
# Program 1 Part 1
# Eric Niemeyer 800037756
# 286_001 MWF 9am - 9:50am
# ############################################################### #   

.data

ASKYOURSPEED:	.asciiz "Enter your current driving speed in MPH (1 - 200): "
ASKSPEEDLIMIT:	.asciiz "Enter the absolute speed limit for the road you are currently running on (15 - 70): "
RPT1:		.asciiz "You made an invalid input for "
RPT2:		.asciiz " Enter a valid input for "
RPTSPEED:	.asciiz	"your current driving speed."
RPTLIMIT:	.asciiz "the speed limit for the road."
OK:		.asciiz "You are a safe driver!"
FINE120:	.asciiz "$120 fine"
FINE140:	.asciiz "$140 fine"
FINEB:		.asciiz "Class B misdemeanor and carries up to six months in jail and a maximum $1,500 in fines"
FINEA:		.asciiz "Class A misdemeanor and carries up to one year in jail and a maximum $2,500 in fines"
ENDLINE:	.asciiz "\n"

# var1:	.word	1
# var2:	.word	200
# var3:	.word	15
# var4:	.word	70

.text
.globl main

main:	
	
#################### SPEED CHECK ####################
			
		RPTSJ:
	li $v0, 4               # system call #4 (print message)
	la $a0, ASKYOURSPEED	# mem add of 1st char
	syscall			

	li $v0, 5		# system call #5 (user input)
	syscall
	move $t0, $v0		# put yourspeed into t0
	
		li $t4, 0	# set t6 to 1 if current speed too high or too low
		slt $t4, $t0, 1
		li $t5, 0
		sgt $t5, $t0, 200
		or $t6, $t4, $t5

	beq $t6, 0, YOURSPEEDJ		
	
		li $v0, 4               # system call #4 (print message)
		la $a0, RPT1		# mem add of 1st char
		syscall	
		
		li $v0, 4               # system call #4 (print message)
		la $a0, RPTSPEED	# mem add of 1st char
		syscall				
	
		li $v0, 4               # system call #4 (print message)
		la $a0, RPT2		# mem add of 1st char
		syscall	
		
		li $v0, 4               # system call #4 (print message)
		la $a0, RPTSPEED	# mem add of 1st char
		syscall	

		li $v0, 4		#ENDL
		la $a0, ENDLINE
		syscall
		
		j RPTSJ
	YOURSPEEDJ:




#################### LIMIT CHECK ####################

		RPTLJ:
	li $v0, 4		# system call #4 (print message)
	la $a0, ASKSPEEDLIMIT	# mem add of 1st char
	syscall

	li $v0, 5		# system call #5 (user input)
	syscall
	move $t1, $v0		# put speedlimit into t1
	
		li $t4, 0	# set t6 to 1 if limit is too high or too low
		slt $t4, $t1, 15
		li $t5, 0
		sgt $t5, $t1, 70
		li $t6, 0
		or $t6, $t4, $t5

	beq $t6, 0, LIMITJ		

		li $v0, 4               # system call #4 (print message)
		la $a0, RPT1		# mem add of 1st char
		syscall	
		
		li $v0, 4               # system call #4 (print message)
		la $a0, RPTLIMIT	# mem add of 1st char
		syscall				
	
		li $v0, 4               # system call #4 (print message)
		la $a0, RPT2		# mem add of 1st char
		syscall	
		
		li $v0, 4               # system call #4 (print message)
		la $a0, RPTLIMIT	# mem add of 1st char
		syscall	
		
		li $v0, 4		#ENDL
		la $a0, ENDLINE
		syscall

		j RPTLJ
	LIMITJ:



		
	bgt $t0, $t1, TFASTJ	# too fast ? branch : keep going

		li $v0, 4	# system call #4 (print message)
		la $a0, OK	# mem add of 1st char
		syscall

		j  ENDING

	TFASTJ: 

#################### PENALTIES ####################
		sub $t3, $t0, $t1	# t3 is difference in speed
		
			# 1-20 120
				li $t4, 0	# set t6 to 1 if limit is too high or too low
				slt $t4, $t3, 1
				li $t5, 0
				sgt $t5, $t3, 20
				li $t6, 0
				or $t6, $t4, $t5
			beq $t6, 1, NOT120	
				li $v0, 4	# system call #4 (print message)
				la $a0, FINE120	# mem add of 1st char
				syscall
			NOT120:
			
			# 21-25 140
				li $t4, 0	# set t6 to 1 if limit is too high or too low
				slt $t4, $t3, 21
				li $t5, 0
				sgt $t5, $t3, 25
				li $t6, 0
				or $t6, $t4, $t5
			beq $t6, 1, NOT140	
				li $v0, 4	# system call #4 (print message)
				la $a0, FINE140	# mem add of 1st char
				syscall
			NOT140:

			# 26-34	b misdemeanor
				li $t4, 0	# set t6 to 1 if limit is too high or too low
				slt $t4, $t3, 26
				li $t5, 0
				sgt $t5, $t3, 34
				li $t6, 0
				or $t6, $t4, $t5
			beq $t6, 1, NOTB	
				li $v0, 4	# system call #4 (print message)
				la $a0, FINEB	# mem add of 1st char
				syscall
			NOTB:

			# 35+	a misdemeanor
				li $t4, 0	# set t6 to 1 if limit is too high or too low
				slt $t4, $t3, 35
				li $t5, 0
				
				li $t6, 0
				or $t6, $t4, $t5
			beq $t6, 1, NOTA	
				li $v0, 4	# system call #4 (print message)
				la $a0, FINEA	# mem add of 1st char
				syscall
			NOTA:

		
#################### END STUFF ####################		
ENDING:	
		li $v0, 4
		la $a0, ENDLINE
		syscall

		jr $31			# stop the program

# End Program 1 Part 1 ###############################################
