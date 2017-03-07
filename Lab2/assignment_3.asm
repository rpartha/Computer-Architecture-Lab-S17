.text
  .globl main

main:
  getFirstNum: #recieve first number
    li $v0, 4
    la $a0, num1
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    blt $t0, $zero, printError
    bgt $t0, 1000, printError

  getSecondNum: #recieve second number
    li $v0, 4
    la $a0, num2
    syscall
    li $v0, 5
    syscall
    move $t1, $v0
    blt $t1, $zero, printError2
    bgt $t1, 1000, printError2

    bgt $t0, $t1, switch
    addi $t0, $t0, 1
    li $t2, 0 #even sum will be stored here
    li $t4, 0 #odd sum will be stored here

  loop:
    bge $t0, $t1, END
    li $t3, 2
    div $t0, $t3
    mfhi $t3
    beq $0, $t3, incr #if remainder is 0, add to even sum
    bne $0, $t3, incr2
    addi $t0, $t0, 1
    j loop

  incr:
    add $t2, $t2, $t0
    addi $t0, $t0, 1
    j loop

  incr2:
    add $t4, $t4, $t0
    addi $t0, $t0, 1
    j loop

  switch: #force $t0 < $t1
    move $t2, $t0
    move $t0, $t1
    move $t1, $t2
    addi $t0, $t0, 1
    li $t2, 0
    j loop

  printError:
    li $v0, 4
    la $a0, error
    syscall
    j getFirstNum

  printError2:
    li $v0, 4
    la $a0, error
    syscall
    j getSecondNum

  END:
    li $v0, 4
    la $a0, sum1
    syscall
    move $a0, $t2
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, sum2
    syscall
    move $a0, $t4
    li $v0, 1
    syscall
    li $v0, 10
    syscall

    .data
      num1: .asciiz "Enter a number between [0, 1000]: "
      num2: .asciiz "Enter another number between [0, 1000]: "
      error: .asciiz "Input is out of bounds. Please try again.\n"
      sum1: .asciiz "\nSum of all even numbers: "
      sum2: .asciiz "\nSum of all odd numbers: "
