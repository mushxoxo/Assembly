.data
    menu: .asciiz "\nChoose an operation:\n1: Add\n2: Subtract\n3: Multiply\n4: Divide\n"
    enter_num1: .asciiz "\nEnter the first number: "
    enter_num2: .asciiz "\nEnter the second number: "
    result: .asciiz "\nThe result is: "
    error: .asciiz "\nError: Division by zero is not allowed.\n"
    ask_repeat: .asciiz "\nHow many times do you want to use the calculator? "
    goodbye: .asciiz "\nThank you for using the calculator. Goodbye!\n"

.text
.globl main

main:
    li $v0, 4               
    la $a0, ask_repeat
    syscall

    li $v0, 5              
    syscall
    move $t4, $v0         



calculator_loop:

    beqz $t4, exit         




    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0




    li $v0, 4
    la $a0, enter_num1
    syscall

    li $v0, 5
    syscall
    move $t1, $v0




    li $v0, 4
    la $a0, enter_num2
    syscall

    li $v0, 5
    syscall
    move $t2, $v0




    beq $t0, 1, addition
    beq $t0, 2, subtraction
    beq $t0, 3, multiplication
    beq $t0, 4, division
    j calculator_loop      




addition:
    add $t3, $t1, $t2
    j print_result


subtraction:
    sub $t3, $t1, $t2
    j print_result


multiplication:
    mul $t3, $t1, $t2
    j print_result


division:
    beq $t2, 0, div_error
    div $t1, $t2
    mflo $t3
    j print_result


div_error:
    li $v0, 4
    la $a0, error
    syscall
    sub $t4, $t4, 1
    j calculator_loop


print_result:
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    sub $t4, $t4, 1
    j calculator_loop



exit:
    li $v0, 4               
    la $a0, goodbye
    syscall

    li $v0, 10             
    syscall
