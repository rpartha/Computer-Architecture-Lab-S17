#ASSIGNMENT 1
.text 0x00400000 #starts at this memmory address
.globl main

main:
li $v0, 4    #load print string
la $a0, input #load string input
syscall

li $v0, 5 #read int
syscall
move $t0, $v0    #move result to t0

li $v0, 5 #read int
syscall
move $t1, $v0 #move result to t1

li $v0, 5 #read int
syscall
move $t2, $v0 #move result to t2

or $t3, $t0, $t2 #t3 = A or C
not $t3, $t3 #t3 = (A or C)'

not $t0, $t0 #$t0 = A'
not $t1, $t1 #$t1 = B'
and $t4, $t0, $t1 #$t4 = (A' and B')

or $t5, $t4, $t3 #$t5 = (A' and B') or (A or C)'

li $v0, 4 #load print string
la $a0, output #load 'output' string
syscall

li $v0,1 #load print integer
add $a0, $zero, $t5 #load $t5 int $a0
syscall

li $v0,10
syscall

.data
input: .asciiz "Input three numbers: "
output: .asciiz "\nThe result: "
