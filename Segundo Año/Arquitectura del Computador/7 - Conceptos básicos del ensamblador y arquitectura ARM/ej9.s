.global main
.global campesino_ruso

main:
  push {lr}         @ se preserva el valor de LR (dirección de retorno del main).

  mov r0, #12       @ i = 12.
  mov r1, #5        @ j = 5.
  bl campesino_ruso @ Llamada a la función campesino_ruso
  pop {lr}

campesino_ruso:     @ Los argumentos son r0 (i) y r1 (j).
  push {lr}         @ Se preserva el valor de LR (dirección de retorno de campesino ruso).
  eor r2, r2        @ r2 = 0.

while:
  tst r1, #1        @ Se realiza j & 1
  addne r2, r0      @ Si la bandera Z != 1, entonces r2 = r2+1.
  subne r1, #1      @ Si la bandera Z != 1, entonces r1 = r1-1.

  lsleq r0, r0, #1         @ Si la bandera Z = 1, entonces r0 = r0*2.
  lsreq r1, r1, #1        @ Si la bandera Z = 1, entonces r1 = r1/2.

  cmp r1, #1        @ Comparamos r1-1.
  bhi while         @ Si r1 > 1 ejecutamos el bucle nuevamente.

  add r0, r2, r0    @ Sumamos r0 = r2 + r0.

  pop {lr}         
  bx lr             @ Retornamos.
