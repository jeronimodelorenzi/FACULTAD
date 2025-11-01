.data
msgFoo1: .asciz "Ejecutando foo1\n"
msgFoo2: .asciz "Ejecutando foo2\n"
printA: .asciz "0x %x\n"
printMain: .asciz "0x %x 0x %x\n"
a: .long 0x7fffffff
b: .long 1
.text
foo1:
    pushq %rbp
    movq %rsp, %rbp

    leaq msgFoo1, %rdi
    xorq %rax, %rax
    call printf

    movl a, %eax
    movl b, %ecx
    sall $31, %ecx
    addl %ecx, %eax
    movl %eax, a

    leaq printA, %rdi
    movl a, %esi
    xorq %rax, %rax
    call printf

    movl a, %eax
    
    movq %rbp, %rsp
    popq %rbp
    ret

foo2:
    pushq %rbp
    movq %rsp, %rbp

    leaq msgFoo2, %rdi
    xorq %rax, %rax
    call printf

    movl a, %eax
    movl b, %ecx
    addl %ecx, %eax
    movl %eax, a

    leaq printA, %rdi
    movl a, %esi
    xorq %rax, %rax
    call printf

    movl a, %eax
    
    movq %rbp, %rsp
    popq %rbp
    ret

.global main
main:
    pushq %rbp
    movq %rsp, %rbp

    xorq %rax, %rax
    call foo2
    movl %eax, %r12d    # Revisar esto

    xorq %rax, %rax
    call foo1
    movl %eax, %esi

    leaq printMain, %rdi
    movl %r12d, %edx    # Revisar esto
    xorq %rax, %rax
    call printf

    xorq %rax, %rax

    movq %rbp, %rsp
    popq %rbp
    ret
