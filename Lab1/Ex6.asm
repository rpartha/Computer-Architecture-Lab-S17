#This code is used for assignment 5
#TASK: GET 4 USER INPUTS AND CALCULATE THE SUM OF DIFFERENCES AMONG ALL THE POSSIBLE PAIRS

.data 0x10000000
	first: .asciiz "\nEnter a number: "
	second: .asciiz "\nEnter a second number: "
	third: .asciiz "\nEnter a third number: "
	fourth: .asciiz "\nEnter the last number: "
	arr: .space 16
.text
	.align 2
	.globl main

main:
	li $v0, 4
	la $a0, first
	syscall
	li $v0, 5
	syscall
	move $t0, $v0 #first number stored in $t0
	li $v0, 4
	la $a0, second
	syscall
	li $v0, 5
	syscall
	move $t1, $v0 #second number stored in $t1
	li $v0, 4
	la $a0, third
	syscall
	li $v0, 5
	syscall
	move $t2, $v0 #third number stored in $t2
	li $v0, 4
	la $a0, fourth
	syscall
	li $v0, 5
	syscall
	move $t3, $v0 #fourth number stored in $t3
	sw $t0, arr #store each inputted integer in array
	sw $t1, arr + 4
	sw $t2, arr + 8
	sw $t3, arr + 12
	li $a3, 0
	li $t4, 0 #result
	li $t6, 0 #counter
	li $t7, 4 #constant
#loop:
	#	mul $t4, $t6, $t7
	# lw $a1, Array($t6)
	#	lw $a2, Array($t6 + 4)
	#	sub $a3, $a1, $a2
	#	addi $t4, $t4, $a3
	#	addi $t6, $t6, 1
	#	blt $t6, 16, END
	#	j loop
END:
#	move $a0, $t4
#	li $v0, 1
#	syscall
	li $v0, 10
	syscall
