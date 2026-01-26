.global main
main:
@ 0xC0000034 => 1100 0000 0000 0000 0000 0000 0011 0100 => 0000 0000 0000 0000 0000 0000 1101 0011 (32-30 = 2) => 0xD3 ROR 2
  mov r2, #0xD3, 2
@ 0x12340000 => 0001 0010 0011 0100 0000 0000 0000 0000 => No es posible representar este valor inmediato sin crear un literal pool debido a que la
@                                                          distancia entre el bit menos significativo encendido y el más significativo encendido es
@                                                          mayor a 8. El LSB encendido se encuentra en 18 y el MSB 28, entonces 28-18 = 10 > 8.
@                                                          Negando el valor tampoco es posible pues la cantidad de bits encendidos es mayor a 8.
  ldr r2, =0x12340000                                                 
@ 0x77777777 => 0111 0111 0111 0111 0111 0111 0111 0111 => No es posible representar este valor inmediato sin crear un literal pool debido a que 
@                                                          la cantidad de bits encendidos es mayor a 8. Si negamos el número resulta
@               1000 1000 1000 1000 1000 1000 1000 1000,   donde la cantidad de bits encendidos es igual a 8, pero la distancia entre el bit menos
@                                                          significativo y más significativo encendido es mayor a 8. El LSB encendido se encuentra
@                                                          en el bit 3 y el MSB en el 31, con lo cual 31-3 = 28 > 8.
  ldr r2, =0x77777777
@ 0xFFFFFFFF => 1111 1111 1111 1111 1111 1111 1111 1111 => Negando el valor resulta 0000 0000 0000 0000 0000 0000 0000 0000, donde si es
@                                                          posible representar el valor inmediato utilizando mvn r2, #0.
  mvn r2, #0, 0
@ 0xFFFFFFFE => 1111 1111 1111 1111 1111 1111 1111 1110 => Negando el valor resulta 0000 0000 0000 0000 0000 0000 0000 0001, donde si es
@                                                          posible representar el valor inmediato utilizando mvn r2, #1, 0
  mvn r2, #1 ,0
