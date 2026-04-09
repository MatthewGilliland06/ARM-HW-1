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

.equ READERROR, 0 @Used to check for scanf read error. 

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

    ldr r2, =midAmount
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

    cmp r1, #'S'                @ Secret code for inventory
    beq inventory

    b selectionScreen           @ Invalid if none of above is equal to gradeChar
@*******************
regSelected:
@*******************
    ldr r0, =selectedPrompt
    ldr r1, =regString
    bl printf

    mov r4, #4                  
    ldr r5, =regAmount
    ldr r6, =regDollar

    b getDollar
medSelected:
@*******************
    ldr r0, =selectedPrompt
    ldr r1, =medString
    bl printf

    mov r4, #3                  
    ldr r5, =medAmount
    ldr r6, =medDollar
    
    b getDollar
preSelected:
@*******************
    ldr r0, =selectedPrompt
    ldr r1, =preString
    bl printf

    mov r4, #2                  
    ldr r5, =preAmount
    ldr r6, =preDollar
    
    b getDollar
getDollar:
    ldr r0, =dollarPrompt
    bl printf

    ldr r0, =intInputPattern
    ldr r1, =userDollar
    bl scanf

    cmp r0, #READERROR
    beq getDollar

    ldr r7, =userDollar
    ldr r7, [r7]

    cmp r7, #1
    blt getDollar

    cmp r7, #50
    bgt getDollar
@*******************
myExit:
@*******************
@ Return to the OS
POP {pc}

.data
@ Put user defined data in this section and make sure there is a blank line at the end of the file. 

.balign 4
introPrompt .asciz "Welcome to gasoline pump. \n" 

.balign 4
inventoryPrompt1: .asciz "Current inventory of gasoline (in tenths of gallons) is: \n \n\
Regular     %d \n \
Mid-Grade   %d \n \
Premium     %d \n \n"

.balign 4
inventoryPrompt2: .asciz "Dollar amount dispensed by grade: \n \n \
Regular	    $%d \n \
Mid-Grade   $%d \n \
Premium	    $%d \n"

.balign 4
gradePrompt: .asciz "Select Grade of gas to dispense (R, M or P) \n"

.balign 4
selectedPrompt: .asciz "You selected %s \n"

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
charInputPattern: .asciz " %c"   @ Ignores the CR from previous input

.balign 4
gradeChar: .byte 0

.balign 4
dollarPrompt: .asciz "Enter Dollar amount to dispense (1-%d) \n"

.balign 4
dispensedPrompt: .asciz "%d tenths of gallons have been dispensed. \n"

.balign 4
intInputPattern: .asciz "%d"

.balign 4
userDollar: .word 0