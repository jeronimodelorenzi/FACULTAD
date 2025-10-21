.text
.global main
main:
  movq $-1, %rax  # rax=0xffffffffffffffff
  movb $0, %al  # al = 0x0, rax = 0xffffffffffffff00
  movw $0, %ax  # ax = 0x0, rax = 0xffffffffffff0000
  movl $0, %eax # eax = 0x0, rax = 0
  ret

# La conclusión a la que se puede llegar es que en cada instrucción se va cambiando
# el valor de un subregistro. Primero al registro de 64 bits rax se le asigna el valor
# -1, luego a cada subregistro se le asigna el valor 0, modificando tambien el valor de rax.
# En el caso del registro eax, al modificar los 32 bits menores, el procesador limpia los más
# altos de rax. Dejanto todos en 0. En cambio, al y ax no modifican los superiores.