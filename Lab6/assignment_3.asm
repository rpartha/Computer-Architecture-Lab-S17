.data 0x10000860
Vector_A:
 .word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
 .data 0x1000A000
Matrix_B: .word 26 27 28 29 30
 .data 0x1000A100
 .word 31 32 33 34 35
 .data 0x1000A200
 .word 36 37 38 39 40
 .data 0x1000A300
 .word 41 42 43 44 45
 .data 0x1000A400
 .word 46 47 48 49 50
 .data 0x1000B000
Vector_C: .word 0

.text 0x00400000
.globl main
main:
	la $s3, Vector_C
	li $t1, 0 #i
	li $t7, 4
	outer:
		la $s1, Vector_A
		la $s2, Matrix_B
		mult $t1, $t7
		mflo $t6
		add $s2, $s2, $t6
		li $t3, 0
		li $t2, 0
		inner:
			lw $t4, 0($s1)
			lw $t5, 0($s2)
			mult $t4, $t5
			mflo $t6
			add $t3, $t3, $t6
			addi $s1, $s1, 0x4
			addi $s2, $s2, 0x400
			addi $t2, $t2, 1
			beq $t2, 0x5, break_inner #j == 5 --> break_inner
			j inner
		break_inner:
			sw $t3, 0($s3)
			addi $s3, $s3, 0x4
			move $a0, $t3
			li $v0, 1
			syscall

			addi $t1, $t1, 1
			beq $t1, 5, END #i==5 --> END

			li $v0, 4
			syscall
			j outer

	END:
		li $v0, 10
		syscall
