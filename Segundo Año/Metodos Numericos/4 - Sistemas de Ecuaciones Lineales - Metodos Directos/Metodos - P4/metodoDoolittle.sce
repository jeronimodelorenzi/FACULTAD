function [L,U] = doolittle(A)

    [nA,mA] = size(A); // tamaño de A
    
    if (nA<>mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    L = eye(nA,nA); 
    U = zeros(nA,nA); 
    
    for j=1:nA
        // Calculo de la matriz U
        for i=1:j
            
            U(i,j) = A(i,j); 
            
            for k=1:i-1
                U(i,j) = U(i,j) - L(i,k) * U(k,j); 
            end
            
        end
        
        // Calculo de la matriz L
        for i=j+1:nA
            
            L(i,j) = A(i,j);
            
            for k=1:j-1
                L(i,j) = L(i,j) - L(i,k) * U(k,j); 
            end
            
            L(i,j) = L(i,j) / U(j,j);

        end
    end

endfunction

/*
A = [1 2 3 4 ; 1 4 9 16 ;1 8 27 64 ;1 16 81 256];
b = [2;10;44;190];

[L,U] = doolittle(A);

y = triangularInferior(L,b);
x = triangularSuperior(U,y);

printf("Solucion\n:");
disp(x);
/*
