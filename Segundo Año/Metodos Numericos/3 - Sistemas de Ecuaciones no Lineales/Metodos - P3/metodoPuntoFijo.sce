function p = puntoFijo(f,x0,tol,iter)
    
    x1 = f(x0);    
    i = 1;    
    delta = abs(x1-x0);
    
    while (delta > tol) && (i < iter)
        
        x0 = x1;
        x1 = f(x0);
        delta = abs(x1-x0);
        i = i+1;
        
    end
    
    if (delta > tol) then
        printf("Se alcanzó la cantidad máxima de iteraciones.\n");
    end
    
    printf("Iteraciones: %d\n",i);
    
    p = x1;
    
endfunction
