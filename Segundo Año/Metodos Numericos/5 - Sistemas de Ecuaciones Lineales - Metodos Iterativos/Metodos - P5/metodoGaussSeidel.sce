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
        
        cont = cont + 1;
        
        x(nA) = (b(nA) - A(nA,1:nA-1)*x(1:nA-1))/A(nA,nA);
           
        if (norm(x-xk) < tol) then
            break;
        end
        
    end
    
    printf("Cantidad de iteraciones: %d\n", cont);
    
endfunction

function x = metodoGaussSeidelMatricial(A,b,x0,iter,tol)
    
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
    
    D = diag(diag(A));
    L = tril(A) - D;
    
    invLD = inv(L+D);
    
    for i = 1:iter
        
        xk = x;
        
        x = invLD*b+(eye(nA,nA)-invLD*A)*xk;
        
        if (norm(x-xk) < tol) then
            break;
        end
        
        cont = cont + 1;
        
    end
        
    printf("Cantidad de iteraciones: %d\n", cont);
    
endfunction

function converge = corolarioGS(A)
    
    [nA,mA] = size(A);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    D = diag(diag(A));
    L = tril(A) - D;
    
    invLD = inv(L+D);
    Tgs = eye(nA,nA)-invLD*A;
    
    autovalores = spec(Tgs);
    radio_espectral = max(abs(autovalores));
    
    converge = radio_espectral < 1;
    
endfunction

function diagonalDominante = esDiagonalDominanteGS(A)
    
    [nA,mA] = size(A);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    diagonalDominante = %T;
    i = 1;
    
    while (i <= nA) && (diagonalDominante == %T)
        suma = sum(abs(A(i,:))) - abs(A(i,i));
        
        if abs(A(i,i)) <= suma then
            diagonalDominante = %F;
        end
        
        i = i + 1;
    end
    
endfunction

/*
1)
a) No podria aplicarse el sistema 1 ya que tenemos un elemento de
la diagonal nulo, en este caso a_11 = 0, por lo que no se podria realizar
la division.
*/
/* 
x0 = [0;0;0];
iter = 1000;
tol = 1e-2;

//------------------//

//A1 = [0 2 4 ; 1 -1 -1 ; 1 -1 2]; 
A1 = [1 -1 -1 ; 1 -1 2 ; 0 2 4]; // matriz A1 cambiando las filas
b1 = [0.375;0;0];
x1 = metodoGaussSeidel(A1,b1,x0,iter,tol);
printf("Solucion del sistema 1:\n");
disp(x1);
printf("\nComprobando -> A*x = b:\n");
Ax1 = A1*x1;
disp(Ax1);*/

//------------------//

/*A2 = [1 -1 0 ; -1 2 -1 ; 0 -1 1.1];
b2 = [0;1;0];
x2 = metodoGaussSeidel(A2,b2,x0,iter,tol);
printf("Solucion del sistema 2:\n");
disp(x2);
printf("\nComprobando -> A*x = b:\n");
Ax2 = A2*x2;
disp(Ax2);*/

//------------------------------------------//

//2

/*x0 = [0;0;0;0;0];
iter = 1000;
tol = 1e-6;
A = [10 1 2 3 4 ; 1 9 -1 2 -3 ; 2 -1 7 3 -5 ; 3 2 3 12 -1 ; 4 -3 -5 -1 15];
b = [12;-27;14;-17;12];
x = metodoGaussSeidel(A,b,x0,iter,tol);
printf("Solucion sistema: \n");
disp(x);*/

//------------------------------------------//

//4

/*
function x = metodoGaussSeidel(N,x0,iter,tol)
    tic();
    A = 8*eye(N,N) + 2*diag(ones(N-1,1),1) + 2*diag(ones(N-1,1),-1) + diag(ones(N-3,1),3) + diag(ones(N-3,1),-3);
    b = ones(N,1);

    nA = size(A,1);

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
    t = toc();
   
    printf("Tiempo:\n");
    disp(t); 
endfunction

printf("\nTiempo e iteraciones de la matriz de tamaño 100-eps=10^-6 | Gauss-Seidel\n");
x1 = metodoGaussSeidel(100,zeros(100,1),10000,1e-6);

printf("\nTiempo e iteraciones de la matriz de tamaño 500-eps=10^-6 | Gauss-Seidel\n");
x2 = metodoGaussSeidel(500,zeros(500,1),10000,1e-6);

printf("\nTiempo e iteraciones de la matriz de tamaño 100-eps=10^-11 | Gauss-Seidel \n");
x3 = metodoGaussSeidel(100,zeros(100,1),10000,1e-11);

printf("\nTiempo e iteraciones de la matriz de tamaño 500-eps=10^-11 | Gauss-Seidel\n");
x4 = metodoGaussSeidel(500,zeros(500,1),10000,1e-11);

function [A_aum , x] = gaussPivoteo(N)
    
    tic();
    A = 8*eye(N,N) + 2*diag(ones(N-1,1),1) + 2*diag(ones(N-1,1),-1) + diag(ones(N-3,1),3) + diag(ones(N-3,1),-3);
    b = ones(N,1);

    nA = size(A,1);
    
    A_aum = [A b]; // matriz aumentada
    
    
    
    // Gauss
    for k = 1:nA-1 // columna
        
        k_pivot = k; // suponemos posicion del pivote maximo
        max_pivot = abs(A_aum(k,k)); // suponemos valor del pivote maximo
        
        for i = k+1:nA // fila
            
            if(abs(A_aum(i,k)) > max_pivot) then
                k_pivot = i; // cambiamos la posicion del pivote maximo
                max_pivot = abs(A_aum(i,k)); // cambiamos el valor del pivote maximo
            end
            
        end
        
        //intercambio de filas
        temp = A_aum(k_pivot,:); // variable temporal para cambiar la fila
        A_aum(k_pivot,:) = A_aum(k,:); //cambiamos la fila donde esta el pivote maximo por la fila donde esta el 0
        A_aum(k,:) = temp; // cambiamos la fila donde esta el 0 por la fila donde esta el pivote maximo
        
        
        for i = k+1:nA // fila
            
            mik = A_aum(i,k)/A_aum(k,k);
            A_aum(i,k) = 0;
            A_aum(i,k+1:nA+1) = A_aum(i,k+1:nA+1) - mik*A_aum(k,k+1:nA+1);
       
       end
    end
    
    
    // Sustitucion regresiva
    x(nA) = A_aum(nA,nA+1)/A_aum(nA,nA);
    
    for k = nA-1:-1:1
        x(k) = (A_aum(k,nA+1) - A_aum(k,k+1:nA)*x(k+1:nA))/A_aum(k,k);
    end
    t = toc();
   
    disp(t); 
    
    
endfunction

printf("\nTiempo  de la matriz de tamaño 100 | GaussPivoteo \n");
[A,b] = gaussPivoteo(100);
printf("\nTiempo  de la matriz de tamaño 500 | GaussPivoteo \n");
[A2,b2] = gaussPivoteo(500);
*/

