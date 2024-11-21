exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\polinomioChebyshev.sce', -1)
exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoDDNewton.sce', -1)

// Obtenemos los nodos como las raices del polinomio de Chebyshev T_4(x)

nodos = rootsChebyshev(4);

// Obtenemos el vector y evaluando e^x en los nodos

function y = f(x)
    y = exp(x);
endfunction

y = f(nodos);

// Ahora veamos el polinomio interpolante con el metodo de diferencias divididas de Newton

px = DD_Newton(nodos,y);

// Buscamos el error en [-1,1];

rango = -1:0.001:1

e_rango = f(rango');
px_rango = horner(px,rango');
err = e_rango - px_rango;

printf("Nodos | Raices del polinomio Chebyshev T4:");
disp(nodos);
printf("Polinomio interpolante diferencias divididas Newton:");
disp(px);

// Ploteo

subplot(121)
plot2d(rango', [e_rango px_rango], [2, 3, 4], leg="e^x@P3(x)");
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Interpolación de e^x usando nodos de Chebyshev");

subplot(122)
plot2d(rango', err, 2 , leg="e^x - P3(x)");
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Error e^x-P3(x) en [-1,1]");
