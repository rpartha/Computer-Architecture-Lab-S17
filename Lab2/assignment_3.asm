.text
  .globl main

main:
  getFirstNum: #recieve first number
    li $v0, 4
    la $a0, num1 #load address of first number prompt
    syscall
    li $v0, 5
    syscall
    move $t0, $v0 #store first number in $t0
    blt $t0, 1, printError    #ensure number is > 1
    bgt $t0, 1000, printError #but < 1000

  getSecondNum: #recieve second number
    li $v0, 4
    la $a0, num2 #load address of second number prompt
    syscall
    li $v0, 5
    syscall
    move $t1, $v0 #store second number in $t1
    blt $t1, 1, printError2    #ensure number is > 1
    bgt $t1, 1000, printError2 #but < 1000

    bgt $t0, $t1, switch #force $t0 < $t1
    addi $t0, $t0, 1
    li $t2, 0 #even sum will be stored here
    li $t4, 0 #odd sum will be stored here

  loop:
    bge $t0, $t1, END
    li $t3, 2
    div $t0, $t3
    mfhi $t3
    beq $0, $t3, sumEven #if remainder is 0, add to even sum
    bne $0, $t3, sumOdd #if remainder is not 0, add to odd sum
    addi $t0, $t0, 1
    j loop

  sumEven: #sum up the even values
    add $t2, $t2, $t0
    addi $t0, $t0, 1
    j loop

  sumOdd: #sum up the odd values
    add $t4, $t4, $t0
    addi $t0, $t0, 1
    j loop

  switch: #switch value of $t0 with $t1 so that $t0 < $t1 (in case $t0 > $t1)
    move $t2, $t0
    move $t0, $t1
    move $t1, $t2
    addi $t0, $t0, 1
    li $t2, 0
    j loop

  printError: #error prompt for first number
    li $v0, 4
    la $a0, error
    syscall
    j getFirstNum

  printError2: #error prompt for second number
    li $v0, 4
    la $a0, error
    syscall
    j getSecondNum

  END:
    li $v0, 4
    la $a0, sum1 #load address of even prompt
    syscall
    move $a0, $t2 #result of even stored in $t2
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, sum2 #load address of odd prompt
    syscall
    move $a0, $t4 #result of odd stored in $t4
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
