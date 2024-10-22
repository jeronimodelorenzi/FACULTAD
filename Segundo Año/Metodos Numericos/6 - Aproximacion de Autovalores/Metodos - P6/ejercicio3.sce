function [px, raices] = poly_carac(A)
    
    [nA, mA] = size(A);
    
    if (nA <> mA) then
       printf("Error - La matriz A debe ser cuadrada.");
       abort; 
    end
    
    x = poly(0,'x');
    
    px = det(A - x*eye(nA,nA));
    //px = det(x*eye(nA,nA) - A);
    
    raices = roots(px);
    
    
endfunction

function ejercicio3()
    
    for k=0:10
        
        e = 0.1*k;
        Ae = [1 -1 0 ; -2 4 -2 ; 0 -1 1+e];
        autovalores = spec(Ae);
        [px,raices] = poly_carac(Ae);
        
        
        printf("Autovalores con k=%d:\n",k);
        disp(autovalores);
        
        printf("Polinomio caracteristico con k=%d:\n",k);
        disp(px);
        
        printf("Raices del polinomio caracteristico con k=%d:\n",k);
        disp(raices);
        
        printf("//---------------//\n");
        
    end
    
endfunction

ejercicio3
