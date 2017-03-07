#THIS PROGRAM WILL GET THE SUM OF ALL NUMBERS <= N, N IS NON-NEGATIVE
.text
	.globl main

main:

li $t0, -1 #initialize $t0

getInput: #keep getting input until >= 0
		bgez $t0, loop #branch >= 0
		li $v0, 4
		la $a0, input
		syscall
		li $v0, 5 #get user input
		syscall
		move $t0, $v0  #n
		j getInput

li $t2, 0  #counter = i
li $t3, 0 #sum

loop:
	add $t3, $t3, $t2  #sum += i
	addi $t2, $t2, 1 #i = i + 1
	bge $t2, $t0, exit #i <= n
	j loop

exit:
	la $a0, total
	li $v0, 4
	syscall
	move $a0, $t3
	li $v0, 1
	syscall
	li $v0, 10
	syscall

	.data
		input: .asciiz "Enter a non-negative number:  \n"
		error_msg: .asciiz "User entered negative integer!"
		total: .asciiz "Sum: "
