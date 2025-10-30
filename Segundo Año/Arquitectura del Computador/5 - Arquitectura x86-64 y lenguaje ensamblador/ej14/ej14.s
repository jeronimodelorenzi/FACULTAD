/*
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
    */

.data
str1: .asciz "Ingrese al menos un argumento\n"
str2: .asciz "Cantidad de argumentos ingresados: %d. La suma es %lu.\n"
.text
.global main
main:
    # prólogo
    pushq %rbp          
    movq %rsp, %rbp
    subq $16, %rsp

    # Asignación en pila
    movq %rdi, -8(%rbp)     # Guardamos en la pila el valor de argc
    movq %rsi, -16(%rbp)    # Guardamos en la pila la dirección del primer elemento de argv

    # Si no hay argumentos
    movq -8(%rbp), %rdi     # rdi=argc
    decq %rdi               # rdi=argc-1
    je print_str1           # Si rdi=0 => vamos a printear la cadena 1

    # Si hay argumentos
    xor %r12, %r12
    movq -8(%rbp), %r14     # r14=argc 
    decq %r14               # r14=r14-1=argc-1 (dado que también cuenta la llamada ./a.out)
    movq -16(%rbp), %r13    # r13=argv (es decir, la dirección del primer elemento del array)
    addq $8, %r13           # r13=r13+8 pasamos al segundo elemento del array

loop_suma:
    cmpq $0, %r14           # realizamos la comparación r14-0
    je fin_suma             # Si r14=0 => salteamos a printear la cadena 2

    movq (%r13), %rdi       # Desreferenciamos r13, ahora rdi tiene el contenido de la dirección donde apunta r13
    call atoi               
    imulq %rax, %rax        # rax=rax*rax. El valor guardado en rax debio a la llamada atoi lo elevamos al cuadrado
    addq %rax, %r12         # r12=r12+rax

    addq $8, %r13           # r13=r13+8, pasamos a la siguiente dirección del array
    decq %r14               # r14=r14-1
    jmp loop_suma           

fin_suma:
    movq -8(%rbp), %rsi     # rsi=argc  (segundo argumento de printf)
    decq %rsi               # rsi=rsi-1 (le sacamos el llamado) 
    movq %r12, %rdx         # rdx=r12 (%lu del de printf)
    leaq str2, %rdi         # rdi=dirección de str
    xor %rax, %rax          # rax=0 ya que no tenemos que representar punto flotante
    call printf
    jmp fin
    
print_str1:
   # movq -8(%rbp), %rsi
    leaq str1, %rdi
    xor %rax, %rax
    call printf

fin:
    # epílogo
    movq %rbp, %rsp
    popq %rbp
    ret

.section .note.GNU-stack    
