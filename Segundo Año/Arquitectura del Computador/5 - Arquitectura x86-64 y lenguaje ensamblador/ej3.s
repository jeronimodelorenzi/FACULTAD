.data
  N1: .byte 100
  N2: .byte 120
  N3: .byte -63
  N4: .byte -56
  N5: .byte -91
.text
.global main
main:
  movb $0, %al
  addb N5, %al
  subb N2, %al
  ret

/*
S1 = -36, como estamos sumando dos positivos y el resultado es negativo tenemos que OF=1, CF=0.
S2 = -119, estamos tomando numeros en complemento a dos, pero ocurre un acarreo final, por lo que CF=1, OF=0.
S3 = 102, como estamos sumando dos negativos y el resultado es positivo tenemos que OF=1, además ocurrio un acarreo final CF=1.
S4 = 35
S5 = 45, OF = 1 tendría que ser negativo
*/

/*
Ver resultados p/d $registro
Ver baderas p $eflags
*/