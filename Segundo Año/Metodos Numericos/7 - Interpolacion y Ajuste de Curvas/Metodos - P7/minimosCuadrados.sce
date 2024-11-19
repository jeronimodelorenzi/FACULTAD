function A = matrizMinimoCuadrado(x,grado)
    
    mX = length(x);
    A = ones(mX,1);
    for j = 2:grado+1
        A = [A,(x')^j-1]
    end
    
endfunction