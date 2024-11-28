// Función

function I = metodoTrapecioCompuesto(fun,a,b,n)
    
    if (a>b) then
        temp = a;
        a = b;
        b = temp;
    end
    
    if (n<=0) then
        error("n no puede ser menor o igual a 0");
    end

    h = (b-a)/n;
    I = (fun(a)+fun(b))/2;
    
    for i = 1:n-1
        xi = a + i*h;
        I = I + fun(xi);        
    end
    
    I = I*h;
    
endfunction

//Ejercicio 2.b

/*
Sabiendo que el número de subintervalos debe ser n = 23.
Definimos la función.
*/

function y = f(x)
    y = exp(-x)*cos(x);
endfunction

a = 0;
b = 2;
n = 23;

I_trapecio = metodoTrapecioCompuesto(f,a,b,n);

printf("El valor de la integral con 23 subintervalos es: %lf\n\n",I_trapecio);

/*
El valor de la integral con 23 subintervalos es: 0.590278
*/

/*Si comprobamos:*/
I_real = intg(0,2,f);
error_trapecio = abs(I_real - I_trapecio);
verificacion = error_trapecio < 10^-3;

printf("Valor real de la integral: %lf\n", I_real);
printf("Error entre el valor real y la aproximación con el metodo del trapecio: %lf\n", error_trapecio);
printf("Si verificamos: %lf < %lf ?", error_trapecio, 10^-3);
disp(verificacion);

/*
Valor real de la integral: 0.589690
Error entre el valor real y la aproximación con el mét0do del trapecio: 0.000588
Si verificamos: 0.000588 < 0.001000 ?
  T
*/
