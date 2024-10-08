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
