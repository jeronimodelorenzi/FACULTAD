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

function y = f(x)
    y = 1/x;
endfunction

I_real = log(2);
I_trapecio = metodoTrapecioCompuesto(f,1,2,4);
error_trapecio = abs(I_real - I_trapecio);

printf("Valor de la integral con el metodo del trapecio: %lf\n",I_trapecio);
printf("Valor real = %lf\n",I_real);
printf("Error = %lf\n",error_trapecio)

/*
Sea la formula del error del trapecio |Err| = (h^2*(b-a))/12 *|f''(c)| donde h = (2-1)/n  = 1/n y f''(x) = 2/x^3
con lo cual |Err| = (1/n)^2/12*2/|c^3| <= 1/(n^2*6)*1/1 = 1/(n^2*6)
Luego 1/(n^2*6) < 10^-6 sii 6*n^2 > 10^6 sii n^2 > 166666.67 sii n > sqrt(166666.67) sii n > 408.24829
*/
