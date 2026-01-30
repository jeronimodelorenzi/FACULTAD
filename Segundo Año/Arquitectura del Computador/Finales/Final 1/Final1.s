.data
  array: .word 0xff00000f, 0x00001f80, 0xe0000000, 0x00f00000, 0x00000111
  str_pos: .asciz "El determinante es positivo, su valor %d\n"
  str_neg: .asciz "El determinante es negativo, su valor %d\n"
  str_nulo: .asciz "El deerminante es nulo\n"

.text
.global main

determinante:  @
  push {r4, lr}

  mul r0, r3
  mul r1, r2
  sub r0, r1

  pop {r4, lr}
  bx lr

main:
  push {r4,lr}

  ldr r4, =array
  ldr r0, [r4, #0]
  ldr r1, [r4, #4]
  ldr r2, [r4, #8]
  ldr r3, [r4, #12]

  bl determinante

  cmp r0, #0
  beq nulo
  bmi negativo

positivo:
  mov r1, r0
  ldr r0, =str_pos
  bl printf
  b fin

negativo:
  mov r1, r0
  ldr r0, =str_neg
  bl printf
  b fin

nulo:
  ldr r0, =str_nulo
  bl printf
  b fin

fin:
  mov r0, #0
  pop {r4, lr}
  bx lr
