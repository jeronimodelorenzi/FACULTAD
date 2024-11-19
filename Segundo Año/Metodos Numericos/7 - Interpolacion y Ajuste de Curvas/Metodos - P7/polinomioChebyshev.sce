function r = rootsChebyshev(n)
    
    r = zeros(1,n);
    coef = %pi/(2*n);
    
    for k=0:n-1
        r(k+1) = cos((2*k+1)*coef);
    end
    
endfunction

function r = rootsChebyshev_ab(n,a,b)
    
    if(n <= 0) then
        error("n debe ser mayor a 0.");
    end
    
    r = zeros(1,n);
    coef = %pi/(2*n);
    
    for k=0:n-1
        r(k+1) = cos((2*k+1)*coef);
    end
    
    r = ((b+a)+r*(b-a))/2
    
endfunction

function w = polinomioChebyshev(x,n)
    if n==0 then
        w = 1
    elseif n==1 then
        w = x
    elseif n==2 then
        w = 2*x.^2-1
    else
        w = 2*x.*Cheby(x,n-1)-Cheby(x,n-2)
    end
endfunction
