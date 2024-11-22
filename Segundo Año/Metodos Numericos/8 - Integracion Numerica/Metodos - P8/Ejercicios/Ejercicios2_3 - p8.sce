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

function y = f1(x)
    y = 1/x;
endfunction

function y = f2(x)
    y = x^3;
endfunction

function y = f3(x)
    y = x*(1+x^2)^(1/2);
endfunction

function y = f4(x)
    y = sin(%pi*x);
endfunction

function y = f5(x)
    y = x*sin(x);
endfunction

function y = f6(x)
    y = x^2*exp(x);
endfunction

I1_trapecio = metodoTrapecioCompuesto(f1,1,3,4);
I2_trapecio = metodoTrapecioCompuesto(f2,0,2,4);
I3_trapecio = metodoTrapecioCompuesto(f3,0,3,6);
I4_trapecio = metodoTrapecioCompuesto(f4,0,1,8);
I5_trapecio = metodoTrapecioCompuesto(f5,0,2*%pi,8);
I6_trapecio = metodoTrapecioCompuesto(f6,0,1,8);

I1_simpson = metodoSimpsonCompuesto(f1,1,3,4);
I2_simpson = metodoSimpsonCompuesto(f2,0,2,4);
I3_simpson = metodoSimpsonCompuesto(f3,0,3,6);
I4_simpson = metodoSimpsonCompuesto(f4,0,1,8);
I5_simpson = metodoSimpsonCompuesto(f5,0,2*%pi,8);
I6_simpson = metodoSimpsonCompuesto(f6,0,1,8);

I1_real = intg(1,3,f1);
I2_real = intg(0,2,f2);
I3_real = intg(0,3,f3);
I4_real = intg(0,1,f4);
I5_real = intg(0,2*%pi,f5);
I6_real = intg(0,1,f6);

printf("Metodo trapecio:\n");
printf("I1 = %lf\n",I1_trapecio);
printf("I2 = %lf\n",I2_trapecio);
printf("I3 = %lf\n",I3_trapecio);
printf("I4 = %lf\n",I4_trapecio);
printf("I5 = %lf\n",I5_trapecio);
printf("I6 = %lf\n",I6_trapecio);

printf("Metodo Simpson:\n");
printf("I1 = %lf\n",I1_simpson);
printf("I2 = %lf\n",I2_simpson);
printf("I3 = %lf\n",I3_simpson);
printf("I4 = %lf\n",I4_simpson);
printf("I5 = %lf\n",I5_simpson);
printf("I6 = %lf\n",I6_simpson);

printf("Valor real:\n");

printf("I1 = %lf\n",I1_real);
printf("I2 = %lf\n",I2_real);
printf("I3 = %lf\n",I3_real);
printf("I4 = %lf\n",I4_real);
printf("I5 = %lf\n",I5_real);
printf("I6 = %lf\n",I6_real);
