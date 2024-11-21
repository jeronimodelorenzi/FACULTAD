exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\polinomioChebyshev.sce', -1)
exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoDDNewton.sce', -1)

// Obtenemos las raices del polinomio de chebyshev en el intervalo [0,pi]

nodos = rootsChebyshev_ab(4,0,%pi/2);

// Obtenemos el vector y evaluando los nodos en cos

y = cos(nodos);

// Polinomio interpolante con diferencias divididas Newton

px = DD_Newton(nodos,y)

//-----
rango = 0:0.001:%pi/2

cos_rango = cos(rango');
px_rango = horner(px,rango');
err = cos_rango - px_rango;

printf("Nodos | Raices del polinomio Chebyshev T4:");
disp(nodos);
printf("Polinomio interpolante diferencias divididas Newton:");
disp(px);

// Ploteo

subplot(121)
plot2d(rango', [cos_rango px_rango], [2, 3, 4], leg="cos(x)@P3(x)");
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Interpolación de cos^x usando nodos de Chebyshev");

subplot(122)
plot2d(rango', err, 2 , leg="cos(x) - P3(x)");
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Error cos^x-P3(x) en [0,pi/2]");
