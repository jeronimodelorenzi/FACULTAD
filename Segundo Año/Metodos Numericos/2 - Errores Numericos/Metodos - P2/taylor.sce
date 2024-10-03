function v = derivadaCocienteIncremental(fun,n,vx,h)
    deff("y=f(x)", "y="+fun);
    if n==0 then
        v=f(vx);
    else
        v = (derivadaCocienteIncremental(fun,n-1,vx+h,h) - derivadaCocienteIncremental(fun,n-1,vx,h))/h;
    end
endfunction

function f = fact(n)
    if n == 0 then
        f = 1;
    else
        f = n * fact(n-1);
    end
endfunction


function v = taylor(fun,n,vx,h)
    deff("y=f(x)", "y="+fun);
    v = 0;  
    
    x = poly(0,'x');  
    
    for i = 0:n
        deriv = derivadaCocienteIncremental(fun, i, vx, h);
        v = v + (deriv / fact(i)) * (x - vx)^i;  
    end
endfunction


function v = taylor2(fun,n,vx,x0)
    deff("y=f(x)", "y="+fun);
    v = f(x0);  
     
    
    for i = 1:n
        deriv = numderivative(f,vx,i);
        v = v + (deriv / factorial(i)) * (x0 - vx)^i;  
    end

// Probar la función con 'exp(x)' en el punto vx = 0 y evaluarlo en x = -2
fun = "exp(x)";
grado = 10;
vx = 0;
h = 0.00001;

// Calcular el polinomio de Taylor de grado 10 para exp(x) alrededor de 0
taylor_poly = taylor(fun, grado, vx, h);

// Evaluar el polinomio en x = -2
valor_aproximado = horner(taylor_poly, -2);
valor_real = exp(-2);

// Mostrar los resultados
printf("Polinomio de Taylor (grado %d) para exp(x) en vx = %f: \n", grado, vx);
disp(taylor_poly);
printf("\nValor aproximado en x = -2: %f\n", valor_aproximado);
printf("Valor real de exp(-2): %f\n", valor_real);
printf("Error absoluto: %e\n", abs(valor_aproximado - valor_real));
