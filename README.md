# pipeline-cpu
A pipeline cpu with nested interrupt, realized in logisim and FPGA

## support instruction
add, addi, addiu, addu, and, andi, sll, sra, srl, sub, or, ori, nor, lw, sw, beq, bne, slt, sti, sltu, j, jal, jr, syscall, mfc0, mtc0, eret, 
srlv, lbu, bgez, sltiu

## running result
** main program:**  
<img src="./gif/run1.gif"/>  
the cycles is 2301  

**interrupt1:**  
<img src="./gif/run2.gif"/>  
support extend instructions: bgez, lbu, srlv, sltiu, code in 'testcase/pipeline_int.asm  

**interrupt2:**  
<img src="./gif/run3.gif"/>  
code in 'testcase/pipeline_int.asm  

**interrupt3:**  
<img src="./gif/run4.gif"/>  
code in 'testcase/pipeline_int.asm  