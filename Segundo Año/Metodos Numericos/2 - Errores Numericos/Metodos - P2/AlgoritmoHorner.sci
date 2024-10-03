function b = algHorner(p,x0)
    n = degree(p);
    b = 0;
    for i=n:-1:0
        b = coeff(p,i) + x0*b
    end
endfunction
