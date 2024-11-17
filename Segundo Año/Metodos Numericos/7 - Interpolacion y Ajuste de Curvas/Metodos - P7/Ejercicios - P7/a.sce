// Aproximación polinomial de mínimos cuadrados para matrices con rango completo
function [p,err] = MinCuad_pol(A,b)
    [a,A_amp] = gausselimPP((A')*A,(A')*(b'))
    p = poly(a,"x","coeff")
    err = norm(A*a-(b'))
endfunction

// Matriz del método de mínimo cuadrados polinomial
function A = A_mc(x,grado)
    // p = grado+1
    m = length(x)
    A = ones(m,1)
    for j=2:(grado+1)
        A = [A,(x').^(j-1)]
    end
endfunction

// f(x) = a1*e^x + a2*cos(x)

x1 = 0
y1 = 1
x2 = 1
y2 = 4

/*A_ec = [
    %e^x1 cos(x1);
    %e^x2 cos(x2)
]*/

A_ec = [
    x1^2 cos(x1);
    x2^2 cos(x2)
]

b_ec = [y1; y2]

[w,amp] = gausselimPP(A_ec,b_ec)

/*function y = mc_ec(x)
    y = w(1)*%e.^x + w(2)*cos(x)
endfunction*/

function y = mc_ec(x)
    y = w(1)*x^2 + w(2)*cos(x)
endfunction

xx=-1:0.001:2
x = [x1;x2]
plot2d(x,b_ec,-1)
plot2d(xx',[xx'.^2,cos(xx'),mc_ec(xx')],[2,3,4],leg="p1(x)@p2(x)@p8(x)")

// Método de Eliminación Gaussiana con pivoteo parcial
function [x,a] = gausselimPP(A,b)
[nA,mA] = size(A) 
[nb,mb] = size(b)
a = [A b];
n = nA;

for k=1:n-1
    kpivot = k; amax = abs(a(k,k));
    for i=k+1:n
        if abs(a(i,k))>amax then
            kpivot = i; amax = a(i,k);
        end;
    end;
    temp = a(kpivot,:); a(kpivot,:) = a(k,:);
    a(k,:) = temp
    
    for i=k+1:n
        for j=k+1:n+1
            a(i,j) = a(i,j) - a(k,j)*a(i,k)/a(k,k)
        end;
        for j=1:k
            a(i,j) = 0;
        end
    end
end

x(n) = a(n,n+1)/a(n,n)

for i = n-1:-1:1
    sumk = 0
    for k=i+1:n
        sumk = sumk + a(i,k)*x(k)
    end
    x(i) = (a(i,n+1)-sumk)/a(i,i)
end

endfunction
/*
// - Ejercicio 8 - //
x=[4,4.2,4.5,4.7,5.1,5.5,5.9,6.3,6.8,7.1]
y=[102.56,113.18,130.11,142.05,167.53,195.14,224.87,256.73,299.5,326.72]

disp("ítem a)")

disp("(#) n=1.")
A = A_mc(x,1)
deter = det((A')*A)
disp("La matriz A del método tiene rango completo, pues: det(A^T*A) = "+string(deter))
disp("El polinomio de mínimos cuadrados de grado 1 es:")
[p1,err1] = MinCuad_pol(A,y)
disp(p1)

disp("(#) n=2.")
A = A_mc(x,2)
deter = det((A')*A)
disp("La matriz A del método tiene rango completo, pues: det(A^T*A) = "+string(deter))
disp("El polinomio de mínimos cuadrados de grado 2 es:")
[p2,err2] = MinCuad_pol(A,y)
disp(p2)

disp("(#) n=3.")
A = A_mc(x,3)
deter = det((A')*A)
disp("La matriz A del método tiene rango completo, pues: det(A^T*A) = "+string(deter))
disp("El polinomio de mínimos cuadrados de grado 3 es:")
[p3,err3] = MinCuad_pol(A,y)
disp(p3)

disp("(#) n=3.")
A = A_mc(x,3)
deter = det((A')*A)
disp("La matriz A del método tiene rango completo, pues: det(A^T*A) = "+string(deter))
disp("El polinomio de mínimos cuadrados de grado 3 es:")
[p3,err3] = MinCuad_pol(A,y)
disp(p3)
disp(err3)


disp("(#) Analizamos los errores err = norm(Ax-y,2).")
disp("Para la aproximación lineal: "+string(norm(err1,2)))
disp("Para la aproximación cuadrática: "+string(norm(err2,2)))
disp("Para la aproximación cúbica: "+string(norm(err3,2)))
disp("Podemos decir que es mejor la aproximación cúbica en este caso.")

disp("ítem b)")

xx=4:0.001:7.2
plot2d(x',y,-1)
plot2d(xx',[horner(p1,xx'),horner(p2,xx'),horner(p3,xx')],[2,3,4],leg="p1(x)@p2(x)@p8(x)")
*/
