exec('C:\Users\laRoc\Documents\FACULTAD-JERO\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoDDNewton.sce', -1)
exec('C:\Users\laRoc\Documents\FACULTAD-JERO\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoInterpolacionLagrange.sce', -1)

function nodos = nodosEquispaciados(n)
    nodos = -5:10/n:5
endfunction

function y = f(x)
    y = 1./(1.+x.^2);
endfunction

/*Nodos*/
nodos2 = nodosEquispaciados(2);
nodos4 = nodosEquispaciados(4);
nodos6 = nodosEquispaciados(6);
nodos10 = nodosEquispaciados(10);
nodos14 = nodosEquispaciados(14);

/*Imagenes*/
y1 = f(nodos2');
y2 = f(nodos4');
y3 = f(nodos6');
y4 = f(nodos10');
y5 = f(nodos14');

/*Polinomios Interpolantes*/
P2 = DD_Newton(nodos2,y1);
P4 = DD_Newton(nodos4,y2);
P6 = DD_Newton(nodos6,y3);
P10 = DD_Newton(nodos10,y4);
P14 = DD_Newton(nodos14,y5);

/*Pantalla*/
printf("Polinomios interpolantes:\n");
printf("P2:");
disp(P2);
printf("P4:");
disp(P4);
printf("P6:");
disp(P6);
printf("P10:");
disp(P10);
printf("P14:");
disp(P14);

rango = -5:0.01:5;

/*Plots*/
subplot(121);
plot2d(rango, [1./(1.+rango'.^2) horner(P2,rango') horner(P4,rango') horner(P6,rango') horner(P10,rango') horner(P14,rango')], [2,3,4,5,6,1], leg="y=1/(1+x^2)@Newton(n=2)@Newton(n=4)@Newton(n=6)@Newton(n=10)@Newton(n=14)");
a=gca()
a.x_location = "origin";
a.y_location = "origin";
title("y=1/(1+x^2) vs Newton");

/*Errores*/

function err = Error(f,Pn,xx)
    err = f(xx') - horner(Pn,xx');
endfunction

err1 = Error(f,P2,rango);
err2 = Error(f,P4,rango);
err3 = Error(f,P6,rango);
err4 = Error(f,P10,rango);
err5 = Error(f,P14,rango);

subplot(122);
plot2d(rango, [err1 err2 err3 err4 err5 ], [2,3,4,5,6], leg="n=2@n=4@n=6@n=10@n=14");
a=gca()
a.x_location = "origin";
a.y_location = "origin";
title("Gráfica de la función error para valores distintos de n");

