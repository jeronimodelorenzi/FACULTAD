function [A_aum,x] = gauss(A,b)
    
    [nA,mA] = size(A); // tamaño de A 
    [nB,mB] = size(b); // tamaño de b
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    elseif (mA <> nB)
        printf("Error - Incompatibilidad entre A y b");
    end
    
    A_aum = [A b]; // matriz aumentada
    operaciones = 0;
    
    //Gauss
    for k = 1:nA - 1 // columna
        if abs(A_aum(k,k)) < %eps then
            printf("Valor muy pequeño o igual a 0 en el pivote A(%d,%d).\n", k, k);
            abort;
        end
        for i = k+1:nA // fila
            
            mik = A_aum(i,k)/A_aum(k,k); // multiplicador 
            A_aum(i,k) = 0; // debajo del pivot ponemos 0
            A_aum(i,k+1:nA+1) = A_aum(i,k+1:nA+1) - mik*A_aum(k,k+1:nA+1); // modificamos el resto de la fila
            operaciones = operaciones + 3;
        end
    end
    
    //Sustitucion regresiva
    x(nA) = A_aum(nA,nA+1)/A_aum(nA,nA); // ultimo elemento de la solucion
    operaciones = operaciones + 1;
    for k = nA-1:-1:1
        x(k) = (A_aum(k,nA+1) - A_aum(k,k+1:nA)*x(k+1:nA))/A_aum(k,k); // elemento k de la solucion
        operaciones = operaciones + 3;
    end
    
    printf("La cantidad de operaciones son: %d.\n",operaciones);
    
endfunction

/*
A1 = [1 1 0 3 ; 2 1 -1 1 ; 3 -1 -1 2 ; -1 2 3 -1]
b1 = [4;1;-3;4]
A2 = [1 -1 2 -1 ; 2 -2 3 -3 ; 1 1 1 0 ; 1 -1 4 3]
b2 = [-8;-20;-2;4]
A3 = [1 1 0 4 ; 2 1 -1 1 ; 4 -1 -2 2 ; 3 -1 -1 2]
b3 = [2;1;0;-3]

printf("\nSISTEMA 1:\n");
[a1, x1] = gauss(A1,b1);
disp(x1);

printf("\nSISTEMA 2:\n");
[a2, x2] = gauss(A2,b2);
disp(x2);

printf("\nSISTEMA 3:\n");
[a3, x3] = gauss(A3,b3);
disp(x3);
*/
