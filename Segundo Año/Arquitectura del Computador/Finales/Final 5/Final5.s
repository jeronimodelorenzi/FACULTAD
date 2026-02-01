.fpu vfpv3

.data
a: .float 4095
b: .float 80
cons: .float 3
str: .asciz "El resultado es: %f\n"

.text
.global main

main:
  push {r4, lr}
  ldr r0, =a
  vldr s0, [r0]
  ldr r0, =b
  vldr s1, [r0]
  vmul.f32 s2, s0, s1

  bl promedio

  vcvt.f64.f32 d0, s0
  vmov r2, r3, d0
  ldr r0, =str
  bl printf

  mov r0, #0
  pop {r4, lr}
  bx lr

promedio:
  vadd.f32 s0, s0, s1
  vadd.f32 s0, s0, s2

  ldr r0, =cons
  vldr s4, [r0]

  vdiv.f32 s0, s0, s4
  bx lr
