      .data
str1: .asciz "\n*****INPUT ID*****\n"
str2: .asciz "**Please Enter Member %d ID**\n"
str3: .asciz "**Please Enter Command**\n"
str4: .asciz "*****Print Team Member ID and ID Summation*****\n"
str5: .asciz "\nID Summation = %d \n"
num:  .word 0
num2: .word 0
num3: .word 0
sum:  .word 0
p:    .word 0
d:    .asciz "%d"
dn:   .asciz "%d\n"
c:    .asciz "%s"


      .text
      .globl id
      .globl num
      .globl num2
      .globl num3
      .globl sum


id:

      stmfd sp!,{lr}
      ldr r0, =str1
      bl printf
      ldr r0, =str2
      mov r1, #1
      bl printf
      ldr r0, =d
      ldr r1, =num
      bl scanf
      ldr r4, =num
      ldr r4, [r4] @ num store in r4

      ldr r0, =str2
      mov r1, #2
      bl printf
      ldr r0, =d
      ldr r1, =num2
      bl scanf
      ldr r5, =num2
      ldr r5, [r5] @ num store in r5
      add r8, r4, r5 @ add num

      ldr r0, =str2
      mov r1, #3
      bl printf
      ldr r0, =d
      ldr r1, =num3
      bl scanf
      ldr r6, =num3
      ldr r6, [r6] @ num store in r6

      ldr r9, =sum
      add r7, r6, r8 @ add num

      str r7, [r9]

      ldr r0, =str3
      bl printf
      ldr r0, =c  @ read p
      bl scanf

      ldr r0, =str4
      bl printf
      ldr r0, =dn
      mov r1, r4
      bl printf
      ldr r0, =dn
      mov r1, r5
      bl printf
      ldr r0, =dn
      mov r1, r6
      bl printf

      ldr r0, =str5
      ldr r1, =sum
      ldr r1,[r1]
      bl printf


      ldmfd sp!, {lr}
      mov r0, #0     @ return 0
      mov pc, lr
