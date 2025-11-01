
/*
int calculo(char a, char b, char c, int d, char e, float f, double g, int h,
int i, int j){
return (a+c+d)*(i+j);
}
*/
.data
f: .float 1.0
g: .double 2.0
.text
calculo:
    pushq %rbp
    movq %rsp, %rbp
    subq $36, %rsp          # rsp en rbp-36

    movb %dil, -4(%rbp)     # a en rbp-4 (parte baja)
    movb %sil, -8(%rbp)     # b en rbp-8 (parte baja)
    movb %dl, -12(%rbp)     # c en rbp-12 (parte baja)
    movl %ecx, -16(%rbp)    # d en rbp-16 (32 bits = 4 bytes)
    movb %r8b, -20(%rbp)    # e en rbp-20 (parte baja)
    movss %xmm0, -24(%rbp)  # f en rbp-24 (32 bits = 4 bytes) 
    movsd %xmm1, -32(%rbp)  # g en rbp-32 (64 bits = 8 bytes)
    movl %r9d, -36(%rbp)    # h en rbp-36 (32 bits = 4 bytes)

    # usamos el registro rax para sumar (a+b+c)
    # y el registro rdx para mover los valores
    xorq %rax, %rax         # rax=0
    xorq %rdx, %rdx         # rdx=0
    movb -4(%rbp), %al      # al=rbp-4
    movb -12(%rbp), %dl     # dl=rbp-12
    addb %dl, %al           # al=al+dl (a+c)
    movl -16(%rbp), %edx    # edx=rbp-16
    addl %edx, %eax         # eax=eax+edx ((a+c)+d)

    # usamos el registro rcx para sumar (i+j)
    # y el registro rdx para mover los valores
    xorq %rcx, %rcx         # rcx=0
    xorq %rdx, %rdx         # rdx=0
    movl 16(%rbp), %ecx     # ecx=rbp+4
    movl 24(%rbp), %edx     # edx=rbp+8  
    addl %ecx, %edx         # edx=edx+ecx (i+j)

    imull %edx, %eax        # eax= eax*edx (a+c+d)*(i+j)

    movq %rbp, %rsp
    popq %rbp
    ret

.global main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    pushq $8            # j
    pushq $7            # i
    movsd g, %xmm0      # g
    movss f, %xmm1      # f
    movl $6, %r9d       # h
    movb $5, %r8b       # e
    movl $4, %ecx       # d
    movb $3, %dl        # c
    movb $2, %sil       # b
    movb $1, %dil       # a
    call calculo

    movq %rbp, %rsp
    popq %rbp
    ret
