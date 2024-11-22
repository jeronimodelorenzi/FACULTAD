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

function y = f(x)
    y = (x+1)^(-1);
endfunction

I_trapecio = metodoTrapecioCompuesto(f,0,1.5,10);
I_simpson = metodoSimpsonCompuesto(f,0,1.5,10);
I_exacto = 0.9262907;

error_trapecio = I_exacto - I_trapecio;
error_simpson = I_exacto - I_simpson;

printf("I_trapecio = %lf\n",I_trapecio);
printf("I_simpson = %lf\n",I_simpson);
printf("Valor real = %lf\n",I_exacto);
printf("Error trapecio = %lf\n",error_trapecio);
printf("Error Simpson = %lf\n",error_simpson);

