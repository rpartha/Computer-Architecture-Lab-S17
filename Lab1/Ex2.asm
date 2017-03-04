#Exercise is used in assignment 3
.text 0x00400000
	.align 2
	.globl main

main:
		lw $a0, Size #Load the size of array into $a0, using lw
		li $a1, 0 #initialize index i
		li $t2, 4 #t2 contains const. 4 , initialize t2
		li $t1, 0 #initialize result to 0

loop:
		mul $t1, $a1, $t2 #t1 gets i*4
		lw $a3, Array($t1) #a3 = Array[i]
		lw $t4, Array2($t1) #t4 = Array2[i]
		sub $t1, $t4, $a3 #result = Array2[i] - Array[i]
		sw $t1, Array2($t1) #store result in the Array 2 in location i
		addi $a1, $a1, 1 #i++
		blt $a0, $a1, END #go to END if finished
		j loop

END:
		li $v0, 10
		syscall

.data 0x10000000
	.align 2

Array: .word 2 5 6 7 12 16
Array2: .word 5 8 9 10 15 19
Size: .word 6
 