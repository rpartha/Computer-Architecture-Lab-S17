#OBTAIN POWER OF 3 DEPENDING ON THE INPUT (IT WON'T WORK ON LARGER INPUT VALUES)
.data 0x10000000
	ask: .asciiz "\nEnter a number between 0 and 50000: "
	ans: .asciiz "Answer: "
	
.text 0x00400000
.globl main
main:
		li $v0, 4
		la $a0, ask #load the ask string
		syscall 
		li $v0, 5 #Read input
		syscall
		li $t0, 3
		move $a1, $v0
		move $a0, $t0
		jal PowOfThree #call recursive function
		move $s0, $v0
		la $a0, ans #store ans string
		li $v0, 4
		syscall
		move $a0, $s0 
		li $v0, 1
		syscall 
		li $v0, 10
		syscall

PowOfThree:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	bne $a1, $zero, MultHelper #call helper function
	addi $v0, $zero, 1
	addi $sp, $sp, 4
	jr $ra	
MultHelper:
	bne $a1, 1, Pow #call helper function
	add $v0, $zero, $a0
	addi $sp, $sp, 4
	jr $ra
Pow:
	move $t1, $a1
	andi $t0, $t1, 1
	bne $t0, $zero, PowHelper #call helper function
	srl $a1, $a1, 1
	jal PowOfThree
	mul $v0, $v0, $v0 
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
PowHelper:
	addi $a1, $a1, -1
	jal PowOfThree
	lw $ra, 0($sp)
		addi $sp, $sp, 4
	mul $v0, $v0, $a0
	jr $ra