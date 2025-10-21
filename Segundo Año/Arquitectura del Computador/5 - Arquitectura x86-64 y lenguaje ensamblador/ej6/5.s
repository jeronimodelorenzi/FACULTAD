# 5 << 8
.text
.global main
main:
  movl $5, %eax
  shll $8, %eax
  ret