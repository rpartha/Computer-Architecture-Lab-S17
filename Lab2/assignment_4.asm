#assignment 4 -- console freezes upon execition..... :/
.text
  .globl main

main:
  li $s0, 1
  li $t7, 2

  #user inputs number of line and is stored
  li $v0, 4
  la $a0, input
  syscall
  li $v0, 5
  syscall
  move $t0, $v0
  beqz $t0, END #cannot be 0
  addi $t1, $t0, 1
  div $t1, $t1, 2
  j top

top:
  bgt $s0, $t1, fix
  sub $t2, $t1, $s0 #numSpaces = half - counter
  mul $t3, $s0, 2
  sub $t3, $t3, 1 #numStars = 2*counter - 1
  j top_spaces

fix:
  rem $t6, $t0, $t7
  sub $s0, $s0, 1 #decrement counter
  beqz $t6, bottom #remainder = 0
  sub $s0, $s0, 1 #decrement counter
  bnez $t6, bottom #remainder not  = 0

bottom:
  beqz $s0, END
  sub $t2, $t1, $s0
  mul $t3, $s0, 2
  sub $t3, $t3, 1
  j bottom_spaces #jump to bottom_spaces

top_spaces:
  beqz $t2, top_stars
  li $v0, 4
  la $a0, space
  syscall #syscall to print string
  sub $t2, $t2, 1
  j top_spaces #jump to top_spaces

top_stars:
  beqz $t3, top_new_line
  li $v0, 4
  la $a0, star
  syscall #syscall to print string
  sub $t3, $t3, 1
  j top_stars #jump to top_stars

top_new_line:
  li $v0, 4
  la $a0, new_line
  syscall #syscall to print string
  addi $s0, $s0, 1 #increment counter
  j top #jump to top_stars

bottom_spaces:
  beqz $t2, bottom_stars
  li $v0, 4
  la $a0, space
  syscall #syscall to print string
  sub $t2, $t2, 1
  j bottom_spaces #jump to top_spaces

bottom_stars:
  beqz $t3, bottom_new_line
  li $v0, 4
  la $a0, star
  syscall #syscall to print string
  sub $t3, $t3, 1
  j bottom_stars #jump to top_stars

bottom_new_line:
  li $v0, 4
  la $a0, new_line
  syscall #syscall to print string
  addi $s0, $s0, 1 #increment counter
  j bottom #jump to top_stars

END:
  li $v0, 10
  syscall
  .data
    input: .asciiz "Enter the number of lines: "
    star: .asciiz "*"
    space: .asciiz " "
    new_line: .asciiz "\n"
