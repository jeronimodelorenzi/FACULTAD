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

A2 = [1 -1 2 -1 ; 2 -2 3 -3 ; 1 1 1 0 ; 1 -1 4 3]
b2 = [-8;-20;-2;4]

printf("\nSISTEMA 2:\n");
[a2, x2] = gaussPivoteo(A2,b2);
disp(x2);
