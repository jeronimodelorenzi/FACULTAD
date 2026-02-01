@ Escribir una funci ́on denominadacalculoen lenguaje ensamblador ARM que realice lo siguiente:
@ La funci ́oncalculorecibe cinco argumentos enteros y retorna un entero.
@ En caso de que todos los argumentos sean positivos, realiza la suma de los mismos, imprime 
@ el resultado de la sumay retorna dicho valor.
@ En  caso  de  que  alguno  de  los  argumentos  sea  negativo  o  nulo,  
@ la  funci ́oncalculodebe  llamar  a  otra  funci ́ondenominadafooque imprime un mensaje de error 
@ por pantalla y retornar -1.La funci ́onfoono tiene argumentos de entrada, 
@ debe imprimir el mensaje por pantalla “Todos los argumentos debenser positivos” y 
@ retornar -1 a la funci ́oncalculo.

.data
str_res: .asciz "El resultado de la suma es %d\n"
str_err: .asciz "Todos los argumentos deben ser positivos"

.text
.global calculo

calculo:
  push {r4, lr}

  cmp r0, #0
  ble foo_
  cmp r1, #0
  ble foo_
  cmp r2, #0
  ble foo_
  cmp r3, #0
  ble foo_

  ldr r4, [sp, #8]
  cmp r4, #0
  ble foo_

  add r0, r0, r1
  add r0, r0, r2
  add r0, r0, r3
  add r0, r0, r4

  mov r1, r0
  ldr r0, =str_res
  bl printf

  mov r0, r1
  pop {r4, lr}
  bx lr

foo_:
  bl foo
  pop {r4, lr}
  bx lr

foo:
  push {r4,lr}

  ldr r0, =str_err
  bl printf

  mov r0, #-1
  pop {r4, lr}
  bx lr
  