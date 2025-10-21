# 1 << 31
.text
.global main
 main:
  movl $1, %eax  # eax=1
  shll $31, %eax # desplazamiento de 31 bits hacia la izquierda
  ret

