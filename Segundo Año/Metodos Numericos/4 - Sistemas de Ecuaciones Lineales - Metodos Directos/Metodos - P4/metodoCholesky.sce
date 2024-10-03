function R = cholesky(A)
    
    [nA, mA] = size(A);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    eps = 1.0e-8;
    
    R = zeros(nA, nA);
    
    for k = 1:nA
        
        t = A(k, k) - R(1:k-1, k)' * R(1:k-1, k);
        
        if (t <= eps) then
            printf("Matriz no definida positiva");
            abort;
        end
        
        R(k, k) = sqrt(t);
        
        for j = k + 1:nA
            R(k, j) = (A(k, j) - R(1:k-1, k)' * R(1:k-1, j)) / R(k, k);
        end
        
    end
    
endfunction


A = [16 -12 8 -16 ; -12 18 -6 9 ; 8 -6 5 -10 ; -16 9 -10 46];
B = [4 1 1 ; 8 2 2 ; 1 2 3];
C = [1 2 ; 2 4]


R1 = cholesky(A);
printf("Matriz A factorizada: \n");
disp(R1);
R2 = cholesky(B);
printf("\nMatriz A factorizada: \n");
disp(R2);

R3 = cholesky(C);
printf("\nMatriz A factorizada: \n");
disp(R3);

