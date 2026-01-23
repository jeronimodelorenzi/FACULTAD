@ Suponemos que el registro r3 contiene el valor 0x8000.

str r6, [r3, #12]       @ Se guarda r6 a partir de la dirección r3+12.
                        @ r3 no se modifica, entonces r3 = 0x8000
strb r7, [r3], #4       @ Primero se guardan 8 bits de r7 a partir de la dirección de r3
                        @ y luego se suma 4 a r3, entonces r3 = 0x8000 + 4 = 0x8004.
ldrh r5, [r3], #8       @ Se cargan 16 bits en r5 desde la dirección de r3 y luego se 
                        @ suma 8 a r3, entonces r3 = 0x800C.
ldr r12, [r3, #12]!     @ Se cargan en r12 a partir de la dirección r3+12 y luego se guarda
                        @ en r3, entonces r3 = 0x8018