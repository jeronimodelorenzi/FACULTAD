 .fpu vfpv3


.data

a: .float 1.0, 2.0, 3.0, 4.0, 5.0
b: .float 2.0, 4.0, 6.0, 8.0, 10.0
c: .space 20
str_for: .asciz "%f\n"
str_tot: .asciz "La suma de las componentes es: %f\n"

.align 2
cero: .float 0.0

.text
.global main

main:
  push {r4, r5, r6, lr}

  ldr r0, =cero
  vldr s16, [r0]
  mov r4, #0

for:
  ldr r0, =a
  ldr r1, =b
  ldr r2, =c

  mov r5, r4, LSL #2

  add r6, r0, r5
  vldr s0, [r6]

  add r6, r1, r5
  vldr s1, [r6]

  vadd.f32 s2, s0, s1

  add r6, r2, r5             
  vstr s2, [r6]

  vadd.f32 s16, s16, s2

  vcvt.f64.f32 d0, s2
  vmov r2, r3, d0
  ldr r0, =str_for
  bl printf

  add r4, r4, #1
  cmp r4, #5
  blt for

  vcvt.f64.f32 d0, s16
  vmov r2, r3, d0
  ldr r0, =str_tot
  bl printf

  mov r0, #0
  pop {r4, r5, r6, lr}
  bx lr
