.data
fmt: .string "%d"
entero: .long -100
funcs:  .quad f1
        .quad f2
        .quad f3
.text
f1: movl $0, %esi; movq $fmt, %rdi; call printf; jmp fin
f2: movl $1, %esi; movq $fmt, %rdi; call printf; jmp fin
f3: movl $2, %esi; movq $fmt, %rdi; call printf; jmp fin
.global main
main:
    pushq %rbp
    movq %rsp, %rbp

    # Leemos el entero.
    movq $entero, %rsi      # rsi=dir. de memoria de la etiqueta entero
    movq $fmt, %rdi         # rdi=dir. de memoria de la etiqueta fmt
    xorq %rax, %rax         # Limpia rax
    call scanf

    xorq %rax, %rax         # Limpia el registro rax
    
# COMPLETE CON DOS INSTRUCCIONES.
    movl entero, %eax       # eax=entero=valor ingresado y leido por scanf
    movq funcs(, %rax,8), %rdx  # rdx=nada+rax*8+funcs => funcs[rax]
    jmp *%rdx               # Salta a lo que hay en el registro rdx
fin:
    movq %rbp, %rsp
    popq %rbp
    ret
     