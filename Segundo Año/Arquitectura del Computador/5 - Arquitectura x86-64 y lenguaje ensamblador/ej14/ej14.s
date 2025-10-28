.text
.globl suma
suma:
    # prólogo
    pushq %rbp
    movq %rsp, %rbp

    # Limpiamos
    xor %r12, %r12        # contador
    xor %r14, %r14        # acumulador suma     

    # argc
    movq %rdi, %r12     # r12=rdi(argc)
    decq %r12           # r12=r12-1 (argc-1)
    je fin              # Finalizamos si argc=0

    # argv
    addq $8, %rsi       # rsi=rsi+8 (apunta a la segunda dirección del arreglo)

loop_suma:

    # Operaciones
    movq (%rsi), %rdi   # rdi=contenido de rsi (contenido de la segunda dirección del arreglo)
    movq %rsi, %r13     # Preservamos la dirección de rsi para el atoi
    call atoi           # Convierte el string en int, se guarda el resultado en rax
    movq %r13, %rsi     # Volvemos la dirección preservada al registro rsi
    addq $8, %rsi       # Pasamos a la siguiente dirección del arreglo
    
    imulq %rax, %rax    # Elevamos al cuadrado el contenido de rax
    addq %rax, %r14     # r14=r14+rax

    # Fin iteración
    decq %r12           # Decrementamos el contador que contiene a argc
    jne loop_suma       # Si no es cero iteramos de vuelta
     
    movq %r14, %rax     # rax=r14 debido a que retornamos
fin:
    # epílogo
    movq %rbp, %rsp
    popq %rbp
    ret
