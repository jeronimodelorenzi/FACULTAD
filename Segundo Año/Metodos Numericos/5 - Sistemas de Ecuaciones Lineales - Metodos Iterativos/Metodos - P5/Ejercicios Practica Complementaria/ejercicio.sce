function A = crearMatriz(a)
    
    n = size(a,1);
    I = eye(n,n);
    
    A = [1 a' ; a I];
    
endfunction

function U = fC(A)
    
    n = size(A,1);
    I = eye(n-1,n-1);
    a = A(2:n,1);
    
    M = I - a*a';
    R = chol(M);
    
    U = [1 a' ; zeros(1,n-1)' R];
    
endfunction

a = [0.2 ; 0.1 ; 0.3 ; 0.4 ; 0.1];
A = crearMatriz(a);
disp(A);
U = fC(A);
disp(U);
disp(U'*U)
