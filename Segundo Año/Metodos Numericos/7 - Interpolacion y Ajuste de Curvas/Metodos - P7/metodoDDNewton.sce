function dif = DD(x,y)
    
    nX = length(x);
    nY = length(y);
    
    if(nX <> nY) then
        error("Los tamaños de x e y deben ser iguales.");
    end
    
    dif = y;
    for k = 2:nX
        for i = nX:-1:k
            dif(i) = (dif(i)-dif(i-1))/(x(i)-x(i-k+1));
        end
    end
    
endfunction

function px = DD_Newton(x,y)
    
    nX = length(x);
    nY = length(y);
    
    if(nX <> nY) then
        error("Los tamaños de x e y deben ser iguales.");
    end
    
    coef = DD(x, y);
    px = coef(nX); 
    r = poly(0, "x");

    for i = nX-1:-1:1
        px = coef(i) + (r - x(i)) * px;
    end
    
endfunction

// Se puede juntar todo en una funcion

function px = DD_NewtonAmp(x,y)
    
    nX = length(x);
    nY = length(y);
    
    if(nX <> nY) then
        error("Los tamaños de x e y deben ser iguales.");
    end
    
    dif = y;
    for k = 2:nX
        for i = nX:-1:k
            dif(i) = (dif(i)-dif(i-1))/(x(i)-x(i-k+1));
        end
    end
    
    px = dif(nX); 

    r = poly(0, "x");
    for i = nX-1:(-1):1
        px = dif(i) + (r - x(i)) * px;
    end
    
endfunction
