function x = gaussSeidel(A,b,x0,iter,tol)
    nA = size(A,1);
    x = x0;
    cont = 0;
    
    for k = 1:iter
        
        xk = x;
        
        for i = 1:nA
            suma = A(i,:)*x - A(i,i)*x(i);
            x(i) = (b(i) - suma)/A(i,i);
        end
        
        cont = cont + 1;
        
        if (norm(x-xk) < tol) then
            break;
        end
        
    end
    
    printf("Cantidad de iteraciones: %d\n", cont);
    
endfunction

/*A2 = [1 -1 0 ; -1 2 -1 ; 0 -1 1.1];
b2 = [0;1;0];

x2 = gaussSeidel(A2,b2,[0;0;0],1000,1e-6);
printf("Solucion 2: \n");
disp(x2);*/

A = [10 1 2 3 4 ; 1 9 -1 2 -3 ; 2 -1 7 3 -5 ; 3 2 3 12 -1 ; 4 -3 -5 -1 15];
b = [12;-27;14;-17;12];
x = gaussSeidel(A,b,[0;0;0;0;0],1000,1e-6);
printf("Solucion 2: \n");
disp(x);
