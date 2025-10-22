.text
.global main
main:
  movq $0xffffffff00000000, %rbx    # rbx=0xffffffff00000000
  movq $0, %rax                     # rax=0, contador de bits en 1
  movq $64, %rcx                    # rcx=64, como estamos trabajando con números de 64 bits, ponemos el contadoor
                                    # en 64, así cuando llegue a 0 corta.

count_bits:
  rol $1, %rbx                      # rotación a izquierda de rbx, el bit más significativo
                                    # pasa a la carry flag (CF)
  adc $0, %rax                      # sumamos el bit de la CF si está encendido y lo guardamos en rax
  loop count_bits

  ret                               # retorna rax
  