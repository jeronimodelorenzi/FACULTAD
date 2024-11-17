//EJERCICIO 2 JERONIMO DELORENZI

/*a*/
function  radio_espectral = r_SOR(w)
    
    A = [10 5 0 0 ; 5 10 -4 0 ; 0 -4 8 -1 ; 0 0 -1 5];
    
    D = diag(diag(A));
    U = triu(A) - D;
    L = tril(A) - D;
    
    DL = D+w*L;
    invDL = inv(DL);
    
    DU = (1-w)*D-w*U;
    
    Tw = invDL*DU;
    
    autovalores = spec(Tw);
    radio_espectral = max(abs(autovalores));
    
endfunction

/*Ejemplo*/

radio_espectral = r_SOR(1.1);
printf("Ejemplo radio espectral de la matriz del metodo SOR tomando w = 1.1");
disp(radio_espectral); 

/*Radio espectral de la matriz SOR 
    0.3278609*/
    
/*b*/

function grafico_w();
    x = [0.1:0.1:3]';
    n= size(x,1);
    y = zeros(n,1);
    for i = 1:n
        y(i) = r_SOR(x(i))
    end
    z = r_SOR(1);
    a = gca();
    a.x_location = "origin";
    a.y_location = "origin";
    plot(x,y);
    plot(x,z);
    
endfunction

grafico_w();

/*Sabemos que si w > 1 la convegencia es mas rapida para el Gauss-Seidel, por lo que viendo el grafico podemos decir que el intervalo es [1,1.46].*/

/*c*/

A = [10 5 0 0 ; 5 10 -4 0 ; 0 -4 8 -1 ; 0 0 -1 5];

function condicion = esDefinidaPositiva(A)
   
   autovalores = spec(A);
   n = size(A,1);
   i = 1;
   
   condicion = %T;
   
   while (i <= n) && (condicion == %T)
        if (autovalores(i) < 0) then
            condicion = %F;
        end
        i = i + 1;
   end
   
endfunction

condicion = esDefinidaPositiva(A);
printf("Es definida positiva:");
disp(condicion);
/*Es definida positiva: T*/
/*Para una eleccion optima para el omega, por teorema, se debe cumplir que la matriz sea definida positiva y triangular. La matriz A = [10 5 0 0 ; 5 10 -4 0 ; 0 -4 8 -1 ; 0 0 -1 5] es tridiagonal y si verificamos con el codigo esDefinidaPisitiva vemos que es definida positiva, por lo que existe un valor optimo del omega.

*/

function w = omega_optimo(A)
    
    [nA,mA] = size(A);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    InvD = diag(1./diag(A)); // inversa de la matriz diagonal
    Tj = eye(nA,nA) - InvD*A; // matriz del metodo
    
    autovalores = spec(Tj);
    radio_espectral = max(abs(autovalores));
    
    w = 2/(1 + sqrt(1-radio_espectral^2)); // omega optimo
    
endfunction

w = omega_optimo(A);
printf("Valor omega optimo:");
disp(w);

/*Valor omega optimo:
   1.1534986*/
   
/*d*/

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
    
    x = x0; // valor inicial
    cont = 0;
    
    for k = 1:iter
        
        xk = x; // guardamos valor anterior de x
        
        x(1) = (b(1) - A(1,2:nA)*xk(2:nA))/A(1,1); // x1
        
        for i = 2:nA-1
            suma = A(i,1:i-1)*x(1:i-1) + A(i,i+1:nA)*xk(i+1:nA); // sumatorias con submatrices
            x(i) = (b(i) - suma)/A(i,i); // xi
        end
        
        x(nA) = (b(nA) - A(nA,1:nA-1)*x(1:nA-1))/A(nA,nA); // xn
        
        cont = cont + 1;
        
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
    
    x = x0; // valor inicial
    cont = 0;
    
    D = diag(diag(A)); // matriz diagonal
    L = tril(A) - D; // matriz triangular inferior sin diagonal
    
    invLD = inv(L+D); // inversa L+D
    
    for i = 1:iter
        
        xk = x; // valor anterior de x
        
        x = invLD*b+(eye(nA,nA)-invLD*A)*xk;
        
        cont = cont + 1;
        
        if (norm(x-xk) < tol) then
            break;
        end
        
    end
        
    printf("Cantidad de iteraciones Gauss-Seidel: %d\n", cont);
    
endfunction
A = [10 5 0 0 ; 5 10 -4 0 ; 0 -4 8 -1 ; 0 0 -1 5];
b = [6;25;-11;-11];
x0 = [0;0;0;0];
tol = 1e-6;
iter = 1000;

x1 = metodoGaussSeidelMatricial(A,b,x0,iter,tol);
printf("Solucion del sistema:")
disp(x1);
printf("Comprobando A*x");
disp(A*x1);
/*
Cantidad de iteraciones: 19
Solucion del sistema:
  -0.7976467
   2.7952938
  -0.2588237
  -2.2517647
Comprobando A*x
   6.0000017
   24.999999
  -11.000000
  -11.000000
*/

/*e*/

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
    
    x = x0; // valor inicial de x
    cont = 0;
    
    for k = 1:iter
        
        xk = x; // guardamos el valor anterior de x
        
        x(1) = (1-w)*xk(1) + w*(b(1)-A(1,2:nA)*x(2:nA))/A(1,1); // x1
        
        for i = 2:nA-1
           
           suma = A(i,1:i-1)*x(1:i-1) + A(i,i+1:nA)*xk(i+1:nA); // sumatoria con submatrices
           x(i) = (1-w)*xk(i) + w*(b(i) - suma)/A(i,i); // xi
            
        end
        
        x(nA) = (1-w)*xk(nA) + w*(b(nA)-A(nA,1:nA-1)*x(1:nA-1))/A(nA,nA); // xn
        
        cont = cont + 1;
        
        if (norm(x-xk) < tol) then
            break;
        end
            
    end
    
    printf("Cantidad de iteraciones SOR: %d\n", cont);
    
endfunction

A = [10 5 0 0 ; 5 10 -4 0 ; 0 -4 8 -1 ; 0 0 -1 5];
w = omega_optimo(A);
b = [6;25;-11;-11];
x0 = [0;0;0;0];
tol = 1e-6;
iter = 1000;

x2 = metodoSOR(A,b,w,x0,iter,tol);
printf("Solucion del sistema:")
disp(x2);
printf("Comprobando A*x");
disp(A*x2);
/*
Cantidad de iteraciones SOR: 11
Solucion del sistema:
  -0.7976471
   2.7952942
  -0.2588235
  -2.2517647
Comprobando A*x
   5.9999994
   25.000000
  -11.000000
  -11.000000
*/
