function I = metodoSimpsonCompuesto(fun,a,b,n)
    
    if (a>b) then
        temp = a;
        a = b;
        b = temp;
    end
    
    if (n<=0) then
        error("n no puede ser menor o igual a 0");
    elseif (modulo(n,2) <> 0) then
        error("n debe ser par");
    end
    
    h = (b-a)/n;
    I = fun(a)+fun(b);
    for i = 1:2:n-1
        xi = a+i*h;
        I = I + 4*fun(xi);
    end
    
    for i = 2:2:n-2
        xi = a+i*h;
        I = I + 2*fun(xi);
    end
    
    I = I*(h/3);

endfunction

/*
Queremos encontrar el numero de subintervalos necesarios para que el error de aproximacion no sea mayor a 10^-4.
Para esto, planteamos la formula del error del metodo de Simpson compuesto.
Sea |Error| = h^4(b-a)/180 * |f^4(c)| con h = (3-1)/n = 2/n y |f^4(c)| < 30. Entonces
|Error| = ((2/n)^4*2)/180 * |f^4(c)| = (16/n^4)*2/180 * |f^4(c)| = (32/n^4)/180 * |f^4(c)| = 32/(180*n^4) * |f^4(c)| = 8/(45*n^4) * |f^4(c)| < 8/(45*n^4) * 30
= 240/(45*n^4) = 16/(3*n^4)
Luego, 16/(3*n^4) < 10^-4 sii (3*n^4)/16 > 10^4 sii (3*n^4) > 10^4 * 16 sii n^4 > 160000/3 sii n > 53333.333^(1/4) sii n > 15.196714
Por lo tanto, para que el error no sea mayor a 10^4, en el metodo de Simpson necesitamos 16 subintervalos, ya que en este metodo los subintervalos deben ser pares.
*/

function y = f(x)
    y = exp(x)*sin(x);
endfunction

I_simpson = metodoSimpsonCompuesto(f,1,3,16);
I_real = intg(1,3,f);
error_simpson = abs(I_real-I_simpson);

printf("Valor de la integral con el metodo del Simpson: %lf\n",I_simpson);
printf("Valor real = %lf\n",I_real);
printf("Error = %lf\n",error_simpson);

