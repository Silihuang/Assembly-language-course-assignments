        .data

frame:  .word
ff:     .word  0xffff
Cx:     .word 0
Cy:     .word 0
width:  .word 0
height: .word 0
Zx:     .word 0

Zy:     .word 0

     d:  .asciz "%d\n"
        .text
        .globl drawJuliaSet



drawJuliaSet:

         sbcs r11,r0,r1
         ldr r4,=Cx
         str r0,[r4]
         ldr r4,=Cy
         str r1,[r4]
         ldr r4,=width
         str r2,[r4]
         ldr r4,=height
         str r3,[r4]

         ldr r4, =frame
         str sp, [r4]

         stmfd sp!,{lr,fp}

         mov r4, #0    @ r4 = x

         mov r5, #0    @ r5 = y

    loop:

         mov r5,#0
         ldr r2,=width
         ldr r2,[r2]
         cmp r4, r2    @if x <= width
         bge done      @  x > width

    loop2:
         ldr r2,=width
         ldr r2,[r2]
         mov r6,r2,LSR#1  @ move right one digit width>>1
         sub r7,r4,r6     @ x - width>>1
         mov r10, #150
         mov r9, #10
         mul r10,r10,r9

         mul r7,r10,r7   @ 1500* (x - width>>1)
         mov r0,r7
         mov r1,r6
         bl __aeabi_idiv  @ divided
         mov r6,r0 @r6 = zx
         ldr r0,=Zx
         str r6,[r0]


         ldr r2,=width
         ldr r2,[r2]
         ldr r3,=height
         ldr r3,[r3]

         mov r7,r3,LSR#1  @ move right one digit width>>1
         sub r8,r5,r7    @ y - width>>1
         mov r10, #1000
         mul r7,r10,r8   @ 1000* (y - width>>1)
         mov r0,r7
         mov r1,r8
         bl __aeabi_idiv  @ divided
         mov r7,r0 @r7 = zy

         ldr r0,=Zy
         str r7,[r0]

         @pop



         mov r8,#255

         add r5, r5, #1   @ y++

   loop3:
        ldr r6,=Zx
        ldr r6,[r6]
        ldr r7,=Zy
        ldr r7,[r7]
        mul r9, r6, r6 @ zx*zx
        mul r10, r7, r7 @ zy*zy
        add r9, r9, r10 @ zx*zx+zy*zy
        mov r10,#4
        mov r0,#10
        mul r10,r10,r0 @40
        mul r10,r10,r0 @400
        mul r10,r10,r0 @4000
        mul r10,r10,r0 @40000
        mul r10,r10,r0 @400000
	    mul r10,r10,r0 @4000000

        cmp r9, r10 @ zx*zx+zy*zy<4000000
        bge three_steps       @ if zx*zx+zy*zy>=4000000@@@@@


        cmp r8, #0
        ble three_steps      @ if i<= 0

        ldr r6,=Zx
        ldr r6,[r6]
        ldr r7,=Zy
        ldr r7,[r7]
        mul r9, r6, r6 @ zx*zx
        mul r10, r7, r7 @ zy*zy
        sub r9, r9, r10 @ zx*zx-zy*zy

        mov r0,r9
        mov r1,#1000
        bl __aeabi_idiv  @ divided
        mov r9,r0
        ldr r0,=Cx
        ldr r0,[r0]
        @pop
        add r9,r9,r0       @tmp
        mul  r6,r6,r7

        mov  r6,r6,LSL#1

        mov r0,r6
        mov r1,#1000
        bl __aeabi_idiv  @ divided
        mov r6,r0


        ldr r1,=Cy
        ldr r1,[r1]
        @pop
        add r6,r6,r1
        mov r7,r6
        mov r6,r9
        ldr r0,=Zx
         str r6,[r0]
         ldr r0,=Zy
         str r7,[r0]

        sub r8 ,r8 ,#1  @ i--


        b loop3



three_steps:
      and r6 , r8 , #0xff
      mov r7 , r6 ,LSL#8

      orr r7 , r7 , r6
      mvn r7 , r7

      ldr r10, =ff
      ldr r10,[r10]
      and r7, r7,r10
      mov r6,r7

      mov r8,#1280
      mul r7,r5,r8


      add r7,r7,r4,LSL #1

      ldr r10, =frame
      ldr r10, [r10]
      strh r6, [r10,r7]

      add r5, r5, #1 @ y++
      cmp r5,r3
      blt loop2
	  add r4,r4,#1 @x++
	  cmp r4,r2
	  blt loop

done :

      mov r0,#0
      ldmfd sp!,{lr,fp}
      mov pc, lr



