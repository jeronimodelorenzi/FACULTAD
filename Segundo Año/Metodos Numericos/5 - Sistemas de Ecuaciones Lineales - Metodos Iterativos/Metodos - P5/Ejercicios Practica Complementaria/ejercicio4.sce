function A = crearMatriz(c)
    
    n = 5;
    
    A(n,n) = 1 + 2*c;
    
    for i = 1:n-1
        
        A(i,i) = 1 + 2*c;
        A(i,i+1) = -c;
        A(i+1,i) = -c
        
    end
    
endfunction

function [L,U] = factorizacionLU(A)
    
    [nA,mA] = size(A); // tamaño de A
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada.");
    end
    
    U = A;
    L = eye(nA,mA);
    //P = eye(nA,mA);
    
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
        
        for i = k+1:nA // fila
           
           mik = U(i,k)/U(k,k);
           L(i,k) = mik;
           U(i,k:nA) = U(i,k:nA) - L(i,k)*U(k,k:nA)
            
        end
        
    end
    
endfunction

function x = triangularSuperior(A,b)
    
    [nA,mA] = size(A);

    x(nA) = b(nA)/A(nA,nA);
    
    for i=nA-1:-1:1
        x(i)= (b(i) - A(i,i+1:nA)*x(i+1:nA))/A(i,i); // A(i,i+1:n) fila i columna i+1 a n
    end
    
endfunction

function x = triangularInferior(A,b)

    [nA,mA] = size(A);

    x(1) = b(1)/A(1,1);
    
    for i=2:nA
        x(i) = (b(i) - A(i,1:i-1)*x(1:i-1))/A(i,i);
    end
    
endfunction

function resolver_sistema(L,U,x0)
    
    for i=1:4
        
        b = x0;
        
        y = triangularInferior(L,b);
        x0 = triangularSuperior(U,y);
        printf("x^(%d):",i);
        disp(x0);

    end
    
endfunction

A = crearMatriz(1);

[L,U] = factorizacionLU(A);

x0 = [10;12;12;12;10];

resolver_sistema(L,U,x0);
