#assignment 6
.text 0x00400000 #starting memmory address
  .globl main

main:
  add $s7, $zero, $zero #s7 = 0
  li $t8, 0xFF #t8 = 0xFF

size: # to find array size
  lw $t9, array($s7) #load word from array into $t9
  beq $t8, $t9, sizeLast #end loop when $t9 = 0xFF
  addi $s7, 4 #increment counter $s0
  j size

sizeLast:
  addi $s7, $s7, -4 #$s0 = size of array*4 -4

ask:
  add $s6, $zero, $zero #s7 = 0

size_2: # to find array size
  lw $t9, array($s6) #load word from array into $t9
  beq $t8, $t9, sizeLast2 #end loop when $t9 = 0xFF
  addi $s6, 4 #increment counter $s0
  j size_2

sizeLast2:
  addi $s7, $s6, -4 #$s0 = size of array*4 -4

  #sort initial array
  li $s2,4 #$s2 = 4
  li $t9,1 #t8 = 0xF

sort:
  bltz $s7, sortFinal  #end when done

sort2:
  bgt $s2, $s7, decrement #back to outer loop
  lw $t0, array($s1)   #load item from array
  lw $t1, array($s2)   #load next intem from array
  ble $t0, $t1, increment  #if already in order go to next
  sw $t1, array($s1) #swap vaules
  sw $t0, array($s2)

increment:
  addi $s2,$s2,4  #increment $s2
  addi $s1,$s1,4  #increment $s1
  j sort2

decrement:
  addi $s7,$s7,-4 #decrement $s0
  li $s2,4    #$s2 = 4 reset $s1,$s2
  li $s1,0    #$s1 = 0
  j sort

sortFinal:
  li $v0,4 #load print string
  la $a0, sorted_prompt #load string address
  syscall
  add $s0, $zero, $zero

print: #print array
  lw $t9, array($s0) #load word from array into $t9
  beq $t8, $t9, printLast  #end loop when $t9 = 0xFF
  li $v0, 1 #load print string
  add $a0, $t9, $zero
  syscall
  li $v0, 4 #load print string
  la $a0, comma  #load string address
  syscall
  addi $s0, 4 #increment counter $s0
  j print

printLast:
  li $v0, 4  #load print string
  la $a0, enter_prompt  #load string address
  syscall
  li $v0, 5 #load read int
  syscall
  move $t0, $v0 #move read int to $t0
  blt $t0, $zero, END #end when you enter negative number
  add $s0, $zero, $zero #s0 =0

read:
  lw $t9, array($s0) #load word from array into $t9
  beq $t0, $t9, printIndex #end loop if number is found
  beq $t8, $t9, insert #end loop when $t9 = 0xFF
  addi $s0, 4 #increment counter $s0
  j read

insert:
  sw $t0, array($s0) #put new number in array
  addi $s0, $s0, 4    #s0 += 4
  lw $t8, array($s0)   #load 0xFF at end
  li $v0, 4  #load print string
  la $a0, error_not_found  #load string address
  syscall
  j ask

printIndex:
  srl $s4, $s0, 2 #s4 = s0/4
  li $v0, 4  #load print string
  la $a0, index_prompt #load string address
  syscall
  li $v0, 1 #load print int
  add $a0, $s4, $zero #load index number
  syscall
  li $v0, 4 #load print string
  la $a0, space #load string address
  syscall
  j ask

END:
  li $v0, 10
  syscall

  .data
    error_not_found: .asciiz "Number not found. Added to array.\n"
    sorted_prompt: .asciiz "Sorted array: "
    enter_prompt: .asciiz "\nEnter a number to search: "
    index_prompt: .asciiz "Number at index "
    comma: .asciiz ","
    space: .asciiz "\n"
    array: .word 4, 5, 23, 5, 8, 3, 15, 67, 8, 9, 0xFF
