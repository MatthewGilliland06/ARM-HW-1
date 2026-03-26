@
@ Program Name: MWGLab4.s
@ Author: Matthew Gilliland
@ Date: 03/15/2026
@ Email: mwg0013@uah.edu
@ Class: CS309-01 Spring 2026
@ Purpose: State all the factorial for all integers from 1 to n
@
@ These commands assemble, link, run and debug the code.
@ Student should change the following to match their code filename. 
@
@ gcc MWGLab4.s -g -c -o MWGLab4.o
@ gcc MWGLab4.o -g -o MWGLab4
@ ./MWGLab4
@ gdb --args ./MWGLab4 
@
@ In debug use the following when starting:
@ start
@ layout split
@ layout reg
@

.text
.global main

main:

@  Save return to OS on stack.
PUSH {lr}

@ Enter your program here.
@*******************
prompt1:
@*******************
    ldr r0, =numPrompt
    bl printf

@*******************
getNumInput:
@*******************
    ldr r0, =numInputPattern    @ Get number
    ldr r1, =numInput
    bl scanf
    cmp r0, #READERROR          @ Check for a read error.
    beq myExit
    
    ldr r1, =numInput           @ Load number
    ldr r1, [r1]


@*******************
checkValidity:
@*******************
    cmp r1, #1               
    blt myExit 

    cmp r1, #12
    bgt myExit

@*******************
printText:
@*******************
    ldr r0, =enteredText   
    mov r1, r1             
    bl printf

    ldr r0, =tableText
    bl printf

    ldr r0, =tableHead
    bl printf

    ldr r4, =loopNum
    mov r5, #1
    str r5, [r4]

    ldr r6, =total
    mov r7, #1
    str r7, [r6]
@*******************
factorial:
@*******************
    ldr r4, =loopNum    @ location of loopNum
    ldr r5, [r4]        @ value of loopNum

    ldr r6, =total      @ location of total
    ldr r7, [r6]        @ value of total

    mul r7, r5, r7
    str r7, [r6]        @ store total in memory

    ldr r0, =table
    mov r1, r5
    mov r2, r7
    bl printf

    add r5, r5, #1
    str r5, [r4]

    ldr r1, =numInput
    ldr r1, [r1]

    cmp r5, r1
    ble factorial
@*******************
myexit:
@*******************
@ Return to the OS
POP {pc}

.data
@ Put user defined data in this section and make sure there is a blank line at the end of the file. 

.balign 4
numPrompt: .asciz "This program will print the factorial of the integers from 1 to a number you enter. Please enter an integer number from 1 to 12. \n"

.balign 4
enteredText: .asciz "You entered %d \n"

.balign 4
tableText: .asciz "Following is the number and the product of the integers from 1 to n. \n"

.balign 4
tableHead: .asciz "Number            n!\n"

.balign 4
table: .asciz "%d            %d\n"

.balign 4
numInputPattern: .asciz "%d"

.balign 4
numInput: .word 0 

.balign 4
total: .word 1

.balign 4
loopNum: .word 1