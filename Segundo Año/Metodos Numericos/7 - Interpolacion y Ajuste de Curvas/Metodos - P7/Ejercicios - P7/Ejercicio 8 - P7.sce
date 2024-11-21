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

function [A,px,err] = minimosCuadrados(x,y,grado)
    
    
    nY = length(y);
    mX = length(x);
    
    if(mX <> nY) then
        error("Los tamaños de x e y deben ser iguales.");
    end
    
    A = ones(mX,1);
    
    for j = 2:grado+1
        A = [A,(x').^(j-1)];
    end
    
    [A_aum,res] = gaussPivoteo(A'*A,A'*y');
    px = poly(res,'x','coeff');
    err = norm(A*res-y');
    
endfunction

x = [4 4.2 4.5 4.7 5.1 5.5 5.9 6.3 6.8 7.1];
y = [102.56 113.18 130.11 142.05 167.53 195.14 224.87 256.73 299.5 326.72];

// grado 1

// grado = 1
[A1,px1,err1] = minimosCuadrados(x,y,1);

printf("Grado 1:\n")
printf("Matriz de minimos cuadrados:");
disp(A1);
printf("Polinomio minimos cuadrados:");
disp(px1);
printf("Error: %lf\n",err1);

// grado = 2
[A2,px2,err2] = minimosCuadrados(x,y,2);

printf("\nGrado 2:\n")
printf("Matriz de minimos cuadrados:");
disp(A2);
printf("Polinomio minimos cuadrados:");
disp(px2);
printf("Error: %lf\n",err2);

// grado = 3
[A3,px3,err3] = minimosCuadrados(x,y,3);

printf("\nGrado 3:\n")
printf("Matriz de minimos cuadrados:");
disp(A3);
printf("Polinomio minimos cuadrados:");
disp(px3);
printf("Error: %lf\n",err3);

// Ploteo
rango = 4:0.001:7.2
plot2d(x',y,-1);
plot2d(rango,[horner(px1,rango') horner(px2,rango') horner(px3,rango')], [2,3,4],leg=["px1(x)@px2(x)@px3(x)"]);
