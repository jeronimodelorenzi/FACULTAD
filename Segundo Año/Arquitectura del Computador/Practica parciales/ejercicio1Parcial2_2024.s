.data
str1: .asciz "Estoy en foo!\n"
str2: .asciz "La cantidad de argumentos es %d\n"
str3: .asciz "El argumento %d es %s\n"

.text
.global main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    call foo
    leaq str2, %rdi
    movq -8(%rbp), %rsi
    xorq %rax, %rax
    call printf
    xorl %r12d, %r12d
    movq -16(%rbp), %rbx

bucle:
    movq $str3, %rdi
    movq %r12, %rsi
    movq (%rbx, %r12, 8), %rdx
    xorq %rax, %rax
    call printf
    incq %r12
    cmpq -8(%rbp), %r12
    jb bucle
    movq %rbp, %rsp
    popq %rbp
    xorl %eax, %eax
    ret

foo:
    pushq %rbp
    movq %rsp, %rbp
    leaq str1, %rdi
    xorq %rax, %rax
    call printf
    movq %rbp, %rsp
    popq %rbp
    xorl %eax, %eax
    ret
