#GET THE CLOSET/LARGEST PRIME <= N, WHERE N <= 100
.text
  .globl main

main:
  li $v0, 5 #get user input
  syscall
  move $s0, $v0  #n
  add $t0, $zero, $s0 #$t0 = $s0
  li $t1, 0 #found boolean
  li $t2, 0 #max prime

EXIT:
  move $a0, $t0
  li $v0, 4
  syscall
  li $v0, 10
  syscall
