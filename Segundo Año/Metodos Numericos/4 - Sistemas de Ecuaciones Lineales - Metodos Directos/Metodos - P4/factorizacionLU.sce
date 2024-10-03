function [P,L,U] = factorizacionLU(A)
    
    [nA,mA] = size(A); // tamaño de A
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada.");
    end
    
    U = A;
    L = eye(nA,mA);
    P = eye(nA,mA);
    
    for k = 1:nA-1 // columna
        
        k_pivot = k; // posicion del pivote maximo
        max_pivot = abs(U(k,k)); // valor del pivote maximo
        
        for i = k+1:nA // fila
            if (abs(U(i,k)) > max_pivot) then
                k_pivot = i;
                max_pivot = abs(U(i,k));
            end
        end
        
        // intercambio filas U
        temp = U(k_pivot,:);
        U(k_pivot,:) = U(k,:);
        U(k,:) = temp;
        
        // intercambio filas L
        temp = L(k_pivot,1:k-1);
        L(k_pivot,1:k-1) = L(k,1:k-1);
        L(k,1:k-1) = temp;
        
        // intercambio filas P
        temp = P(k_pivot,:);
        P(k_pivot,:) = P(k,:);
        P(k,:) = temp;
        
        for i = k+1:nA // fila
           
           mik = U(i,k)/U(k,k);
           L(i,k) = mik;
           U(i,k:nA) = U(i,k:nA) - L(i,k)*U(k,k:nA)
            
        end
        
    end
    
endfunction

/*
A = [2 1 1 0 ; 4 3 3 1 ; 8 7 9 5 ; 6 7 9 8];
[P,L,U] = factorizacionLU(A);

printf("Matriz A:\n");
disp(A);

printf("\nMatriz P\n");
disp(P);

printf("\nMatriz L\n");
disp(L);

printf("\nMatriz U\n");
disp(U);
*/
