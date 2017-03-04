#Ramaseshan Parthasarathy -- 157006637 -- Group 3 -- 02/14/15

.data 0x10000000
	ask: .asciiz "\nEnter a number between 0 and 50000: "
	ans: .asciiz "Answer: "
	
.text 0x00400000
.globl main
main:
		li $v0, 4
		la $a0, ask #load the ask string
		syscall #display ask string
		li $v0, 5 #Read input
		syscall
		move $t0, $v0 #n = $v0, move user input to $t0
		addi $t1, $0, 0 #i = 0
		addi $t2, $0, 1 #ans = 1, Starting case (n = 0) is 1
		li $t3, 3 #store 3 in $t3
loop:
	beq $t0, 1, END #i
		div $t0, $t3 #divde $t0 with $t3
		mfhi $t1 #store remainder to $t1
		beq $t1, $0, LABEL_1 #if remainder is 0, goto LABEL_1 
		addi $t0, $t0, -1 #we reduce $t0
		j loop #go back to loop

LABEL_1: mult $t2, $t0
			mflo $t2 #move from $LO to $t2
		 sub $t0, $t0, 1 #reduce $t0
		 
		 j loop #go back
END:
		li $v0, 4
		la, $a0, ans #Load ans string
		syscall
		move $a0, $t2 #Load answer
		li $v0, 1
		syscall
		li $v0, 10
		syscall
	