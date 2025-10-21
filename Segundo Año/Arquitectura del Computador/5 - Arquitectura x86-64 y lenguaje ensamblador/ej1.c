#include <stdio.h>

// a

// Dado el siguiente código en assembler vamos a interpretar las instrucciones en C.
// .global main
// main:
//   movb $0xFF, %al # copia el valor inmediato 0xFF de 8 bits en la los bits menos significativo del 
//                   # registro %eax de 32 bits entonces resulta
//                   # %eax = 0x000000FF
//   ret             # retorna

//int main () {
//  return 255;        // Al retornar trabajamos con INT entonces queda el registro eax
                       // el valor 0xFF es igual si lo tomamos como unsigned a 255.
//}

// b

// Dado el siguiente código en assembler vamos a interpretar las instrucciones en C.
// .global main
// main:
//   movb $0xFE, %al
//   movb $-1, %bl
//   addb %bl, %al
//   inc %bl
//   ret

/* 
Explicamos el código:
• La instrucción movb $0xFE, %al copia el valor inmediato 0xFE al registro %al
(8 bits menos significativos del registro %eax)
• La instrucción movb $-1, %bl copia el valor inmediato -1 = 0xFF (complemento a dos) al registro $bl
(8 bits menos significativos del registro %ebx)
• La instrucción addb %bl, %al realiza la suma entera entre los registros %bl y %al guardando el resultado en %al.
    1
  0xFF
+ 0xFE
_______
 0x1FD
Veamos que la suma realiza un acarreo final por lo que CF = 1. Como sumamos dos números negativos y el resultado
sigue siendo negativo OF=0, SF=1.
• La instrucción inc %bl incrementa en uno el valor guardado en el registro %bl. Se activan la banderas OF y CF pues obtenemos un
desbordamiento y overflow.
• La instrucción ret retorna lo que se encuentra guardado en el registro %al.
*/

// int main () {
//   signed char al = -2;
//   signed char bl = -1;
//   al = al + bl;
//   bl = bl + 1; 
//   return (unsigned char)al;
//}
