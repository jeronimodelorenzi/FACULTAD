// Interpolación Lagrange
function y = Lk(x,k)
    [Xn,Xm] = size(x)
    r = [x(1:k-1) x(k+1:Xm)]
    p = poly(r,"x","roots")
    pk = horner(p,x(k))
    y = p / pk
endfunction

function z = interpolLagrange(x,y)
    [Xn,Xm] = size(x)
    pol = 0
    for k = 1:Xm
        pol = pol + (Lk(x,k)*y(k))
    end
    z = pol
endfunction

// lineal
x1=[0,0.2]
y1=[1,1.2214]
// cubica
x2=[0,0.2,0.4,0.6]
y2=[1,1.2214,1.4918,1.8221]

lineal = interpolLagrange(x1,y1)
cubica = interpolLagrange(x2,y2)

rango = [-2:0.01:2]

plot(rango,horner(lineal,rango),"r")
plot(rango,horner(cubica,rango),"b")
plot(rango,exp(rango),"g")
a=gca();
a.x_location = "origin";
a.y_location = "origin";
h1 = legend("Lineal","Cubico","e^x")

/*
Error en el caso lineal es:
 er_lineal(x) = (x-0)*(x-0.2)/2*exp(c_x)''
 
 exp(x)'' = exp(x), tomo el extremo derecho 0.2
 er_lineal(1/3) =  ((1/3)-0)*((1/3)-0.2)/2*exp(0.2) 
                = 0.0271423
*/

/*Ejercicio 7.5*/
/*
x = [0,1,2,3]
y = [1,3,3,k]
/*
P_123(x) =L1(x)*3 + L2(x)*3 + L3(x)* k
P_123(2.5) =L1(2.5)*3 + L2(2.5)*3 + L3(2.5)* k = 3
*/
/*
x = [1,2,3]
L1 = Lk(x,1)
L2 = Lk(x,2)
L3 = Lk(x,3)

c1 = horner(L1,2.5)*3
c2 = horner(L2,2.5)*3
c3 = horner(L3,2.5)
k = (3-c1-c2)/c3

xx = [0,1,2,3]
yy = [1,3,3,k]

p = interpolLagrange(xx,yy)

res = horner(p,2.5)



function w = DD(x,y)
    // y = [f(x0),f(x1),...]
    n = length(x);
    if n == 1 then
        w = y(1);
    else
        w = (DD(x(2:n),y(2:n))-DD(x(1:n-1),y(1:n-1)))/(x(n)-x(1));
    end    
endfunction

function p = DD_newton(x,y)
    
    n = length(x);
    xx = poly(0,"x");
    p = 0;
    for j=n:-1:2
        p =(xx-x(j-1))*(DD(x(1:j),y(1:j)+p));
    end 
    
    p = p + y(1);
    
endfunction

/*
// Diferencias dividas

function w=DD(x,y)
    n = length(x);
    if n==1 then
        w = y(1)
    else
        w = (DD(x(2:n),y(2:n))-DD(x(1:n-1),y(1:n-1)))/(x(n)-x(1))
    end;
endfunction

// Polinomio interpolante (con Newton)

function p = DD_newton(x,y)
    r = poly(0,"x");
    p = 0;
    n= length(x);
    for i=n:(-1):2
        p = (p+DD(x(1:i),y(1:i)))*(r-x(i-1))
    end;
    p = p + y(1);
endfunction*/
