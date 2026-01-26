.global main
.global calculo_potencia_dos

calculo_potencia_dos:
  push {lr}

  cmp r0, #0
  blt error

  cmp r0, #31
  bgt error

  mov r1, #1
  mov r0, r1, LSL r0

  pop {lr}
  bx lr

error:
  mov r0, #0
  pop {lr}
  bx lr

main:
  push {lr}
    
  mov r0, #5           
  bl  calculo_potencia_dos
    
  pop {pc}


