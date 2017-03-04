.text
  .globl main


main:
  li $s0, 8 #pass length must be minimum 8
  li $s1, 12 #pass length can be maximum 12
  li $s2, 2 #1 try used
  li $s3, 1 #2 tries used
  li $t7, 3 #no tries used
  j getPassword

getPassword:
  li $t1, 0 #let length  = 0
  li $v0, 4
  la $a0, setPrompt
  syscall
  li $v0, 8
  la $a0, initial
  syscall
  move $t0, $a0 #user input -> $t0
  move $t5, $t0
  j getLength

reenterPassword:
  li $v0, 4
  la $a0, reentryPrompt
  syscall
  li $v0, 8
  la $a0, reentry
  syscall
  move $t3, $a0 #user input --> $t3
  move $t6, $t3
  j checkReenteredPassword

getLength:
  lb $t2, 0($t0) #$t2 --> first byte from address in $t0
  beqz $t2, checkPassword #if $t2 == 0, checkPassword
  add $t0, 1
  add $t1, $t1, 1 #increment counter
  j getLength

checkPassword:
  sub $t0, $t0, $t1
  sub $t1, $t1, 1
  blt $t1, $s0, hasPassError
  bgt $t1, $s1, hasPassError
  j reenterPassword

checkReenteredPassword:
  lb $t2, 0($t0)
  lb $t4, 0($t3)
  bne $t2, $t4, hasRetryError
  add $t0, 1
  add $t3, 1
  sub $t1, $t1, 1
  beqz $t1, passwordSetupSuccessful
  j checkReenteredPassword

hasPassError:
  li $v0, 4
  la $a0, errorPrompt
  syscall
  j getPassword

hasRetryError:
  addi $t7, $t7, -1
  move $t0, $t5
  move $t3, $t6
  beq $t7, $s2, twoAttemptsRemaining
  beq $t7, $s3, oneAttemptRemaining
  beqz $t7, passwordSetupFailed

twoAttemptsRemaining:
  li $v0, 4
  la $a0, twoLeftPrompt
  syscall
  j reenterPassword

oneAttemptRemaining:
  li $v0, 4
  la $a0, oneLeftPromt
  syscall
  j reenterPassword

usedAllAttempts:
  li $v0, 4
  la $a0, oneLeftPromt
  syscall
  j checkReenteredPassword

passwordSetupFailed:
  li $v0, 4
  la $a0, failedPrompt
  syscall
  j END

passwordSetupSuccessful:
  li $v0, 4
  la $a0, successPrompt
  syscall
  j END

END:
  li $v0, 10
  syscall

  .data
    initial: .space 100
    reentry: .space 100
    setPrompt: .asciiz "Set a password: "
    errorPrompt: .asciiz "Failed. Please enter a password with size 8 to 12\n"
    reentryPrompt: .asciiz "Re-enter the password: "
    successPrompt: .asciiz "Password is setup."
    twoLeftPrompt: .asciiz "Incorrect, you have 2 more chances. Please re-enter the password: "
    oneLeftPromt: .asciiz "Incorrect, you have 1 more chance. Please re-enter the password: "
    failedPrompt: .asciiz "Incorrect, you have no more chances. Password setup has failed"
