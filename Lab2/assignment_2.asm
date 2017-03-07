#GET THE CLOSET/LARGEST PRIME <= N, WHERE N <= 100
.text
  .globl main

main:
  li $v0, 4
  la $a0, input
  syscall
  li $v0, 5 #get user input
  syscall
  move $t0, $v0  #n
  bge $t0, 101, badInput

badInput:
  li $v0, 4
  la $a0, error
  syscall

EXIT:
  li $v0, 10
  syscall

  .data
    input: .asciiz "Enter an integer <= 100: "
    error: .asciiz "Input was > 100"
