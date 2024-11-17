function p = Lk(x,k)
    
    nX = length(x); // tamaño del vector de nodos x
    p = 1; // neutro del producto (polinomio constante 1)
    xk = x(k); // nodo k
    xx = poly(0,"x"); // x
    
    for i = 1:nX
        
        if (i<>k) then
            p = p * (xx - x(i))/(xk-x(i)); // Lk
        end
        
    end
    
endfunction

function px = interpolacionLagrange(x,y)
    
    nX = length(x); 
    nY = length(y);
    
    if(nX <> nY) then
        error("Los tamaños de x e y deben ser iguales.");
    end
    
    px = 0;
    
    for i=1:nX
        
        px = px + Lk(x,i)*y(i); // sumatoria polinomio
        
    end
    
endfunction
