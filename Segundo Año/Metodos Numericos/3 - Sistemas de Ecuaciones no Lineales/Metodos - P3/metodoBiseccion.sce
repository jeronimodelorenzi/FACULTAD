function c = biseccion(f,a,b,tol,iter)
    
    if (a >= b) then 
        
        c = %nan;
        printf("Intervalo incorrecto");
        return;
        
    end
    
    if (f(a)*f(b) > 0) then 
        
        c = %nan;
        printf("No es posible aplicar bisección.");
        return;
        
    elseif (f(a)*f(b) == 0) then
        
        if(f(a) == 0) then c = a; else c = b; end
        
    else
        
        c = (a+b)/2;
        i = 0;
        
        while (b-c>tol) && (i<iter)
            
            i = i+1;
            
            if (f(c) == 0) then
                
                return;
                
            elseif (f(b)*f(c)< 0) then
                
                a = c;
                
            else b = c;
            end
            
            c = (a+b)/2;
            
        end
        
        if b-c > tol then
            printf("Se alcanzó la cantidad máxima de iteraciones.\n");
        end
        
        printf("Iteraciones: %d\n", i);
       
        
    end
    
endfunction
