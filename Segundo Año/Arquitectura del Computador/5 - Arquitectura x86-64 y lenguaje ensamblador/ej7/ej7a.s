.text
.global main
main:
  movq $0xffffffff00000000, %rax
  rol $32, %rax
  ret