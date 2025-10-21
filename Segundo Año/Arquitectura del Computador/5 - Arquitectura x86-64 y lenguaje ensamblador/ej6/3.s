# -1 & 0xFFFFFF00
.text
.global main
main:
  movl $-1, %eax          
  andl $0xffffff00, %eax    
  ret