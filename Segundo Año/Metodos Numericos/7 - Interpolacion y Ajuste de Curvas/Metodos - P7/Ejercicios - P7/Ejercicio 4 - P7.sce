exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoInterpolacionLagrange.sce', -1)
exec('D:\Importante\FACULTAD\Segundo Año\Metodos Numericos\7 - Interpolacion y Ajuste de Curvas\Metodos - P7\metodoDDNewton.sce', -1)

x = [2.0,2.1,2.2,2.3,2.4,2.5];
J0 = [0.2239,0.1666,0.1104,0.0555,0.0025,-0.0484];

Newton = DD_Newton(x,J0);
disp(Newton);
NewtonEval = horner(Newton,2.15);
disp(NewtonEval)
