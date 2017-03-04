#Ramaseshan Parthasarathy -- 157006637 -- Group 3 -- 02/14/15

#GET NAME FROM USER INPUT AND PRINT IT OUT

.text
	.globl main

main:
	la $a0, input #load and print input message
	li $v0, 4
	syscall

	li $v0, 8 #get input
	la $a0, buff #load space into buffer
	li $a1, 255 #allocate space for input string
	move $t0, $a0 #save string
	syscall 
	
	la $a0, output #load and print name
	li $v0, 4
	syscall
	
	la $a0, buff #(re)load space to buffer (primary addr)
	move $a0, $t0 #set primary addr to that of $t0
	li $v0, 4 #print name
	syscall

END:	
	li $v0, 10 
	syscall

	.data 
		buff: .space 255
		input: .asciiz "Enter your name: "
		output: .asciiz "Your name is "
	
	
	

