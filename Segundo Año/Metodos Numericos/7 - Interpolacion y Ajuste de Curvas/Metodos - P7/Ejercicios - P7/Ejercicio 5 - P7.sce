exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoInterpolacionLagrange.sce', -1)
exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoDDNewton.sce', -1)

/* 
Datos
x = [0,1,2,3];
y = [1,3,3,k];

Sabemos que el polinomio de interpolacion esta dado por:
P_123(x) = L1(x)*3+L2(x)*3+L3(x)*k , si lo evaluamos tenemos:
P_123(2.5) = L1(2.5)*3+L2(2.5)*3+L3(2.5)*k = 3.
Despejamos,
k = (3 - L1(2.5)*3 - L2(2.5)*3)/L3(2.5)
*/

x = [1,2,3];

L1 = Lk(x,1);
L2 = Lk(x,2);
L3 = Lk(x,3);

C1 = horner(L1,2.5)*3;
C2 = horner(L2,2.5)*3;
C3 = horner(L3,2.5);

k = (3-C1-C2)/C3;

xx = [0,1,2,3];
yy = [1,3,3,k];

P_0123= interpolacionLagrange(xx,yy);
printf("Polinomio interpolacion Lagrange: ");
disp(P_0123);

valor = horner(P_0123,2.5);
printf("Valor de P_0123:% lf\n",valor);



