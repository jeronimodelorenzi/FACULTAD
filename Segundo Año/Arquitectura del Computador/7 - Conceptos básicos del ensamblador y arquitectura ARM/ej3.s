@ Supongamos que tenemos la arquitectura ARM little-endian.

@ Queremos ver que contendra el registro r4 luego de ejecutar las siguientes instrucciones.
str r6, [r3]  @ Se guarda r6 a partir de la dirección de r3.
ldrb r4, [r3] @ Se carga 1 byte en r4 a partir de la dirección de r3.

@ r6 contiene 0xBEEFFACE, por lo que se guarda en memoria 0xBEEFFACE en la dirección de r3.
@ Ahora bien, se carga en r4 el contenido que se encuentra en la dirección de r3. Como es un byte,
@ y se está utilizando litte-endian, el contenido de r4 = 0xCE.
@ Si el modo es big-endian, r4 = 0xBE.