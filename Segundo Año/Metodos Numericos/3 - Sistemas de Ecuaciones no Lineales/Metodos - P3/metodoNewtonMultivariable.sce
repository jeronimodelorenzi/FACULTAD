function y = funciones(k)
    y(1) = k(1)*exp(k(2))+k(3)-10
    y(2) = k(1)*exp(2*k(2))+2*k(3)-12
    y(3) = k(1)*exp(3*k(2))+3*k(3)-15
endfunction

function nm = newtonMultivariable(f,x0,tol,iter,h)
    
    J = numderivative(f,x0,h);
    x1 = x0 - (inv(J)*f(x0))'; // *' = transpuesta *
    i = 1;
    delta = norm(x1-x0);
    
    while (delta>tol) && (i < iter)
        x0 = x1;
        J = numderivative(f,x0,h);
        x1 = x0 - (inv(J)*f(x0))';
        delta = norm(x1-x0);
        i = i + 1;
    end
    
    nm = x1;
    printf("Iteraciones: %d\n", i);

endfunction

vectorInicial = [1,1,1];
errorDeseado = 0.0001;
maxIteraciones = 1000;
solucion = newtonMultivariable(funciones, vectorInicial, errorDeseado, maxIteraciones,2);
disp(solucion);


function dy = funcionesDerivadas(x)
    dy(1) = 2*x(1)+exp(x(1))*cos(x(2));
    dy(2) = -2*x(2) -exp(x(1))*sin(x(2));
    dy(3) = 2*x(2)+exp(x(1))*sin(x(2));
    dy(4) = 2*x(1)+exp(x(1))*cos(x(2));
endfunction
