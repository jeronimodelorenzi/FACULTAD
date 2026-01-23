.data
  array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

.text
.global main
main:
  mov r1, #1
  mov r4, #8                @ Carga el indice 8 en r4.
  ldr r2, =array            @ Dirección inicial del arreglo.
  ldr r3, [r2, r4, LSL #2]  @ Carga array[8] en r3.
  add r3, r1                @ Suma y + array[8].

  mov r4, #9                @ Carga el indice 10 en r4.
  str r3, [r2, r4, LSL #2]  @ Almacena el resultado en array[10]
  mov r0, r3                @ Para retornar.
  bx lr                     @ Retorna.