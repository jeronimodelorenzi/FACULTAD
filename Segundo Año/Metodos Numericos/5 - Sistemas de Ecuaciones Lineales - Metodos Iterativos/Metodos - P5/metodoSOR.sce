function x = metodoSOR(A,b,w,x0,iter,tol)
    
    [nA,mA] = size(A);
    nB = size(b,1);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    if (nB <> mA) then
        printf("Error - Incompatibilidad entre A y b");
        abort;
    end
    
    x = x0;
    cont = 0;
    
    for k = 1:iter
        
        xk = x;
        
        x(1) = (1-w)*xk(1) + w*(b(1)-A(1,2:nA)*x(2:nA))/A(1,1);
        
        for i = 2:nA-1
           
           suma = A(i,1:i-1)*x(1:i-1) + A(i,i+1:nA)*xk(i+1:nA);
           x(i) = (1-w)*xk(i) + w*(b(i) - suma)/A(i,i);
            
        end
        
        x(nA) = (1-w)*xk(nA) + w*(b(nA)-A(nA,1:nA-1)*x(1:nA-1))/A(nA,nA);
        
        if (norm(x-xk) < tol) then
            break;
        end
        
        cont = cont + 1;
        
    end
    
    printf("Cantidad de iteraciones: %d\n", cont);
    
endfunction

function w = omega_optimo(A)
    
    [nA,mA] = size(A);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    InvD = diag(1./diag(A));
    Tj = eye(nA,nA) - InvD*A;
    
    autovalores = spec(Tj);
    radio_espectral = max(abs(autovalores));
    
    w = 2/(1 + sqrt(1-radio_espectral^2));
    
endfunction

//5
/*
w1 = 1.1
x0 = [0;0;0];
iter = 1000;
tol = 1e-2;

//------------------//

A = [4 3 0 ; 3 4 -1 ; 0 -1 4];
b = [24;30;-24];
x1 = metodoSOR(A,b,0.5,x0,iter,tol);

printf("Solucion del sistema con omega elegido:\n");
disp(x1);

w_optimo = omega_optimo(A);
x2 = metodoSOR(A,b,w_optimo,x0,iter,tol);
printf("Solucion del sistema con omega optimo:\n");
printf("\nOmega optimo: %lf\n", w_optimo);
disp(x2);
*/
