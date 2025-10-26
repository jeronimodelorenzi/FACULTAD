.data
list: .long 40, 20, 30, 10, 50, 60, 70, 80, 90, 100
length: .byte 10
str_suma: .asciz "SUMA: %d\n"
str_max: .asciz "MAXIMO: %d\n"
str_min: .asciz "MINIMO: %d\n"
str_prom: .asciz "PROMEDIO: %d\n"
.text
sumar:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp

    # cuerpo
suma_loop:
    addl (%rsi), %edi   # edi=edi+esi
    addq $4, %rsi       # (sumamos 4 en la dirección de rsi) rsi=rsi+4
    loop suma_loop      # mientras sea distinto de 0 iteramos

    movl %edi, %eax

    # epílogo
    movq %rbp, %rsp
    popq %rbp
    ret

maximo:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp

    # cuerpo
loop_maximo:
    cmpl %r8d, (%rsi)   # Destino mayor que el origen, es decir r8 < rsi (CF = 0)
    ja intercambiar_max # Si el valor de rsi es mayor a r8 saltamos a intercambiar
    addq $4, %rsi       # Siguiente dirección de list
    loop loop_maximo    # Volvemos a iterar mientras cl distinto de 0
    
intercambiar_max:
    movl (%rsi), %r8d    # Cambiamos el valor del máximo
    addq $4, %rsi       # Siguiente dirección de list
    loop loop_maximo    # Saltamos a loop_maximo

    # epílogo
    movl %r8d, %eax
    movq %rbp, %rsp
    popq %rbp
    ret


minimo:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp

    # cuerpo
    loop_minimo:
    cmpl %r9d, (%rsi)  # Destino mayor que el origen, es decir r9  rsi (CF = 1)
                       # queremos cambiar si CF=1
    jb intercambiar_min # Si el valor de rsi es menor a r9
    addq $4, %rsi
    loop loop_minimo

    movl %r9d, %eax
    movq %rbp, %rsp
    popq %rbp
    ret

intercambiar_min:
    movl (%rsi), %r9d
    addq $4, %rsi
    loop loop_minimo
    # epílogo

.global main
main: 
    # prólogo
    pushq %rbp
    movq %rsp, %rbp

    # Limpiamos
    xor %rdi, %rdi      # Limpiamos rdi (suma)
    xor %rsi, %rsi      # Limpiamos rsi (list)
    xor %rcx, %rcx      # Limpiamos rcx (length)
    xor %r8, %r8        # Limpiamos r8 (max)
    xor %r9, %r9        # Limpiamos r9 (min)
    xor %rax, %rax      # Limpiamos rax (divisor)
    xor %rdx, %rdx      # Limpiamos rdx (bits mas significativos  de idiv)

    # Suma
    movb length, %cl    # (parte baja de rcx) cl=10
    leaq list, %rsi     # Dirección del primer elemento del arreglo
    call sumar          # Obtenemos la suma del arreglo
    
    # printf suma
    movl %eax, %r15d 
    xor %rax, %rax      # Limpiar eax
    leaq str_suma, %rdi
    movl %r15d, %esi
    call printf

    # Máximo
    xor %rsi, %rsi      # Limpiamos rsi (list)
    xor %rcx, %rcx      # Limpiamos rcx (length)
    movb length, %cl    # cl=length
    leaq list+4, %rsi   # rsi guarda la segunda dirección de memoria de list
    movl list, %r8d     # tomamos el máximo como el primer elemento
    dec %ecx
    call maximo

    # printf máximo
    movl %eax, %r11d 
    xor %rax, %rax      # Limpiar eax
    leaq str_max, %rdi
    movl %r11d, %esi
    call printf

    # Mínimo
    xor %rsi, %rsi     # Limpiamos rsi (list)
    xor %rcx, %rcx     # Limpiamos rxc (length)
    movb length, %cl    # cl=length
    leaq list+4, %rsi   # rsi guarla la segunda dirección de memoria de list     
    movl list, %r9d     # tomamos el mínimo como el primer elemento
    dec %ecx
    call minimo

    # printf mínimo
    movl %eax, %r12d 
    xor %rax, %rax      # Limpiar eax
    leaq str_min, %rdi
    movl %r12d, %esi
    call printf

    # Promedio
    movl %r15d, %eax     # rax=resultado de la suma de la lista
    movb length, %cl    # cl=length
    xorl %edx, %edx
    idivl %ecx          # eax=eax/ecl

    # printf promedio
    movl %eax, %esi
    xor %rax, %rax      # Limpiar eax
    leaq str_prom, %rdi
    call printf

    # epílogo
    movq %rbp, %rsp
    popq %rbp
    ret
