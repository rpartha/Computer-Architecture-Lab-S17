.text 0x00400000 #starts at this memmory address
.globl main

main:
li $v0,4 #load print string
la $a0, input #load string prompt
syscall

li $v0, 6 #read float input
syscall
mov.s $f1, $f0 #move imput to f1 = xi, f0 = b

li.s $f2, 2.0 #$f2 = 2.0
li.s $f31, 0.00001 #f31 = 0.00001

loop:
  div.s $f5, $f0, $f1 #f5 = b/xi
  add.s $f6, $f5, $f1 #f6 = xi + b/xi
  div.s $f12, $f6, $f2 #f12 = (xi + b/xi)/2
  sub.s $f7, $f12, $f1 #f7 = x(i+1) - x(i)
  abs.s $f7, $f7 #f7 = abs(x(i+1) - x(i))
  c.lt.s $f7, $f31 #set condition but to 1 if abs(x(i+2) - x(i)) < 0.00001
  bc1t loop_end #end when precise enough
  mov.s $f1, $f12 #x(i) = x(i+1)
  j loop

loop_end:
  li $v0, 4 #load print int
  la $a0, output #load 'output' string
  syscall

li $v0,2 #load print float
syscall

li $v0,10
syscall

.data
  input: .asciiz "\nInput a number: "
  output: .asciiz "\nSquare root: "
