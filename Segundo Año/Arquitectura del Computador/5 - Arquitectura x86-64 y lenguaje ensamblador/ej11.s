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
  movq l, %rcx

  apilando:
    pushq (%rbx)
    addq $1, %rbx
    loop apilando

  movq l, %rcx
  leaq a, %rbx

  desapilando:
    popq (%rbx)
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
  
  leaq a, %rbx
  call vuelta

  ret

.section .note.GNU-stack
