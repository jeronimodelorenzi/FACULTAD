.data
a: .long 1, 2, 3, 4
g: .quad 0x1122334455667788
msg: .asciz "Imprime %c\n"

.text
.global main
main:
  movq $0x7fffffffebc8, %rsp    # rsp=0x7fffffffebc8
  subq $8, %rsp                 # rsp=0x7fffffffebc8-8=0x7fffffffebc0
  movq $g, %rax                 # rax=0x404028 (dirección de memoria de g)
  movl g+4, %eax                # g+4=0x11223344 -> rax=0x11223344 
  movq $3, %rbx                 # rbx=0x3
  movb a(, %rbx, 4), %al        # a(, %rbx, 4)=nada+rbx*4+a=0x3*4+0x404018
                                # =0xc+0x404018 = 0x404024 -> en esta dirección de memoria
                                # se encuentra el valor 0x04 -> rax=11223304
  leaq msg, %rdi                # rdi= 0x404030
  movb (%rdi, %rbx, 2), %sil    # (%rdi, %rbx, 2)=rdi+rbx*2+nada=0x404030+0x3*2
                                # =0x404030+0x6=0x404036 -> en esta dirección de memoria
                                # se encuentra el valor 'e' -> sil = 0x65 ('e')
  xorl %eax, %eax               # rax=0x0
  call printf                   # printf guarda la cantidad de caracteres (Imprime e\n)
                                # 10 * 1 = 1 -> rax= 0xa
  addq $8, %rsp                 # rsx=0x7fffffffebc0+8=0x7fffffffebc8
  ret