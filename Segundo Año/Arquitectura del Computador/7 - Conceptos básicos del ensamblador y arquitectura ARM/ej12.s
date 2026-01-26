.data
  a: .word 1, 2, 3, 4                       @ Arreglo a[].
  b: .word 2, 3, 4, 5                       @ Arreglo b[].
  string: .asciz "La suma es: %d\n"         @ Cadena para el printf.

.text
.global main

main:
  push {lr}

  ldr r0, =a                                @ Cargamos en r0 el contenido que se encuentra en la dirección de memoria de a.
  ldr r1, =b                                @ Cargamos en r1 el contenido que se encuentra en la dirección de memoria de b.
  mov r2, #4                                @ El tercer argumento de la función es L=4.

  bl suma

  mov r1, r0                                @ Primer argumento de printf.
  ldr r0, =string                           @ Segundo argumento de printf.
  bl printf                                 @ Llamada a función printf.

  mov r0, #0                                @ return 0.
  pop {lr}
  bx lr

suma:
  push {lr}

  push {r4}                                 @ Preservamos el valor de r4 debido a que es calle-saved.
  push {r5}                                 @ Preservamos el valor de r5 debido a que es calle-saved.
  push {r6}                                 @ Preservamos el valor de r6 debido a que es calle-saved.
  push {r7}                                 @ Preservamos el valor de r7 debido a que es calle-saved.
  @ Podemos usar push {r4-r7}

  mov r4, #0                                @ i = 0.
  mov r5, #0                                @ result = 0.

for:
  cmp r4, r2                                @ i - L < 0 => i < L
  ldrlt r6, [r0, r4, LSL #2]                @ Cargamos en r6 el contenido a partir de la dirección r0+r4*4 (<< 2).
  ldrlt r7, [r1, r4, LSL #2]                @ Cargamos en r7 el contenido a partir de la dirección r1+r4*4 (<< 2).

  addlt r5, r6                              @ result = result + a[i].
  addlt r5, r7                              @ result = (result + a[i]) + b[i].

  add r4, #1                                @ i++.
  blt for                                   @ Si i<L se repite.

  mov r0, r5                                @ Movemos el valor de resultado al registro r0.

  pop {r7}                                  @ Devolvemos el valor de r7 original.
  pop {r6}                                  @ Devolvemos el valor de r6 original.
  pop {r5}                                  @ Devolvemos el valor de r5 original.
  pop {r4}                                  @ Devolvemos el valor de r4 original.

  pop {lr}
  bx lr
  