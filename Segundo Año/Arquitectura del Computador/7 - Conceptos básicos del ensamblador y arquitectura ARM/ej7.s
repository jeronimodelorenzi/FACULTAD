.global main
main:
  @add r3, r7, #1023        @ 1023 = 0000 0000 0000 0000 0000 0011 1111 1111, tenemos que el valor inmediato 1023 no es posible de representar
                              @                                                 utilizando la formula de I • (2 x R) donde I es el número de 8 bits
                              @                                                 y R número de 4 bits utilizado para la rotación. Esto ocurre debido a
                              @                                                 que la cantidad de bits encendidos es mayor a 8 (tenemos 10). Entonces
                              @                                                 la manera correcta es la siguiente:
  ldr r2, =0x3FF              @ Cargamos el literal pool 0x3FF en r2.
  add r3, r7, r2              @ r3 = r7 + r2 (no sabemos el valor de r7).
  
  @sub r11, r12, r3, LSL #32  @ El error está en intentar rotar 32 veces el número, de esta forma estamos limpiando por completo el registro, es decir,
                              @ r3 = 0. La operación LSL admite valores entre 0 a 31. Si queremos no modificar nada, entoces podemos realizar:
  mov r11, r12
