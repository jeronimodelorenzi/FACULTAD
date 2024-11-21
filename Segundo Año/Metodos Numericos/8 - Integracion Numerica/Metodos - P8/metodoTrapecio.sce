function I = metodoTrapecio(fun,a,b) 
    
    if (a>b) then
        temp = a;
        a = b
        b = temp;
    end
 
    h = b-a;
    I = h/2*(f(a)+f(b));
    
endfunction

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
