    .data
a:  .asciz "Team 15\n"
b:  .asciz "CHEN I-HAO\n"
c:  .asciz "CHEN YAO-CHUNG\n"
d:  .asciz "HUANG LI -CHI\n\n"


    .text
    .globl Name
    .globl a
    .globl b
    .globl c
    .globl d

Name:

    adcs r0, r1, r2
    stmfd sp!,{lr}
    ldr r0, =a
    bl printf
    ldr r0, =b
    bl printf
    ldr r0, =c
    bl printf
    ldr r0, =d
    bl printf
    mov r0, #0
    ldmfd sp!,{lr}
    mov pc, lr
