.fpu vfpv3

.data
a:    .float 1.0, 2.0, 3.0, 4.0, 5.0
b:    .float 2.0, 4.0, 6.0, 8.0, 10.0
c:    .space 20                      @ 5 floats = 20 bytes

str1: .asciz "%f\n"
str2: .asciz "La suma de las componentes es: %f\n"

.text
.global main

main:
    push {lr}              @ Guardamos dirección de retorno

    mov r4, #0      
    mov r0, #0       @ i = 0
    vmov.f32 s10, r0     @ suma = 0.0

loop:
    cmp r4, #5             @ ¿i == 5?
    beq fin                @ Si sí, salimos

    @ ---- cargar a[i] ----
    ldr r1, =a             @ r1 = &a
    add r1, r1, r4, LSL #2 @ r1 = a + i*4
    vldr.f32 s0, [r1]      @ s0 = a[i]

    @ ---- cargar b[i] ----
    ldr r2, =b
    add r2, r2, r4, LSL #2 @ &b[i]
    vldr.f32 s1, [r2]      @ s1 = b[i]

    @ ---- c[i] = a[i] + b[i] ----
    vadd.f32 s2, s0, s1

    @ ---- guardar c[i] ----
    ldr r3, =c
    add r3, r3, r4, LSL #2 @ &c[i]
    vstr.f32 s2, [r3]

    @ ---- imprimir c[i] ----
    vcvt.f64.f32 d0, s2    @ convertir a double (printf usa double)
    ldr r0, =str1          @ primer argumento → string formato
    bl printf              @ printf("%f\n", (double)c[i])

    @ ---- suma += c[i] ----
    vadd.f32 s10, s10, s2

    add r4, r4, #1         @ i++
    b loop

fin:
    @ ---- imprimir suma final ----
    vcvt.f64.f32 d0, s10   @ convertir a double
    ldr r0, =str2
    bl printf

    mov r0, #0
    pop {lr}
    bx lr
