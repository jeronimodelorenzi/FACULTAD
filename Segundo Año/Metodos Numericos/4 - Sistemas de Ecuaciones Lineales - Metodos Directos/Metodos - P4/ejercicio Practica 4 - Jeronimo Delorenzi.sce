// Funciones

function R = cholesky(A)
    
    [nA, mA] = size(A);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    eps = 1.0e-8;
    
    R = zeros(nA, nA);
    
    for k = 1:nA
        
        if (k == 1) then
            t = A(k,k);
        else
            t = A(k, k) - R(1:k-1, k)' * R(1:k-1, k);
        end
        
        
        if (t <= eps) then
            printf("Matriz no definida positiva");
            abort;
        end
        
        R(k, k) = sqrt(t);
        
        for j = k + 1:nA
            
            if(k == 1) then
                R(k,j) = A(k,j) / R(k,k);
            else
                R(k, j) = (A(k, j) - R(1:k-1, k)' * R(1:k-1, j)) / R(k, k);      
            end
           
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

// Ejercicio Practica 4

A = [4 -1 0 ; -1 4 -1 ; 0 -1 4];
b = [2;6;2];

// a

/*
Queremos encotrar la solucion del sistema Ax = b mediante la factorizacion de Cholesky a A.
Sabemos que en dicha factorizacion A = R^tR. Luego R^tRx = b si llamamos y a Rx
tenemos un sistema:
R^t*y = b
R*y = x
Entonces:
*/

R = cholesky(A);

printf("La matriz de la factorizacion de Cholesky es:");
disp(R);
printf("Su traspuesta:");
disp(R')

/*
La matriz de la factorizacion de Cholesky es:
   2.  -0.5         0.       
   0.   1.9364917  -0.5163978
   0.   0.          1.9321836
Su traspuesta:
   2.    0.          0.       
  -0.5   1.9364917   0.       
   0.   -0.5163978   1.9321836
*/

/*
Resolvemos el sistema
*/

y = triangularInferior(R',b);
x = triangularSuperior(R,y);

printf("La solucion del sistema es:");
disp(x);
printf("Comprobando, A*x = b");
disp(A*x); 
/*
La solucion del sistema es:
   1.
   2.
   1.
Comprobando, A*x = b
   2.
   6.
   2.
*/

// b

/*
Sabemos que si existe factorizacion de Cholesky de la matriz, entonces admite inversa.
Entoces, para calcular la inversa tomemos:
AX = I => R^t*R*X = I
llamemos Y a R*X,
entonces R^t*Y = I
         R*X = Y
*/


function X = triangularSuperiorAmpliado(A,B)
    
    [nA,mA] = size(A);
    [nB,mB] = size(B);

    X(nA,1:nA) = B(nA,1:nB)./A(nA,nA);
    
    for k = nA-1:-1:1
        X(k,1:nB) = (B(k,k:nB) - A(k+1,k:nA)*X(k+1:nA,1:nB))./A(k,k); 
    end
    
endfunction

function X = triangularInferiorAmpliado(A,B)

    [nA,mA] = size(A);
    [nB,mB] = size(B);

    X(1:nA,1) = B(1,1:nB)/A(1,1);
    
    for i=2:nA
        X(i:nA,1) = (B(i,i:nB) - A(i,i:nA)*X(i,1:nB))/A(i,i);
    end
    
endfunction

// c

/*
Ahora queremos encontrar la matriz X tal que AX = 2A.
AX = 2A => R^t*R*X = 2A
llamemos Y a R*X,
entonces R^t*Y = 2A
         R*X = Y
*/

// No pude implementar los sistemas Ampliados

