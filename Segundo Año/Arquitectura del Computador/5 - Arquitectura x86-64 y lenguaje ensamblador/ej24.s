.data
a: .float 1.0, 2.0, 3.0          # arreglo a
b: .float 4.0, 5.0, 6.0          # arreglo b
fmt: .asciz "a[%d] = %f\n"       # formato para printf

.text
.global sum
sum:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movq %rdi, -8(%rbp)         # *a
    movq %rsi, -16(%rbp)        # *b
    movl %edx, -20(%rbp)         # len
    movl $0, -24(%rbp)          # i = 0

loop_suma:
    movl -24(%rbp), %eax        # eax=i
    cmpl -20(%rbp), %eax         
    jge fin               # i >= len
    #--------------
    movq -8(%rbp), %rdi         # rdi=a
    movq -16(%rbp), %rsi        # rsi=b
    movss (%rdi, %rax, 4), %xmm0 # xmm0=a[i]
    movss (%rsi, %rax, 4), %xmm1 # xmm1=b[i]

    addss %xmm1, %xmm0      # suma =suma+a[i]

    movss %xmm0, (%rdi, %rax, 4)  

    addl $1, -24(%rbp)          # i=i+1
    jmp loop_suma

fin:
    movq %rbp, %rsp
    popq %rbp
    ret

.global main
main:
    # --- Prólogo ---
    pushq %rbp
    movq %rsp, %rbp
    subq $8, %rsp

    # --- Llamar a sum(a, b, 3) ---
    leaq a, %rdi               # primer argumento: puntero a
    leaq b, %rsi               # segundo argumento: puntero b
    movl $3, %edx               # tercer argumento: len = 3
    call sum

    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

