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
  #bge $t0, 100, badInput

  li $t1, 11 #current prime
  li $t2, 11 #max prime

#badInput:
#  li $v0, 4
#  la $a0, error
#  syscall

outer_loop:
  beq $t0, $t1, EXIT
  li $t3, 2
  j inner_loop

inner_loop:
  beq $t3, $t1, outer_loop
  div $t1, $t3
  mfhi $t4
  beq $zero, $t4, otherwise
  move $t2, $t1

otherwise:
  addi $t1, 1
  j outer_loop


EXIT:
  li $v0, 4
  la $a0, max
  syscall
  move $a0, $t2
	li $v0, 5
  syscall
  li $v0, 10
  syscall

  .data
    input: .asciiz "Enter an integer <= 100: "
    error: .asciiz "Input was > 100"
    max: .asciiz "Max Prime: "
