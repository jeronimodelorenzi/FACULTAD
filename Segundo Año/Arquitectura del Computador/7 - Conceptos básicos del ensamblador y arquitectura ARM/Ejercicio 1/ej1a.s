.data
  array: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

.text
.global main
main:
  mov r3, #7      @ Cargar el indice 7 en r3.
  mov r1, #1      @ Para comprobar si está bien.
  ldr r2, =array  @ Dirección inicial del arreglo.
  ldr r0, [r2, r3, LSL #2]  @ Carga en x la posición 7 del arreglo.
  add r0, r1      @ Suma x = array[7] + y.
  bx lr           @ Retorna.
