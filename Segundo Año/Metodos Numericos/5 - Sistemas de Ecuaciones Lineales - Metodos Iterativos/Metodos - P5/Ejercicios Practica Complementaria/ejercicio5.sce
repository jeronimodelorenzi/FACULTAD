function x = metodoJacobi(A,b,x0,iter,tol)
    
    [nA,mA] = size(A);
    nB = size(b,1);
    
    if(nA<>mA) then
        printf("Error - La matriz A debe ser cuadrada.");
        abort;
    end
    
    if (nB <> mA) then
        printf("Tamaños incompatibles entre A y b");
        abort;
    end
    
    x = x0;
    cont = 0;
        
    for k = 1:iter
        
        xk = x;
        
        for i = 1:nA
            suma = A(i,:) * xk - A(i,i) * xk(i);
            x(i) = (b(i) - suma)/ A(i,i);
        end
       
        if (norm(x-xk)<tol) then
            break;
        end
        
        cont = cont + 1;
        
    end
    
    printf("Cantidad de iteraciones: %d\n", cont);
    
endfunction

function x = metodoGaussSeidel(A,b,x0,iter,tol)
    
    [nA,mA] = size(A);
    nB = size(b,1);
    
    if(nA<>mA) then
        printf("Error - La matriz A debe ser cuadrada.");
        abort;
    end
    
    if (nB <> mA) then
        printf("Tamaños incompatibles entre A y b");
        abort;
    end
    
    x = x0;
    cont = 0;
    
    for k = 1:iter
        
        xk = x;
        
        x(1) = (b(1) - A(1,2:nA)*xk(2:nA))/A(1,1);
        
        for i = 2:nA-1
            suma = A(i,1:i-1)*x(1:i-1) + A(i,i+1:nA)*xk(i+1:nA);
            x(i) = (b(i) - suma)/A(i,i);
        end
        
        x(nA) = (b(nA) - A(nA,1:nA-1)*x(1:nA-1))/A(nA,nA);
           
        if (norm(x-xk) < tol) then
            break;
        end
        
        cont = cont + 1;
        
    end
    
    printf("Cantidad de iteraciones: %d\n", cont);
    
endfunction

A = [10 -1 2 0 ; -1 11 -1 3 ; 2 -1 10 -1 ; 0 3 -1 8]
b = [6;25;-11;15];
x0 = [0;0;0;0];
iter = 1000;
tol = 1e-5;

x1 = metodoJacobi(A,b,x0,iter,tol);
printf("Solucion metodo Jacobi:");
disp(x1);

x2 = metodoGaussSeidel(A,b,x0,iter,tol);
printf("Solucion metodo Gauss-Seidel:");
disp(x2);

/*El metodo de Gauss-Seidel realiza menos iteraciones (6) que el metodo de Jacobi (15).*/
