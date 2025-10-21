# (1 << 31) | (1 << 15)
.text
.global main
main:
  movl $1, %eax  # eax=1
  shll $31, %eax # desplazamiento 31 bits a la izquierda eax
  movl $1, %ebx  # ebx=1
  shll $15, %ebx # desplazamiento 15 bits a la izquierda ebx
  orl %ebx, %eax # or bit a bit guardando en eax
  ret