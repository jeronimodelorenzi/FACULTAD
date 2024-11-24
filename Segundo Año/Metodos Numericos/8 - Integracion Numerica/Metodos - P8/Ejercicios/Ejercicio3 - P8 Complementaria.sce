
function I = metodoTrapecioEjercicio(b,n)
    
    if (b <= 1) then
        error("No cumple con lo pedido en el ejercicio");
    end
    
    if (n <= 0) then
        error("No cumple con lo pedido en el ejercicio");
    end
    
    
    h = (b-1)/n;
    I = ((sin(1)/1)+(sin(b)/b))/2;
    
    for i = 1:n-1
        xi = 1 + i*h;   
        I = I + (sin(xi)/xi);        
    end
    
    I = I*h;
    
endfunction

I2 = metodoTrapecioEjercicio(2,100);
I5 = metodoTrapecioEjercicio(5,100);
I10 = metodoTrapecioEjercicio(10,100);


printf("Aproximaciones de la integral tomando n = 100\n");
printf("Con b = 2, I = %lf\n",I2);
printf("Con b = 5, I = %lf\n",I5);
printf("Con b = 10, I = %lf\n",I10);

/*
Sabemos que el error del metodo de trapecio compuesto esta dado por |Error| = h^2(b-a)/12 *|f''(c)| donde h = (b-1)/100 y |f''(c)| <=1. Entonces
|Error| = (((b-1)/100)^2 * (b-1))/12 * |f''(c)| = ((b-1)^3/10000)/12 * |f''(c)| = (b-1)^3/120000 * |f''(c)| < (b-1)^3/120000 * 1 = (b-1)^3/120000
• Si b = 2, |Error| < 0.0000083.
• Si b = 5, |Error| < 0.0005333.
• Si b = 10, |Error| < 0.0042667.
*/

// Comprobemos

function y = Si(b)
    y = sin(b)/b;
endfunction

I2_real = intg(1,2,Si);
I5_real = intg(1,5,Si);
I10_real = intg(1,10,Si);

error2 = abs(I2_real - I2);
error5 = abs(I5_real - I5);
error10 = abs(I10_real - I10);

printf("Valores reales:\n");
printf("Con b = 2, I = %lf\n",I2_real);
printf("Con b = 5, I = %lf\n",I5_real);
printf("Con b = 10, I = %lf\n",I10_real);

printf("Errores:\n");
printf("Con b = 2, Error = %lf\n",error2);
printf("Con b = 5, Error = %lf\n",error5);
printf("Con b = 10, Error = %lf\n",error10);

verificacion2 = error2 < 0.0000083;
verificacion5 = error5 < 0.0005333;
verificacion10 = error10 < 0.0042667;

printf("Verificando:\n");
printf("%lf < 0.0000083:",error2);
disp(verificacion2);
printf("%lf < 0.0005333:",error5);
disp(verificacion5);
printf("%lf < 0.0042667:",error10);
disp(verificacion10);
