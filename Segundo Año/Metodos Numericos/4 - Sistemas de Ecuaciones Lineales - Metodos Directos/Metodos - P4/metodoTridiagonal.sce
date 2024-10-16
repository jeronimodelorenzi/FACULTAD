function x = tridiagonal(A, b)
    
    [nA,mA] = size(A);
    [nB,mB] = size(b);
    
    if (nA<>mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    A_aum = [A b];
    
    for k = 1 : nA-1
        
        max_pivot = abs(A_aum(k,k));
        
        if (abs(A_aum(k+1,k)) > max_pivot) then
            temp = A_aum(k+1, :);
            A_aum(k+1, :) = A_aum(k, :);
            A_aum(k, :) = temp;
        end
        
        mk = A_aum(k+1,k) / A_aum(k,k);
        A_aum(k+1,k+1) = A_aum(k+1,k+1) - mk*A_aum(k,k+1);

        A_aum(k+1, nA+1) = A_aum(k+1, nA+1) - mk * A_aum(k, nA+1);
        
        
        
    end
    
    x(nA)=A_aum(nA,nA+1)/A_aum(nA,nA);
    x(nA-1)=(A_aum(nA-1,nA+1)-A_aum(nA-1,nA)*x(nA))/A_aum(nA-1,nA-1);
    
    for i=nA-2:-1:1 do
        x(i)=(A_aum(i,nA+1)-A_aum(i,i+1)*x(i+1)-A_aum(i,i+2)*x(i+2))/A_aum(i,i);
    end
    
endfunction

A = [1 1 0 0;1 1 1 0;0 1 1 1; 0 0 1 1];
b = [2;3;3;2];


x = tridiagonal(A,b);

printf("\nSolucion:\n");
disp(x);

