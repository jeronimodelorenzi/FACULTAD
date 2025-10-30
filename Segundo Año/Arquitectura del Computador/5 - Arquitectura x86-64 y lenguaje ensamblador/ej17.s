/*
Agregue mas llamadas a printf en el codigo para imprimir:
a) El valor del registro rsp.
b) La direcci ́on de la cadena de formato.
c) La direcci ́on de la cadena de formato en hexadecimal.
d) El quad en el tope de la pila.
e) El quad ubicado en la direcci ́on rsp + 8.
f) El valor i.
g) La direcci ́on de i.
 */

.data
format: .asciz " %ld\n"
formatHexadecimal: .asciz " 0x%lx\n"
i: .quad 0xDEADBEEF
.text
.global main
main:
    movq $format, %rdi # El primer argumento es el formato
    movq $1234, %rsi # El valor a imprimir
    xorq %rax, %rax # Cantidad de valores de punto flotante
    call printf
    
    # a)
    leaq format, %rdi
    movq %rsp, %rsi
    xor %rax, %rax
    call printf

    # b)
    leaq format, %rdi
    leaq format, %rsi # movq $format, %rsi
    xor %rax, %rax
    call printf

    # c)
    leaq formatHexadecimal, %rdi
    leaq format, %rsi
    xor %rax, %rax
    call printf

    # d)
    leaq format, %rdi
    movq (%rsp), %rsi
    xor %rax, %rax
    call printf

    # e)
    leaq format, %rdi
    movq 8(%rsp), %rsi
    xor %rax, %rax
    call printf

    # f)
    leaq formatHexadecimal, %rdi
    movq i, %rsi
    xor %rax, %rax
    call printf

    # f)
    leaq formatHexadecimal, %rdi
    movq $i, %rsi
    xor %rax, %rax
    call printf

    ret

.section .note.GNU-stack    
