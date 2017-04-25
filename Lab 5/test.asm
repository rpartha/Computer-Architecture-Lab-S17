#####################################################################
.data # Data declaration section
nl: .asciiz "\n"
msg: .asciiz "\nHow Lucky Can You Get?"
bye: .asciiz "\n** Come Back Again **"
.text
main:
li $a3, 0xffff0000 # Base address of I/O
li $s1, 2
sw $s1, 0($a3) # Enable Keyboard Interrupt
li $s1, 0x0000ffff # Mask to enable all interrupts
mtc0 $s1, $12 # Store enable bits in Status register
li $v0, 4 # Print message
la $a0, msg
syscall
li $t0, 211 # Seed values
li $t1, 3021377
clear:
li $v1, 0 # Clear the flag
ranloop:
mult $t0, $t1
mflo $t0
addiu $t0, $t0, 5923
beqz $v1, ranloop # Keystroke will change $v1
# to ASCII value for the key
addiu $v1, $v1, -10
beqz $v1, quit # Quit if Enter Key
li $v0, 4 # Print newline
la $a0, nl
syscall
li $v1, 100 # Controls Range (0 – 99)
divu $t0, $v1
mfhi $a0 # Get Remainder
li $v0, 1
syscall
b clear
quit:
li $v0, 4 # Print newline
la $a0, bye
syscall
li $v0, 10
syscall
