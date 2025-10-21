.global main
main:
  movq $0x1122334455667788, %rax
  addq $0x1122334455667788, %rax
  ret

# El error es "no coincide el tipo de operando para «add»".
# Esto ocurre porque estamos estamos intenta sumar un valor
# inmediato de 64 bits y add tiene limite de suma con valores
# inmediatos.