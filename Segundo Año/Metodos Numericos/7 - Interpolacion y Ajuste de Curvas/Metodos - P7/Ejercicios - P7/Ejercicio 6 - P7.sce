exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoInterpolacionLagrange.sce', -1)
exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoDDNewton.sce', -1)

/* 
Diferencias divididas:
f[-1]=2 ; f[-1,1] = 1 ; f[-1,1,2] = -2 ; f[-1,1,2,4] = 2

Sean los nodos x = [-1,1,2,4]
El polinomio interpolante esta definido como:
Pn(x) = f[-1] + (x+1)*f[-1,1] + (x+1)*(x-1)*f[-1,1,2] + (x+1)*(x-1)*(x-2)*f[-1,1,2,4]
Pn(x) = 2 + (x+1) - 2*(x+1)*(x-1)+ 2*(x+1)*(x-1)*(x-2)
Pn(x) = 9-x-6x^2+2x^3

Queremos estimar f(0), para eso usamos el polimio interpolante recien obtenido
Pn(0) = 9-0-6*0^2+2*0^3 = 9

*/
