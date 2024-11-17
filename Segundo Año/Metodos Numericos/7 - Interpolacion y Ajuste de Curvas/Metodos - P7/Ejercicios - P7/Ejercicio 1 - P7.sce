exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoInterpolacionLagrange.sce', -1)
exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoDDNewton.sce', -1)

x = [0,0.2,0.4,0.6];
y = [1,1.2214,1.4918,1.8221];

/* Lineal */
LagrangeLineal = interpolacionLagrange([0.2,0.4],[1.2214,1.4918]);
NewtonLineal = DD_Newton([0.2,0.4],[1.2214,1.4918]);

printf("Polinomios:\n");
printf("Polinomio lineal interpolacion Lagrange:");
disp(LagrangeLineal);
printf("Polinomio lineal interpolacion Newton:");
disp(NewtonLineal);

valorLagrangeLineal = horner(LagrangeLineal,1/3);
valorNewtonLineal = horner(NewtonLineal, 1/3);

printf("\nPolinomios evaluados:\n")
printf("Valor aproximado de e^1/3 por interpolacion de Lagrange lineal: %lf\n",valorLagrangeLineal);
printf("Valor aproximado de e^1/3 por interpolacion de Newton lineal: %lf\n",valorNewtonLineal);

/* Cubico */

LagrangeCubico = interpolacionLagrange(x,y);
NewtonCubico = DD_Newton(x,y);

printf("\nPolinomios:\n");
printf("Polinomio cubico interpolacion Lagrange:");
disp(LagrangeCubico);
printf("Polinomio cubico interpolacion Newton:");
disp(NewtonCubico);

valorLagrangeCubico = horner(LagrangeCubico,1/3);
valorNewtonCubico = horner(NewtonCubico, 1/3);

printf("Polinomios evaluados:\n")
printf("Valor aproximado de e^1/3 por interpolacion de Lagrange cubico: %lf\n",valorLagrangeCubico);
printf("Valor aproximado de e^1/3 por interpolacion de Newton cubico: %lf\n",valorNewtonCubico);

rango = [-2:0.01:2];

// Grafico Lagrange

subplot(121);
plot(rango,horner(LagrangeLineal,rango),"r");
plot(rango,horner(LagrangeCubico,rango),"g");
plot(rango,exp(rango),"b");
a=gca();
a.x_location = "origin";
a.y_location = "origin";
h1 = legend("Lineal", "Cubico","e^x");

// Grafico Newton

subplot(122);
plot(rango,horner(NewtonLineal,rango),"r");
plot(rango,horner(NewtonCubico,rango),"g");
plot(rango,exp(rango),"b");
a=gca();
a.x_location = "origin";
a.y_location = "origin";
h1 = legend("Lineal", "Cubico","e^x");

// Errores

cotaErrorLineal = (abs((1/3-0.2)*(1/3-0.4)))/2*exp(0.4);
cotaErrorCubico = (abs((1/3-0)*(1/3-0.2)*(1/3-0.4)*(1/3-0.6)))/24*exp(0.6);

//

printf("\nCota de errores:\n")
printf("Cota error lineal: %lf\n", cotaErrorLineal);
printf("Cota error cubico: %lf\n", cotaErrorCubico);

//-----
errorLinealLagrange = abs(1.395612425-valorLagrangeLineal);
errorCubicoLagrange = abs(1.395612425-valorLagrangeCubico);

printf("\nErrores Lagrange:\n");
printf("Error Lagrange lineal: %lf\n",errorLinealLagrange);
printf("Error Lagrange cubico: %lf\n",errorCubicoLagrange);

errorLinealNewton = abs(1.395612425-valorNewtonLineal);
errorCubicoNewton = abs(1.395612425-valorNewtonCubico);

printf("\nErrores Newton:\n");
printf("Error Newton lineal: %lf\n",errorLinealNewton);
printf("Error Newton cubico: %lf\n",errorCubicoNewton);
