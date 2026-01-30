.data
a: .word 1, 2, 3, 4
b: .word 5, 6, 7, 8
c: .word 0, 0, 0, 0

.text
.global main
suma:
  push {r4-r8, lr}

  ldr r3, =c
  mov r4, #0

for:
  ldr r5, [r0, r4, LSL #2]
  ldr r6, [r1, r4, LSL #2]

  add r7, r5, r6

  str r7, [r3, r4, LSL #2]

  add r4, #1
  cmp r4, r2

  bmi for
  pop {r4-r8, lr}
  bx lr

main:
  push {r4, lr}

  ldr r0, =a
  ldr r1, =b
  mov r2, #4

  bl suma

  mov r0, #0
  pop {r4, lr}
  bx lr
  