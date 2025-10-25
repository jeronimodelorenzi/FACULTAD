# Implementar un programa en Assembler para invertir un arreglo de bytes de longitud
# conocida usando el stack.
# apilando” en sentido inverso.
# Ayuda: Esto puede ser logrado “apilando” los valores de a uno en el stack y luego ir “des-
# apilando” en sentido inverso.
.data
a: .byte 1, 2, 3, 4, 5
l: .byte 5
.text

vuelta:
# prologo
  pushq %rbp
  movq %rsp, %rbp

  # cuerpo
  xorq %rcx, %rcx
  movb l, %cl

  apilando:
    movb (%rbx), %al
    pushq %rax
    addq $1, %rbx
    loop apilando
  
    xorq %rcx, %rcx
  movb l, %cl
  leaq a, %rbx

  desapilando:
    popq %rax
    movb %al, (%rbx)
    addq $1, %rbx
    loop desapilando

  # epilogo
  movq %rbp, %rsp
  popq %rbp

  ret
  

.global main
main:
  # BUENA PRACTICA
  xorq %rcx, %rcx
  xorq %rbx, %rbx
  
  leaq a, %rbx
  call vuelta

  ret

.section .note.GNU-stack
