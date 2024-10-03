function [A_aum,x] = gaussVariosSistemas(A,B)
    
    [nA,mA] = size(A); // tamaño de A
    [nB,mB] = size(B); // tamaño de B
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    elseif (mA <> nB)
        printf("Error - Incompatibilidad entre A y B");
    end
    
    A_aum = [A B]; // matriz aumentada
    
    //Gauss
    for k = 1:nA - 1 // columna
        if abs(A_aum(k,k)) < %eps then
            printf("Valor muy pequeño o igual a 0 en el pivote A(%d,%d).\n", k, k);
            abort;
        end
        for i = k+1:nA // fila
            
            mik = A_aum(i,k)/A_aum(k,k); // multiplicador 
            A_aum(i,k) = 0; // debajo del pivot ponemos 0
            A_aum(i,k+1:nA+nB) = A_aum(i,k+1:nA+nB) - mik*A_aum(k,k+1:nA+nB); // modificamos el resto de la fila
            
        end
    end
    
    //Sustitucion regresiva
    x(nA,1:nA) = A_aum(nA,nA+1:nA+nB)./A_aum(nA,nA); // ultimo elemento de la solucion
    
    for k = nA-1:-1:1
        x(k,1:nB) = (A_aum(k,nA+1:nA+nB) - A_aum(k,k+1:nA)*x(k+1:nA,1:nB))./A_aum(k,k); // elemento k de la solucion
    end
    
endfunction


/*
A = [1 2 3 ; 3 -2 1 ; 4 2 -1];
B = [14 9 -2 ; 2 -5 2 ; 5 19 12];

printf("Solucion sitema:\n");
[a,x] = gaussVariosSistemas(A,B);
disp(x);

I = eye(3,3);
printf("\nInversa de A:\n");
[a, invA] = gaussVariosSistemas(A,I);
disp(invA);
*/
