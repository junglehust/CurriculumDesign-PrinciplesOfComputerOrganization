nop
nop
nop
addi $sp,$sp,-4   #25个寄存器压栈
sw $1,0($sp)
addi $sp,$sp,-4
sw $2,0($sp)
addi $sp,$sp,-4
sw $3,0($sp)
addi $sp,$sp,-4
sw $4,0($sp)
addi $sp,$sp,-4
sw $5,0($sp)
addi $sp,$sp,-4
sw $6,0($sp)
addi $sp,$sp,-4
sw $7,0($sp)
addi $sp,$sp,-4
sw $8,0($sp)
addi $sp,$sp,-4
sw $9,0($sp)
addi $sp,$sp,-4
sw $10,0($sp)
addi $sp,$sp,-4
sw $11,0($sp)
addi $sp,$sp,-4
sw $12,0($sp)
addi $sp,$sp,-4
sw $13,0($sp)
addi $sp,$sp,-4
sw $14,0($sp)
addi $sp,$sp,-4
sw $15,0($sp)
addi $sp,$sp,-4
sw $16,0($sp)
addi $sp,$sp,-4
sw $17,0($sp)
addi $sp,$sp,-4
sw $18,0($sp)
addi $sp,$sp,-4
sw $19,0($sp)
addi $sp,$sp,-4
sw $20,0($sp)
addi $sp,$sp,-4
sw $21,0($sp)
addi $sp,$sp,-4
sw $22,0($sp)
addi $sp,$sp,-4
sw $23,0($sp)
addi $sp,$sp,-4
sw $24,0($sp)
addi $sp,$sp,-4
sw $25,0($sp)

MFC0 $1,$1	#屏蔽字到寄存器$1
#$1的屏蔽字压栈
addi $sp,$sp,-4
sw $1,0($sp)

MFC0 $2,$2	#EPC到寄存器$2
#$2的EPC压栈
addi $sp,$sp,-4
sw $2,0($sp)
#栈顶-EPC-屏蔽字-$31-$0

addi $1,$0,0xe	#1号中断的屏蔽字，4位
MTC0 $1,$1	#设置屏蔽字为1110

addi $3,$0,0x1	#IE置为1
MTC0 $3,$3	#开中断

###################################################################
addi $s6,$zero,1       #中断号1,2,3   不同中断号显示值不一样

addi $s4,$zero,6      #循环次数初始值  
addi $s5,$zero,1       #计数器累加值
###################################################################
#                逻辑左移，每次移位4位 
# 显示区域依次显示0x00000016 0x00000106 0x00001006 0x00010006 ... 10000006  00000006 依次循环6次
###################################################################
Int_one_Loop:
add $s0,$zero,$s6   
Int_one_LeftShift:       
sll $s0, $s0, 4  
or $s3,$s0,$s4
add    $a0,$0,$s3       #di$splay $s0
addi   $v0,$0,34         # di$splay hex
syscall                 # we are out of here.   
bne $s0, $zero, Int_one_LeftShift
sub $s4,$s4,$s5      #循环次数递减
bne $s4, $zero, Int_one_Loop
###################################################################

MTC0 $0,$3	#关中断
#EPC出栈$2
lw $2,0($sp)
addi $sp,$sp,4
MTC0 $2,$2	#$2恢复EPC
#屏蔽字出栈$1
lw $1,0($sp)
addi $sp,$sp,4
MTC0 $1,$1	#$1恢复屏蔽字

#32个寄存器出栈
lw $25,0($sp)
addi $sp,$sp,4
lw $24,0($sp)
addi $sp,$sp,4
lw $23,0($sp)
addi $sp,$sp,4
lw $22,0($sp)
addi $sp,$sp,4
lw $21,0($sp)
addi $sp,$sp,4
lw $20,0($sp)
addi $sp,$sp,4
lw $19,0($sp)
addi $sp,$sp,4
lw $18,0($sp)
addi $sp,$sp,4
lw $17,0($sp)
addi $sp,$sp,4
lw $16,0($sp)
addi $sp,$sp,4
lw $15,0($sp)
addi $sp,$sp,4
lw $14,0($sp)
addi $sp,$sp,4
lw $13,0($sp)
addi $sp,$sp,4
lw $12,0($sp)
addi $sp,$sp,4
lw $11,0($sp)
addi $sp,$sp,4
lw $10,0($sp)
addi $sp,$sp,4
lw $9,0($sp)
addi $sp,$sp,4
lw $8,0($sp)
addi $sp,$sp,4
lw $7,0($sp)
addi $sp,$sp,4
lw $6,0($sp)
addi $sp,$sp,4
lw $5,0($sp)
addi $sp,$sp,4
lw $4,0($sp)
addi $sp,$sp,4
lw $3,0($sp)
addi $sp,$sp,4
lw $2,0($sp)
addi $sp,$sp,4
lw $1,0($sp)
addi $sp,$sp,4

ERET	#中断返回	
nop
nop
nop