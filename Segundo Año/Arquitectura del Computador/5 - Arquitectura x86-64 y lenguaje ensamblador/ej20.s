.data
msg_insuficiente: .asciz "La cantidad de argumentos es insuficiente"
msg_bien: .asciz "Cantidad de argumentos: %d, suma de los argumentos: %d\n"

.text
.global main
main:
    # Prólogo
    pushq %rbp                      # Preserva en la pila el valor del rbp llamante           
    movq %rsp, %rbp                 # La pila comienza en el tope
    subq  $32, %rsp                 # Alinea la pila a 32 bytes

    # Limpiar
    xorq %rax, %rax                 # rax=0

    # Asignación en pila
    movl %edi, -20(%rbp)            # Guardamos argc en la pila
    movq %rsi, -32(%rbp)            # Guardamos la dirección del primer elemento de argv

    # Si argc tiene menos de dos argumentos
    cmpl $2, -20(%rbp)              # Realia la comparación -20(%rbp)-2 (argc-2)
    jl insuficiente                 # si argc-2 < 0 salta a insuficiente

    # Si tiene dos argumentos o más
    movl $1, -4(%rbp)               # Guardamos una variable local en la pila (i=1)
    movl $0, -8(%rbp)               # Guardamos una variable local en la pila (suma=0)

loop_suma:
    movl -4(%rbp), %eax             # eax=-4(%rbp) en este caso eax=i
    cmpl -20(%rbp), %eax            # Realiza la comparación eax-[-20(%rbp)]
    jge fin_loop                    # Si eax >= -20(%rbp) saltamos a fin_loop (i >= argc)
    #----------
    movl -4(%rbp), %eax             # eax=-4(%rbp) en este caso eax=i
    leaq (,%rax,8), %rdx            # rdx=rax*8 (va cambiando dependiendo el valor de i)
    movq -32(%rbp), %rax            # rax=-32(%rbp) en este caso rax=argv (dirección del arreglo argv)
    addq %rdx, %rax                 # rax=rax+rdx nos movemos en el arreglo argv dependiendo lo obtenido en rdx
    movq (%rax), %rdi               # rdi=(%rax) obtenemos lo que hay en la dirección del arreglo argv
    xorq %rax, %rax                 # rax=0
    call atoi                       # Llamada a función atoi (se guarda en eax)
    addl %eax, -8(%rbp)             # -8(%rbp)=-8(%rbp)+eax, es decir suma=suma+eax
    addl $1, -4(%rbp)               # -4(%rbp)=-4(%rbp)+1, es decir i=i+1
    jmp loop_suma                   # Iteramos nuevamente

fin_loop:
    leaq msg_bien, %rdi             # Cargamos el mensaje en rdi (primer argumento de printf)
    decq -4(%rbp)                   # Decrementamos en uno la cantidad de argumentos (argc)
    movq -4(%rbp), %rsi             # Cargamos la cantidad de argumentos (argc) en rsi (segundo argumento de printf)
    movq -8(%rbp), %rdx             # Cargamos el resultado de la suma en rdx (tercer argumento de printf)
    xorq %rax, %rax                 # rax=0
    call printf                     # LLamada a función printf 
    jmp fin                         # Salto a fin
    
insuficiente:
    leaq msg_insuficiente, %rdi     # Cargamos el mensaje en rdi (primer argumento de printf)
    xorq %rax, %rax                 # rax=0
    call printf                     # Llamada a función printf
    jmp fin                         # Salto a fin

fin:
    # Epílogo
    xorq %rax, %rax                 # rax=0 (return 0)
    movq %rbp, %rsp                 # rsp vuelve a apuntar al tope de la pila anterior
    popq %rbp                       # Restaura el rbp del llamante
    ret                             # Retorno
