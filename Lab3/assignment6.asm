.text 0x00400000 #starts at this memmory address
.globl main
main:
li $v0, 4 #load print string
la $a0, input #load string 'input'
syscall

li $v0,6  #read float
syscall
mov.s $f1, $f0 #move input to f1 = input

li $s1, 4 #$s0 = 4
li.s $f31, 0.0 #$f31 = 0

loop:
l.s $f2, array($s0) # load number from array into $f2
c.le.s $f2, $f31 #endloop if reach end of array
bc1t loop_end
c.le.s $f2, $f1 #add to sum if less than or equal to input
bc1t work

work:
add.s $f12, $f12, $f2 #$f12 = $f12+$f2 f12 is sum

add $s0, $s0, $s1 #$s0 = $s0 + 4
j loop

loop_end:
c.le.s $f12, $f31  #if sum is zero, than number too small
bc1t END

li $v0, 4  #load print string
la $a0, sum #load string'sum'
syscall

li $v0, 2 #load print float
syscall #print answer in f12

li $v0, 10
syscall

END:
li $v0, 4 #load print string
la $a0, small #load string'big'
syscall

li $v0, 10
syscall

.data
  input: .asciiz "\nInput a number: "
  sum: .asciiz "\nThe answer is: "
  small: .asciiz "\nNumber is too small."
  array: .float 12.5, 2.34,3.59, 4.76, 10.67, 3.54