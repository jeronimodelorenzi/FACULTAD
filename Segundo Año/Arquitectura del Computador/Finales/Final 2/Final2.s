.fpu vfpv3

.data
a: .double 4095.0, 80.0, 50.0, 1020.0, 540.0
str: .asciz "El resultado es %f\n"
str_prom: .asciz "Calculando el promedio...\n"
zero_double:.double 0.0

.text
.global main
promedio:
  push {r0, r1, r2, lr}

  ldr r0, =str_prom
  bl printf

  pop {r0,r1,r2,lr}

  ldr r2, =zero_double
  vldr d1, [r2]
  mov r2, #0

for:
  add r3, r0, r2, LSL #3
  vldr.f64 d2, [r3]
  vadd.f64 d1, d1, d2
  add r2, #1

  cmp r2, r1
  bmi for

  vmov s4, r1              
  vcvt.f64.s32 d3, s4         
  vdiv.f64 d0, d1, d3
  
  bx lr

main:
  push {r4, lr}

  ldr r0, =a
  mov r1, #5

  bl promedio

  vmov r2, r3, d0
  ldr r0, =str
  bl printf

  mov r0, #0
  pop {r4, lr}
  bx lr
