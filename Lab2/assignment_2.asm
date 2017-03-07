#GET THE CLOSET/LARGEST PRIME <= N, WHERE N <= 100
.text
  .globl main

main:
getInput:
  li $v0, 4
  la $a0, input
  syscall
  li $v0, 5 #get user input
  syscall
  move $t0, $v0  #n
  blt $t0, $0, badInput
  bgt $t0, 100, badInput
  li $t1, 2
  li $t2, 2
  li $s1, 0

loop:
  beq $t1, $t0, EXIT
  addi $t1, 1
  li $t2, 2
  checker:
    bge $t2, $t1, findMax
    div $t1, $t2
    li $t9, 0
    mfhi $t9
    beq $t9, 0, loop
    li $s1, 0
    move $s1, $t1
    addi $t2, 1
    j checker
  findMax:
    li $s2, 0
    move $s2, $s1
    j loop

badInput:
  li $v0, 4
  la $a0, error
  syscall

EXIT:
  li $v0, 4
  la $a0, max
  syscall
  move $a0, $s2
	li $v0, 1
  syscall
  li $v0, 10
  syscall

  .data
    input: .asciiz "Enter an integer <= 100: "
    error: .asciiz "Input was out of bounds"
    max: .asciiz "Max Prime: "
