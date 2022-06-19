# ############################################################### #
# Program 3A
# Eric Niemeyer 800037756
# 286_001 MWF 9am - 9:50am
# ############################################################### #   

.data

ENTERIP:	.asciiz		"Enter an IP address: \n"
FIRST:		.asciiz		"   First: " 
SECOND:		.asciiz		"  Second: "
THIRD:		.asciiz		"   Third: "
FOURTH:		.asciiz		"  Fourth: "
ENDL:		.asciiz		"\n"

.text
.globl main

main:

	subu $sp, $sp, 32

	sw $ra, 0($sp)	# save $ra

############ ENTER IP ############ 
	
	li	$v0, 4
	la	$a0, ENTERIP # prompt IP
	syscall




############ END ############ 

	lw $ra, 0($sp)	# restore $ra

	addu $sp, $sp, 32

	jr $31		# stops MAIN

############ End Program 3A ############