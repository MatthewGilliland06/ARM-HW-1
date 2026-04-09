@
@ Program Name: MWGLab5.s
@ Author: Matthew Gilliland
@ Date: 4/1/2026
@ Email: mwg0013@uah.edu
@ Class: CS309-01 Spring 2026
@ Purpose:
@
@ These commands assemble, link, run and debug the code.
@ Student should change the following to match their code filename. 
@
@ gcc MWGLab5.s -g -c -o MWGLab5.o
@ gcc MWGLab5.o -g -o MWGLab5
@ ./MWGLab5
@ gdb --args ./MWGLab5 
@
@ In debug use the following when starting:
@ start
@ layout split
@ layout reg
@

.equ READERROR, 0  @Used to check for scanf read error. 

.text
.global main

main:

@  Save return to OS on stack.
PUSH {lr}


@ Enter your program here.
@*******************
prompt1:
@*******************
    ldr r0, =introPrompt
    bl printf
 @*******************
inventory:
@*******************
    ldr r0, =inventoryPrompt1
    ldr r1, =regAmount
    ldr r1, [r1]
    ldr r2, =medAmount
    ldr r2, [r2]
    ldr r3, =preAmount
    ldr r3, [r3]
    bl printf

    ldr r0, =inventoryPrompt2
    ldr r1, =regDollar
    ldr r1, [r1]
    ldr r2, =medDollar
    ldr r2, [r2]
    ldr r3, =preDollar
    ldr r3, [r3]
    bl printf
@*******************
mainLoop:
@*******************
    ldr r0, =regAmount
    ldr r1, [r0]
    cmp r1, #10
    bge continueLoop

    ldr r0, =medAmount
    ldr r1, [r0]
    cmp r1, #10
    bge continueLoop

    ldr r0, =preAmount
    ldr r1, [r0]
    cmp r1, #10
    bge continueLoop

    b myExit

continueLoop:
@*******************
selectionScreen:
@*******************

    ldr r0, =gradePrompt
    bl printf

    ldr r0, =charInputPattern
    ldr r1, =gradeChar
    bl scanf

    ldr r1, =gradeChar
    ldrb r1, [r1]

    cmp r1, #'R'
    beq regSelected
    cmp r1, #'M'
    beq medSelected
    cmp r1, #'P'
    beq preSelected
    cmp r1, #'S'
    beq inventory

    ldr r0, =invalidGradePrompt
    bl printf
    b selectionScreen
@*******************
regSelected:
@*******************
    ldr r5, =regAmount
    ldr r0, [r5]
    cmp r0, #10
    bge regOK
    ldr r0, =emptyPrompt
    bl printf
    b selectionScreen
@*******************
regOK:
@*******************
    ldr r0, =selectedPrompt
    ldr r1, =regString
    bl printf

    mov r4, #4
    ldr r6, =regDollar
    b getDollar
@*******************
medSelected:
@*******************
    ldr r5, =medAmount
    ldr r0, [r5]
    cmp r0, #10
    bge medOK
    ldr r0, =emptyPrompt
    bl printf
    b selectionScreen
@*******************
medOK:
@*******************
    ldr r0, =selectedPrompt
    ldr r1, =medString
    bl printf

    mov r4, #3
    ldr r6, =medDollar
    b getDollar
@*******************
preSelected:
@*******************
    ldr r5, =preAmount
    ldr r0, [r5]
    cmp r0, #10
    bge preOK
    ldr r0, =emptyPrompt
    bl printf
    b selectionScreen
@*******************
preOK:
@*******************
    ldr r0, =selectedPrompt
    ldr r1, =preString
    bl printf

    mov r4, #2
    ldr r6, =preDollar
    b getDollar
@*******************
getDollar:
@*******************
    ldr r0, =dollarPrompt
    bl printf

    ldr r0, =intInputPattern
    ldr r1, =userDollar
    bl scanf

    cmp r0, #READERROR
    beq invalidDollar

    ldr r7, =userDollar
    ldr r7, [r7]

    cmp r7, #1
    blt invalidDollar

    cmp r7, #50
    bgt invalidDollar

    mul r8, r7, r4

    ldr r9, [r5]
    cmp r9, r8
    blt insufficient

    sub r9, r9, r8
    str r9, [r5]

    ldr r10, [r6]
    add r10, r10, r7
    str r10, [r6]

    ldr r0, =dispensedPrompt
    mov r1, r8
    bl printf

    b mainLoop
@*******************
invalidDollar:
@*******************
    ldr r0, =invalidDollarPrompt
    bl printf
    b getDollar
@*******************
insufficient:
@*******************
    ldr r0, =insufficientPrompt
    bl printf
    b getDollar
@*******************
myExit:
@*******************
    ldr r0, =inventoryPrompt1
    ldr r1, =regAmount
    ldr r1, [r1]
    ldr r2, =medAmount
    ldr r2, [r2]
    ldr r3, =preAmount
    ldr r3, [r3]
    bl printf

    ldr r0, =inventoryPrompt2
    ldr r1, =regDollar
    ldr r1, [r1]
    ldr r2, =medDollar
    ldr r2, [r2]
    ldr r3, =preDollar
    ldr r3, [r3]
    bl printf
@ Return to the OS
POP {pc}

.data
@ Put user defined data in this section and make sure there is a blank line at the end of the file. 

.balign 4
introPrompt: .asciz "Welcome to gasoline pump.\n"

.balign 4
inventoryPrompt1: .asciz "Current inventory of gasoline (in tenths of gallons):\n\nRegular %d\nMid-Grade %d\nPremium %d\n\n"

.balign 4
inventoryPrompt2: .asciz "Dollar amount dispensed:\n\nRegular $%d\nMid-Grade $%d\nPremium $%d\n"

.balign 4
gradePrompt: .asciz "Select Grade (R, M, or P):\n"

.balign 4
selectedPrompt: .asciz "You selected %s\n"

.balign 4
invalidGradePrompt: .asciz "Invalid grade. Try again.\n"

.balign 4
emptyPrompt: .asciz "Insufficient inventory for that grade.\n"

.balign 4
invalidDollarPrompt: .asciz "Invalid dollar amount. Enter 1-50.\n"

.balign 4
insufficientPrompt: .asciz "Insufficient inventory. Enter a lower amount.\n"

.balign 4
regString: .asciz "Regular"

.balign 4
medString: .asciz "Mid-Grade"

.balign 4
preString: .asciz "Premium"

.balign 4
regAmount: .word 500

.balign 4
medAmount: .word 500

.balign 4
preAmount: .word 500

.balign 4
regDollar: .word 0

.balign 4
medDollar: .word 0

.balign 4
preDollar: .word 0

.balign 4
charInputPattern: .asciz " %c"

.balign 4
gradeChar: .byte 0

.balign 4
dollarPrompt: .asciz "Enter Dollar amount (1-50):\n"

.balign 4
dispensedPrompt: .asciz "%d tenths of gallons have been dispensed.\n"

.balign 4
intInputPattern: .asciz "%d"

.balign 4
userDollar: .word 0
