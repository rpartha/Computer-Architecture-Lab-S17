#Ramaseshan Parthasarathy -- 157006637 -- Group 3 -- 02/14/15

#Exercise is used in assignments 1 and 2

#THIS PROGRAM SUMS THE NUMEBRS LESS THAN OR EQUAL TO 18
#USING A LOOP, WHERE THE NUMBER IS STORED IN A WORD ARRAY
	
.text 0x00400000
		.globl main
	
main:
		lw $10, Number1($0) #load word Number1 first entry into register $0
		ori $11, $0, 1 #OR registers $11 and $0
		ori $9, $0, 1 #OR registers $9 and $0

loop:
	bge $11, $10, exit #break if $11 >= $10
	add $9, $10, $9 #sum of values of registers $10 and $9 in register $9
	addi $10, $10, -1 #sum of registers $10 and const. -1 in register $10
	j loop #jump to loop address 

exit:

#the computation is over 
#Is the result in $9 correct?
#The result in $9 is in HEX form

		li $2, 10 #place [load immediate] number 10 into register $2
		syscall
				.data 0x10000000
				.align 2
Number1: .word 18
