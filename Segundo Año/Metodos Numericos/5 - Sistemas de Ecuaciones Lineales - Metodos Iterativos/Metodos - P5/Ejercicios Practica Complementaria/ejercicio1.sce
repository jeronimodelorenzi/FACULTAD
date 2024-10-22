function [A,b] = crearMatriz(n,k)
    
    // Matriz A
    
    A(1,n) = 1;
    A(n,n) = k;
    A(n,1) = 1;
    
    for i = 1:n-1
        
        A(i,i) = k;
        A(i,i+1) = -1;
        A(i+1,i) = -1;
        
    end
    
    // Matriz b
    
    b(n,1) = 1
    
endfunction

function x = gaussSeidel_ejercicio(A,b,x0,iter,tol)
    
    n = size(A,1);
    x = x0;
    cont = 0;
    
    for k = 1:iter
        
        xk = x;
        
        x(1) = (1/2)*(xk(2)-xk(n));
        
        for i = 2:n-1  
            x(i) = (1/2)*(x(i-1)+xk(i+1));  
        end
        
        x(n) = (1/2)*(1-x(1)+x(n-1));
    
        if (norm(x -xk) < tol) then
            break;
        end
        
        cont = cont + 1
    
    end

    printf("Cantidad de iteraciones: %d\n",cont);
    
endfunction

function x = solucion_exacta(n)
    for i = 1:n
        x(i) = -n/4+i/2
    end
endfunction

function matriz_metodo(A)
    
    n = size(A,1)
    
    D = diag(diag(A));
    L = tril(A);
    
    LD = L+D;
    invLD = inv(LD);
    
    MGS = eye(n,n) - invLD*A;
    
    autovalores = spec(MGS); 
    radio_espectral = max(abs(autovalores));
    
    printf("Matriz del metodo:");
    disp(MGS);
    printf("Radio espectral de la matriz del metodo: %lf\n",radio_espectral);
    
    
endfunction

[A,b] = crearMatriz(20,2);
x0 = zeros(20,1);
iter = 1000;
tol = 1e-6;

x = gaussSeidel_ejercicio(A,b,x0,iter,tol)
x2 = solucion_exacta(20);

printf("Solucion del sistema dado");
disp(x);

printf("Solucion exacta");
disp(x2)

matriz_metodo(A);
