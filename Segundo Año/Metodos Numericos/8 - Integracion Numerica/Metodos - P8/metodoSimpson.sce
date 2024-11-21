function I = metodoSimpson(fun,a,b) 
    
    if (a>b) then
        temp = a;
        a = b
        b = temp;
    end
    
    //deff("y=f(x)","y="+fun);
    
    h = (b-a)/2;
    x1 = a+h;
    I = h/3*(fun(a)+4*fun(x1)+fun(b));
    
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
