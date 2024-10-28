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
       
        cont = cont + 1;
       
        if (norm(x-xk)<tol) then
            break;
        end
                        
    end
    
    printf("Cantidad de iteraciones: %d\n", cont);
    
endfunction

function x = metodoJacobiMatricial(A,b,x0,iter,tol)
    
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
    
    cont = 0;
    
    InvD = diag(1 ./ diag(A));
    
    x = x0;
    
    for i=1:iter
        
        xk = x;
        
        x = InvD*b + (eye(nA,nA) - InvD*A)*xk;
        
        if (norm(x-xk) < tol) then
            break;
        end
        
        cont = cont + 1;
        
    end
    
    printf("Cantidad de iteraciones: %d\n",cont);
    
endfunction

function converge = condicion_suficienteJ(A)
    
    [nA,mA] = size(A);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    invD = diag(1./diag(A));
    Tj = eye(nA,nA) - invD*A;
    converge = norm(Tj) < 1;
    
endfunction

function converge = corolarioJ(A)
    
    [nA,mA] = size(A);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    InvD = diag(1./diag(A));
    Tj = eye(nA,nA) - InvD*A;
    
    autovalores = spec(Tj);
    radio_espectral = max(abs(autovalores));
    
    converge = radio_espectral < 1;
    
endfunction

function diagonalDominante = esDiagonalDominanteJ(A)
    
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
A1 = [1 -1 -1 ; 1 -1 2 ; 0 2 4];
b1 = [0.375;0;0];
x1 = metodoJacobi(A1,b1,x0,iter,tol);
printf("Solucion del sistema 1:\n");
disp(x1);
printf("\nComprobando -> A*x = b:\n");
Ax1 = A1*x1;
disp(Ax1);*/

//------------------//

/*A2 = [1 -1 0 ; -1 2 -1 ; 0 -1 1.1];
b2 = [0;1;0];
x2 = metodoJacobi(A2,b2,x0,iter,tol);
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
x = metodoJacobi(A,b,x0,iter,tol);
printf("Solucion sistema: \n");
disp(x);*/
