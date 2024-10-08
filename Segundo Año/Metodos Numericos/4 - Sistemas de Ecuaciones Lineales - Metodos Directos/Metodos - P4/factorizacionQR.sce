function [Q,R] = factorizacionQR(A)
    
    [m,n] = size(A);
    

    if rank(A) <> n  then
        error("factorizacionQR - El rango de la matriz no es n");
    end

    Q = zeros(m,n);
    R = zeros(n,n);
    
    for k = 1 : n // Iteramos por las columnas de la matriz
        
        vectorProyectado = A(1:m, k);
        
        for i = 1 : k - 1 
            
            R(i,k) = A(1:m, k)' * Q(1:m, i);
            
            vectorProyectado = vectorProyectado - R(i,k) * Q(1:m, i);
        end
        
        Q(1:m, k) = vectorProyectado / norm(vectorProyectado);

        R(k,k) = norm(vectorProyectado);

        
    end
    
endfunction

A = [16 -12 8 ; -12 18 -6 ; 8 -6 8];
b = [76;-66;46];

[Q,R] = factorizacionQR(A);
printf("Matriz A factorizada:\n");
disp(Q);
disp(R);

y = Q' * b;
x = triangularSuperior(R,y);

printf("\nSolucion del sistema:");
disp(x);
