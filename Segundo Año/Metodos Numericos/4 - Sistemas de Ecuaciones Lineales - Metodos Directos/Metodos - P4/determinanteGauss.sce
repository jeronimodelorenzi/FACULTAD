function [A_triang, determ] = determinanteGauss(A)
    
    [nA,mA] = size(A); // tamaño de A
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    A_triang = A;
    determ = 1;
    
    for k=1:nA
        
        if(A_triang(k,k) == 0) then
            determ = 0;
            return;
        end
        
        for i = k+1:nA
            
            mik = A_triang(i,k)/A_triang(k,k); // multiplicador
            A_triang(i,k) = 0;
            A_triang(i,k+1:nA) = A_triang(i,k+1:nA) - mik*A_triang(k,k+1:nA);
  
        end
    end
    
    //determ = prod(diag(A_triang))
    
    for k = 1:nA
        determ = determ * A_triang(k,k);
    end
    
endfunction

/*
A = [1 2 3 ; 3 -2 1 ; 4 2 -1];

printf("Matriz A:\n");
disp(A);

[a1, determinante] = determinanteGauss(A);

printf("\nDeterminante:\n");
disp(determinante);
*/
