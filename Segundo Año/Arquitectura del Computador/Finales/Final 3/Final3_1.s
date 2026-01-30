.fpu vfpv3

.data
str: .asciz "%f hectareas = %f acres\n"
a_val: .float 7.0
cons: .float 2.471

.text
.global main

hectareas_2_acreas:
  push {r4,lr}

  ldr r0, =cons
  vldr s1, [r0]
  vmul.f32 s0, s0, s1
  pop {r4, lr}
  bx lr

main:
  push {r4, lr}

  ldr r0, =a_val
  vldr s0, [r0]

  bl hectareas_2_acreas

  vmov s2, s0
  ldr r1, =a_val
  vldr s0, [r1]
  vcvt.f64.f32 d0, s0
  vmov r2, r3, d0

  vcvt.f64.f32 d1, s2
  
  sub sp, sp, #8
  vstr d1, [sp]

  ldr r0, =str

  bl printf

  add sp, sp, #8

  mov r0, #0
  pop {r4, lr}
  bx lr
