.data
str_suma: .asciz "La suma de las notas es %lf.\n"
str_prom: .asciz "El promedio de las notas es %lf.\n"
str_sinNotas: .asciz "No hay notas.\n"
notas:  .double 7.5, 4.5
.text
.globl calcular_suma_y_promedio
calcular_suma_y_promedio:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movq %rdi, -8(%rbp)     # Guardamos la dirección del arreglo en la pila
    movq %rsi, -16(%rbp)    # Guardamos la cantidad de argumentos en la pila

    cmpq $0, -16(%rbp)      # Si cantidad=0
    je sin_notas            # saltamos a sin_notas

    xorpd %xmm0, %xmm0
    xorq %r12, %r12         # r12=0 (i=0)

suma:
    movq -8(%rbp), %rdi     # rdi=dirección del primer elemento del arreglo
    movsd (%rdi, %r12, 8), %xmm1    # arr[i] 
    addsd %xmm1, %xmm0      
    incq %r12
    cmpq -16(%rbp), %r12
    jb suma

    movsd %xmm0, -32(%rbp)
    leaq str_suma, %rdi
    movb $1, %al
    call printf

promedio:
    movsd -32(%rbp), %xmm0
    cvtsi2sd -16(%rbp), %xmm1
    divsd %xmm1, %xmm0      # xmm0 = xmm0/xmm1

    leaq str_prom, %rdi
    movb $1, %al
    call printf

fin:
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

sin_notas:
    leaq str_sinNotas, %rdi
    call printf
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret

.global main
main:
    pushq %rbp
    movq %rsp, %rbp
    leaq notas, %rdi     
    movq $2, %rsi              

    call calcular_suma_y_promedio

    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
