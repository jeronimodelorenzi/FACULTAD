exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\minimosCuadrados.sce', -1)

x = [0 0.15 0.31 0.5 0.6 0.75];
y = [1 1.004 1.31 1.117 1.223 1.422];

// grado = 1
[A1,px1,err1] = minimosCuadrados(x,y,1);

printf("Grado 1:\n")
printf("Matriz de minimos cuadrados:");
disp(A1);
printf("Polinomio minimos cuadrados:");
disp(px1);
printf("Error: %lf\n",err1);

// grado = 2
[A2,px2,err2] = minimosCuadrados(x,y,2);

printf("\nGrado 2:\n")
printf("Matriz de minimos cuadrados:");
disp(A2);
printf("Polinomio minimos cuadrados:");
disp(px2);
printf("Error: %lf\n",err2);

// grado = 3
[A3,px3,err3] = minimosCuadrados(x,y,3);

printf("\nGrado 3:\n")
printf("Matriz de minimos cuadrados:");
disp(A3);
printf("Polinomio minimos cuadrados:");
disp(px3);
printf("Error: %lf\n",err3);

// Ploteo
rango = 0:0.01:1
plot2d(x',y,-1);
plot2d(rango,[horner(px1,rango') horner(px2,rango') horner(px3,rango')], [2,3,4],leg=["px1(x)@px2(x)@px3(x)"]);
