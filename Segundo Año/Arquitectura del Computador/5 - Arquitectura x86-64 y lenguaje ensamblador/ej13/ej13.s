/*unsigned long fact2(unsigned long x)
{
unsigned long acc = 1;
for (; x > 1; x--) {
acc *= x;
}
return acc;
}*/

# VERSION 1
.text
.globl fact2
fact2:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp
    
    # Cuerpo
    movq %rdi, -8(%rbp)     # Guardamos x en la pila
    movq $1, -16(%rbp)       # Guardamos acc=1 en la pila

loop_fact2:
    movq -8(%rbp), %rax     # Cargamos x en edx
    cmpq $1, %rax           # Comparamos x con 1
    jle fin_fact2           # Si edx=1 finalizamos

    movq -16(%rbp), %rax     # rax=acc
    imulq -8(%rbp), %rax    # rax=acc*x
    movq %rax, -16(%rbp)     # acc= eax

    decq -8(%rbp)           # x--
    
    jmp loop_fact2

fin_fact2:
    movq -16(%rbp), %rax

    # epilogo
    movq %rbp, %rsp
    popq %rbp
    ret
