function v = derivadaCocienteIncremental(fun,n,vx,h)
    deff("y=f(x)", "y="+fun);
    if n==0 then
        v=f(vx);
    else
        v = (derivadaCocienteIncremental(fun,n-1,vx+h,h) - derivadaCocienteIncremental(fun,n-1,vx,h))/h;
    end
endfunction

function valor = derivadaNum(f,v,n,h)
    deff("y=DF0(x)","y="+f);
    if n==0 then valor = DF0(v);
    else
        for i=1:(n-1)
        deff("y=DF"+string(i)+"(x)","y=numderivative(DF"+string(i-1)+",x,"+string(h)+",4)");
        end
        deff("y=DFn(x)","y=numderivative(DF"+string(n-1)+",x,"+string(h)+",4)");
        valor = DFn(v);
    end
endfunction
funcion = "x^2+1";
valor_cociente = derivadaCocienteIncremental(funcion,2,55,0.0000001);
valor_numderivative = derivadaNum(funcion,2,55,0.0000001);

error1 = abs(valor_cociente - valor_numderivative);
printf("El valor con cociente es: %e.\n", valor_cociente);
printf("El valor con numderivative es: %e.\n", valor_numderivative);
printf("El error es: %e.\n", error1);

