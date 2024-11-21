exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoDDNewton.sce', -1)

x = [2.0 2.1 2.2 2.3 2.4 2.5];
y = [0.2239 0.1666 0.1104 0.0555 0.0025 -0.0484];

px = DD_Newton(x,y);

px_eval1 = horner(px,2.15);
px_eval2 = horner(px,2.35);

printf("Polinomio interpolante diferencias divididas Newton:");
disp(px);
printf("\nJ0(2.15) = %lf \nJ0(2.35) = %lf\n",px_eval1,px_eval2);
