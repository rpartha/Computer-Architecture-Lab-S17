# Lab 4

## Introduction

This lab serves to introduce us to pipelined processors and how they work. Further more, we learn how to deal with hazards within assembly programs
(rather how to prevent them), as well as how to handle exceptions and interrupts.

## Assignment 1
Instruction  | RegDst  | ALUSrc  | Mem2Reg  | RegWrite  | MemRead  | MemWrite  | Branch  |  ALUOp
:--:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:--:
addi $t0, $t0, 10  | 0  | 1  | 0  | 1  | 0  | 0  | 0  | 00
sw $t0, 32($s0)  | x  |  1 | x  |  0 |  0 | 1  |  0 |  00
bne $t2, $t0, QUIT  | x  | 0  | x  | 0  | 0  |  0 |  1 |  01
xor $s0, $t1, $t2  |  1 | 0  |  x | 1  |  0 | 0  |  0 | 00
j Print  |  x | x  |  x | 0  | 0  | 0  |  0 |  00
## Assignment 2
This assignment refers to the following instructions:  
A: *lw $t0,0($t3)*  
B: *add $t1, $t0, $t2*  
C: *sub $t3, $t3, $t1*  
D: *addi $t4, $t4, 4*  
E: *add $t5, $t5, $t4*  

1.  

Register  | Value Before  |  Value After
:--:|:---:|:--:
$t0  |  2 |  2
$t1  | 5  |  10
$t2  | 8  |  8
$t3  | 2  |  -8
$t4  | 4 |  8
$t5  | 1 |  ?

2.

3.

4. Instructions can be reordered to reduce cycles. For example, instruction D can be moved to the beginning of the code as none of the prior instructions depend on it.

5. Overall, the amount of cycles would be lessened since the next instruction does not have to wait until after the previous instruction is finished with the write-back to get the appropriate value. Instead, it can just access the result from wherever the execution point of the result. For example, if the instruction is add or sub, then the next instruction’s ID can start in the same clock cycle as that instruction’s EX. If the instruction is load, then the next instruction’s ID can start in the same clock cycle as that instruction’s MEM because it needs to access the memory for load.


## Assignment 3

## Assignment 4

1. Please refer to *quad_sol_reordered.asm* for this assignment.

  First block:  
  ![First Block](block1.PNG)

  First block [REORDERED]:  
  ![First Block REORDERED](block1new.PNG)

  The reordered first block would take 12 cycles < 14 cycles = original first block.

  Second block:  
  ![Second Block](block2.PNG)

  Second block [REORDERED]:  
  ![Second Block REORDERED](block2new.PNG)

  The reordered second block would take 10 cycles < 11 cycles = original second block.

  The conclusion can be made drawn that 3 clock cycles were saved overall, and the reordering of the code did not affect the output at all.

2. If instruction-forwarding was suported, then the program execution would become much faster due to the fact that the amount of stalling in the code would be minimzed which would therefore reduce the amount of clock cycles required.
Consider, for example, the first 5 lines of the First Block [REORDERED]. One can observe that both $t4 and $t5 would be ready by the time its execution phase is completed. Hence, the third instruction can use $t5 a lot sooner as opposed to stalling back until the write-back phase. Such is the case for other areas within the code.
