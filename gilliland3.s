@
@ Program Name: gilliland3.s
@ Author: Matthew Gilliland
@ Date: 03/15/2026
@ Email: mwg0013@uah.edu
@ Class: CS309-01 Spring 2026
@
@ These commands assemble, link, run and debug the code.
@ Student should change the following to match their code filename. 
@
@ gcc gilliland3.s -g -c -o gilliland3.o
@ gcc gilliland3.o -g -o gilliland3
@ ./gilliland3
@ gdb --args ./gilliland3 
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
    
    ldr r1, =numInput           @ Load number
    ldr r1, [r1]


@*******************
compare:
@*******************
    cmp r1, #100        @ Compare r1 (input) with 100
    blt lessThan          @ Branch to lessThan if <100 or continue to greaterThan

@*******************
greaterThan:
@*******************
    ldr r0, =greaterText
    bl printf
    b prompt2

@*******************
lessThan:
@*******************
    ldr r0, =lesserText
    bl printf

@*******************
prompt2:
@*******************
    ldr r0, =charPrompt
    bl printf

@*******************
getCharInput:
@*******************
    ldr r0, =charInputPattern   @ Get Character
    ldr r1, =charInput
    bl scanf

    ldr r1, =charInput          @ Load character
    ldrb r1, [r1]
@*******************
checkLower:
@*******************
    cmp r1, #'a'
    blt checkUpper
    
    cmp r1, #'z'
    ble isLower

@*******************
checkUpper:
@*******************
    cmp r1, #'A'
    blt special

    cmp r1, #'Z'
    ble isUpper

@*******************
special:
@*******************
    ldr r0, =specText
    bl printf
    b myexit

@*******************
isLower:
@*******************
    ldr r0, =lowerText
    bl printf
    b myexit
@*******************
isUpper:
@*******************
    ldr r0, =upperText
    bl printf
    b myexit

@*******************
myexit:
@*******************
@ Return to the OS
POP {pc}

.data
@ Put user defined data in this section and make sure there is a blank line at the end of the file. 
@ Prompts
.balign 4
numPrompt: .asciz "Enter an integer: "
.balign 4
charPrompt: .asciz "Enter a single character: "
.balign 4
lesserText: .asciz "The input number is less than 100.\n"
.balign 4
greaterText: .asciz "The input number is greater than or equal to 100.\n"
.balign 4
lowerText: .asciz "Lower case letter entered.\n"
.balign 4
upperText: .asciz "Upper case letter entered.\n"
.balign 4
specText: .asciz "Special character entered.\n"

@ Input Patterns
.balign 4
numInputPattern: .asciz "%d"
.balign 4
charInputPattern: .asciz " %c"

@ Storage
.balign 4
numInput: .word 0 
.balign 4
charInput: .byte 0
