.global main
main:
  movl $-1, %eax    # Solo para ste tamaño el movl pone en 0 la parte alta del registro
                    # eax=0xffffffff
  movl $2, %ecx     # eax=0x00000002
  imull %ecx        # eax=0xfffffffe, edx=0xffffffff
  shlq $32, %rdx    # desplazamiento de 32 bits a la izq, rdx=0xffffffff00000000
  orq %rdx, %rax   # rax=0xfffffffffffffffe

  xorq %rax, %rax   # rax=0x0000000000000000
  movw $-1, %ax     # ax=0xffff
  movw $2, %cx      # cx=0x0002
  mulw %cx          # ax=0xfffe dx=0x0001
  shll $16, %edx    # edx = 0x00010000
  orl %edx, %eax    # eax=0x0001fffe

  ret
