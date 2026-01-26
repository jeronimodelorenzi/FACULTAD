.fpu vfpv3

.global main
.global determinante

determinante:
  push {lr}

  vmul.F32 s0, s0, s3 @ Multiplicamos a*d.
  vmul.F32 s1, s1, s2 @ Multiplicamos b*c.
  vsub.F32 s0, s0, s1 @ Restamos a*d - b*c.

  vcvt.S32.F32 s1, s0
  vmov r0, s1

  pop {lr}
  bx lr

main:
  push {lr}

  vmov.F32 s0, #2 @ a = 2.
  vmov.F32 s1, #3 @ b = 3.
  vmov.F32 s2, #4 @ c = 4.
  vmov.F32 s3, #5 @ d = 5.

  bl determinante

  pop {lr}
  bx lr
