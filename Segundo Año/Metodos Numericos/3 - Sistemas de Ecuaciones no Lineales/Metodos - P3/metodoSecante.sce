function s = secante(f,x0,x1,tol,iter)
    
    deff("y=f(x)", "y="+f);
    
    x2 = x1 -f(x1)*(x1-x0)/(f(x1)-f(x0));
    
    delta = abs(x2 - x1);
    
    i = 0;
    
    while (delta>tol) && (i<iter)
        
        i = i + 1;
        
        x0 = x1;
        x1 = x2;
        x2 = x1 -f(x1)*(x1-x0)/(f(x1)-f(x0));
        
        delta = abs(x2 - x1);
        
    end
    
    if(delta > tol)
       printf("Se alcanzó la cantidad máxima de iteraciones.\n"); 
    end
    
    printf("Iteraciones %d\n", i);
    
    s = x2;
    
endfunction
