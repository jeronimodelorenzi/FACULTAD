function v = deriv(f,n,vx,h)
    if n==0 then v=f(vx)
    else v=(deriv(f,n-1,vx+h,h)-deriv(f,n-1,vx,h))/h
    end
endfunction
