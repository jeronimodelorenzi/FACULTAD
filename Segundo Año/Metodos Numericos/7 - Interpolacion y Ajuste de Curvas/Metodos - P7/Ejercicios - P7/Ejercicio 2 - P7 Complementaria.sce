function dif = DD(x,y)
    
    nX = length(x);
    nY = length(y);
    
    if(nX <> nY) then
        error("Los tamaños de x e y deben ser iguales.");
    end
    
    dif = y;
    for k = 2:nX
        for i = nX:-1:k
            dif(i) = (dif(i)-dif(i-1))/(x(i)-x(i-k+1));
        end
    end
    
endfunction

function px = DD_Newton(x,y)
    
    nX = length(x);
    nY = length(y);
    
    if(nX <> nY) then
        error("Los tamaños de x e y deben ser iguales.");
    end
    
    coef = DD(x, y);
    px = coef(nX); 
    r = poly(0, "x");

    for i = nX-1:-1:1
        px = coef(i) + (r - x(i)) * px;
    end
    
endfunction

function r = rootsChebyshev(n)
    
    r = zeros(1,n);
    coef = %pi/(2*n);
    
    for k=0:n-1
        r(k+1) = cos((2*k+1)*coef);
    end
    
endfunction

/* 
Sea f(x) = e^x y los nodos [-1,-1/3,1/3,1] uniformemente espaciados.
Queremos encontrar el polinomio interpolante que pasa por estos puntos.
*/

x = [-1,-1/3,1/3,1];
y = exp(x);

px = DD_Newton(x,y);

px_eval1 = horner(px,-0.9);
px_eval2 = horner(px,0.01);

e_scilab1 = exp(-0.9);
e_scilab2 = exp(0.01);

printf("El polinomio interpolante con diferencias divididas de Newton es:");
disp(px);
printf("Polinomios evaluados:\n");
printf("P(-0.9) =  %lf \nP(0.01) = %lf\n",px_eval1,px_eval2);
printf("e^-0.9 = %lf \ne^0.01 = %lf\n",e_scilab1,e_scilab2);


/*
Sabemos que el error esta definido como f(x)-p(x) = [(x-x0)*...*(x-xn)]/(n+1)! * f^(n+1)(c). Luego,
|e^(-0.9)-p(-0.9)| = |[(-0.9+1)*(-0.9+1/3)*(-0.9-1/3)*(-0.9-1)]|/24 * |e^c| <= |[(x+1)*(x+1/3)*(x-1/3)*(x-1)]|/24 * |e^c|
*/

/*
Obtenemos las raices del polinomio de Chebyshev
*/

r_Cheby = rootsChebyshev(4);
y2 = exp(r_Cheby);

qx = DD_Newton(r_Cheby,y2);
printf("El polinomio interpolante con diferencias divididas de Newton y raices del polinomio de Chebyshev:");
disp(qx);

// Errores

rango = -1:0.001:1

e_rango = exp(rango);
px_rango = horner(px,rango);
qx_rango = horner(qx,rango);
err_px = e_rango - px_rango;
err_qx = e_rango - qx_rango;

// Ploteo
plot2d(rango,[err_px' err_qx'], [2,3], leg = "error p(x)@error q(x)");
a = gca();
a.x_location = "origin";
a.y_location = "origin";


// Faltan c,d,f.
