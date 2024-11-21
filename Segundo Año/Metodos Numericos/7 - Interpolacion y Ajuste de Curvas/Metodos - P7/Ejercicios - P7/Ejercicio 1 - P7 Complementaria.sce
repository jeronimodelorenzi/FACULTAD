x = [-2.0 -1.6 -1.2 -0.8 -0.4 0 0.4 0.8 1.2 1.6 2.0];
y = [1.50 0.99 0.61 0.27 0.02 -0.0096 0.065 0.38 0.63 0.98 1.50];

/* 
Queremos hallar un polinomio de grado 4 tal que p4(0) = 0 y p4'(0) = 0.
Sea  p4(x) = a0 + a1*x + a2*x^2 + a3*x^3 + a4*x^4, si derivamos tenemos:
p4'(x) = a1 + 2*a2*x + 3*a3*x^2 + 4*a4*x^3. Ahora evaluando x = 0,
p4(0) = a0 y p4'(0) = a1
Es decir, a0 = a1 = 0.
Entonces tenemos que encontrar p4(x) = a2*x^2 + a3*x^3 + a4*x^4.
La matriz va a estar definida de la siguiente manera:
[x(1)^2 x(1)^3 x(1)^4]
[x(2)^2 x(2)^3 x(2)^4]
[...    ...    ...   ]
[x(n)^2 x(n)^3 x(n)^4]
*/

function [A_aum , x] = gaussPivoteo(A,b)
    
    [nA,mA] = size(A); // tamaño de A
    [nB,mB] = size(b); // tamaño de b
    
    if(nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
    elseif(mA <> nB) then
        printf("Error - Incompatibilidad entre A y b");    
    end
    
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
    
endfunction

function [px,err] = minimosCuadrados(A,y)
    [A_aum,a] = gaussPivoteo(A'*A,A'*y');
    x = poly(0,'x');
    px = a(1)*x^2+a(2)*x^3+a(3)*x^4;
    err = norm(A*a-y');
    
endfunction

// Definamos la matriz

function A = crearMatriz(x)
    
    nX = length(x);
    for i = 1:nX
        A(i,1) = x(i)^2;
        A(i,2) = x(i)^3;
        A(i,3) = x(i)^4 
    end
    
endfunction

A = crearMatriz(x);

[p4,err] = minimosCuadrados(A,y);

printf("La matriz de minimos cuadrados es:");
disp(A);
printf("Polinomio de grado cuatro minimos cuadrados:");
disp(p4);

rango = -2.5:0.001:2.5
plot2d(rango',horner(p4,rango'),2);
plot2d(x',y,-1);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
