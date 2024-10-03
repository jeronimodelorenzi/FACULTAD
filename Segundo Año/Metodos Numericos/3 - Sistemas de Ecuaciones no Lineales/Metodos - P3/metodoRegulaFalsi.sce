function r = regulaFalsi(f,a,b,tol,iter)
    
    deff("y=f(x)","y="+f);
    
    if (a>=b) then
        
        r=%nan;
        printf("Intervalo incorrecto");
        return;
        
    end
    
    if (f(a)*f(b) > 0) then
        
        r=%nan;
        printf("No se puede aplicar el metodo.\n");
        return
        
    elseif (f(a)*f(b)==0) then
        
        if(f(a) == 0) then r = a; else r = b; end
    
    end
       
    c1 = b - f(b)*(b-a)/(f(b)-f(a));
    delta = abs(c1-b);
    i = 0;
       
    while (delta>tol) && (i < iter)
        i = i + 1;
        
        if (f(c1) == 0) then
            r = c1
            return;
        elseif (f(b)*f(c1)<0) then
            a=c1;
        else
            b=c1;
        end
        
        c1 = b - f(b)*(b-a)/(f(b)-f(a));
        delta = abs(c1-b);
        
    end
        

    if delta > tol then
        printf("Se alcanzó la cantidad máxima de iteraciones.\n");
    end
    
    printf("Iteraciones: %d\n", i);
    
    r=c1;
    
endfunction
