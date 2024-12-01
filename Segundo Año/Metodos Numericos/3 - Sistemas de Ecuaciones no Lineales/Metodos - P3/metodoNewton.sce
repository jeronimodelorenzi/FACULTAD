function n = newton(f,x0,tol,iter,h)
    
    dfx0 = f(x0+h) - f(x0);
    
    x1 = x0 - f(x0)*h/dfx0;
    
    i = 0;
    
    delta = abs(x1-x0);
    
    while(delta > tol) && (i < iter)
        
        i = i + 1;
        
        x0 = x1;
        
        dfx0 = f(x0+h) - f(x0);
        
        x1 = x0 - f(x0)*h/dfx0;
        
        delta = abs(x1-x0);
       
    end
    
    if(delta > tol)
       printf("Se alcanzo el maximo de iteraciones"); 
    end
    
    printf("Iteraciones %d", i);
    
    n = x1;
    
endfunction

function n = newton_2(f,df,x0,tol,iter) 
    
    x1 = x0 - f(x0)/df(x0);
    
    i = 0;
    
    delta = abs(x1-x0);
    
    while(delta > tol) && (i < iter)
        
        i = i + 1;
        
        x0 = x1;
        
        x1 = x0 - f(x0)/df(x0);
        
        delta = abs(x1-x0);
       
    end
    
    if(delta > tol)
       printf("Se alcanzó la cantidad máxima de iteraciones.\n"); 
    end
    
    printf("Iteraciones %d", i);
    
    n = x1;
    
endfunction

