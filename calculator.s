# A terminal calculator
#
# Reads a line of input, interprets it as a simple arithmetic expression,
# and prints the result. The input format is
# <long_integer> <operation> <long_integer>

# Make `main` accessible outside of this module
.global main

# Start of the code section
.text

main:
  # Function prologue
  enter $0, $0

  # Use scanf to retrieve and process a line of input
  # This block implements the following line of C code: 
  #   scanf("%ld %c %ld", &a, &op, &b);
  # Take a look at the man page for scanf and ask questions. You can also look 
  # at scanf_example.c
  movq $scanf_fmt, %rdi
  movq $a, %rsi
  movq $op, %rdx
  movq $b, %rcx
  xorb %al, %al
  call scanf

  movb op, %rbp # TODO: load the operation for comparisons
  movq a, %rsp  # TODO: and the LHS

  # TODO: Analyze operation and execute
  cmpb (%rbp), '+'
  je addition

  cmpb (%rbp), '-'
  je subtraction

  cmpb (%rbp), '*'
  je multiplication

  cmpb (%rbp), '/'
  je division

  jmp opError # Throw unknown operation error if not recognized

  addition:
    # Add values

  subtraction:
    # Subtract values

  multiplication:
    # Multiply values

  division:
    # Divide values
    # Check second value not zero
    cmpq (%rcx), $0x0
    je divZeroError

  # TODO: Print result

  #call printf

  # TODO: Print error if operation cannot be (safely) performed
  divZeroError:
    # Divide by zero
    # set error message: "Divide by zero error"
    #call printf
    movq $0x1, %rax
    jmp end

  opError:
    # Unrecognized operation
    # set error message: "Unknown operation"
    #call printf
    movq $0x1, %rax
    jmp end
  
  end:
    # End of the code
    # Return value should already be set by error handlers
    ret

  # if (op_char == '+') {
  #   ...
  # }
  # else if (op_char == '-') {
  #  ...
  # }
  # ...
  # else {
  #   // print error
  #   // return 1 from main
  # }

  # Function epilogue
  leave
  ret


# Start of the data section
.data

output_fmt: 
  .asciz "%ld\n"
scanf_fmt: 
  .asciz "%ld %c %ld"  # TODO: modify as needed

# "Slots" for scanf
a:  .quad 0
b:  .quad 0
op: .byte 0

