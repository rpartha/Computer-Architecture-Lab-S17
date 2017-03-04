#Used in assignment 4
#Registers used:
	#$t1 - used to hold the second number 
	#$t2 - used to hold the difference of $t1 and $t0
	#$v0 - syscall parameter and return value 
	#$a0 - syscall parameter 

.text
main:
#Get first number from user and place into $50
li $v0, 5 #load syscall read_int into $v0
syscall #make syscall 
move $t0, $v0 #move number read into $v0

#Get second number from user and place into $50
li $v0, 5 #load syscall read_int into $v0
syscall #make syscall 
move $t1, $v0 #move number read into $v0

sub $t2, $t0, $t1 #compute the difference 

##Print out $t2
move $a0, $t2 #move the number to print into $a0
li $v0, 1 #load syscall code 10 is for exit
syscall #make the syscall
li $v0, 10 #syscall code 10 is for exit
syscall #make the syscall

#end of Ex3.asm
