# 0xAA | (0xAA << 24)
.text
.global main
main:
  movl $0xAA, %eax
  movl $0xAA, %ebx
  shll $24, %ebx
  orl %ebx, %eax
  ret