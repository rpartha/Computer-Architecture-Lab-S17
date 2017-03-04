#THIS PROGRAM WILL GET THE SUM OF ALL NON-NEGATIVE NUMBERS <= N
.text
	.globl main

main:
	li $v0, 5 #get user input
	syscall
	move $t0, $v0  #n
	#slt $t1, $t0, $zero #if $t0 < 0
	#li $v1, 5  #system call code for error message
	#la $a0, error_msg #load address of error message into $a0
	#syscall
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
		error_msg: .asciiz "User entered negative integer!"
		total: .asciiz "Sum: "
