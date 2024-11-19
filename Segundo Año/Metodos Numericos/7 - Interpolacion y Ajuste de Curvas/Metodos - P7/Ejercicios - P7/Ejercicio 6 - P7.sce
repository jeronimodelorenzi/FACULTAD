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

La formula del error esta dada,en este ejemplo, por:

|f(x)-Pn(x)| = |[(x-x_1)*(x-x_2)*(x-x_3)*(x-x_4)]|/24 * |f^4(c)|
Reemplazando tenemos:
|[(x+1)*(x-1)*(x-2)*(x-4)]|/24 * |f^4(c)| <= |[(0+1)*(0-1)*(0-2)*(0-4)]|/24 * 33.6
= |-8|/24 * 33.6 = 33.6 / 3 = 11.2

Por lo tanto tenemos que |Err(0)| <= 11.2. Es decir, encontramos una cota
superior para el valor absoluto del error de estimacion de f(0) y es 11.2
*/
