.text 0x00400000 #starts at this memmory address
.globl main

main:
li $v0,4 #load print string
la $a0, length #load 'length' string
syscall

li $v0,6 #read float
syscall
mov.s $f1, $f0 #move input to f1 = length

li $v0,4 #load print string
la $a0, width #load 'width' string
syscall

li $v0,6 #read float
syscall
mov.s $f2, $f0 #move input to f2 = width

li $v0, 4 #load print string
la $a0, height #load 'height' string
syscall

li $v0, 6 #read float
syscall
mov.s $f3, $f0 #move input to f3 = length

li.s $f4, 2.0 #f4 = 2.0

mul.s $f16, $f1, $f2 #f16 = length * width
mul.s $f17, $f1, $f3 #f17 = length * width * height

li $v0,4 #load print string
la $a0, volume #load string'volume'
syscall

li $v0,2 #load print float
syscall #print volume in f12

li $v0, 10
syscall

.data
  length: .asciiz "Input the length: "
  width:  .asciiz "\nInput the width: "
  height: .asciiz "\nInput the height: "
  volume: .asciiz "\nThe volume of the cuboid: "
  area:   .asciiz "\nThe surface area of the cuboid: "
