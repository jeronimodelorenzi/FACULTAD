// Funciones

function c = biseccion(f,a,b,tol,iter)
    
    if (a >= b) then 
        
        c = %nan;
        printf("Intervalo incorrecto");
        return;
        
    end
    
    if (f(a)*f(b) > 0) then 
        
        c = %nan;
        printf("No es posible aplicar bisección.");
        return;
        
    elseif (f(a)*f(b) == 0) then
        
        if(f(a) == 0) then c = a; else c = b; end
        
    else
        
        c = (a+b)/2;
        i = 0;
        
        while (b-c>tol) && (i<iter)
            
            i = i+1;
            
            if (f(c) == 0) then
                
                return;
                
            elseif (f(b)*f(c)< 0) then
                
                a = c;
                
            else b = c;
            end
            
            c = (a+b)/2;
            
        end
        
        if b-c > tol then
            printf("Se alcanzó la cantidad máxima de iteraciones.\n");
        end
        
        printf("Iteraciones: %d\n", i);
       
        
    end
    
endfunction

function s = secante(f,x0,x1,tol,iter)
    
    x2 = x1 -f(x1)*(x1-x0)/(f(x1)-f(x0));
    
    delta = abs(x2 - x1);
    
    i = 0;
    
    while (delta>tol) && (i<iter)
        
        i = i + 1;
        
        x0 = x1;
        x1 = x2;
        x2 = x1 -f(x1)*(x1-x0)/(f(x1)-f(x0));
        
        delta = abs(x2 - x1);
        
    end
    
    if(delta > tol)
       printf("Se alcanzó la cantidad máxima de iteraciones.\n"); 
    end
    
    printf("Iteraciones %d\n", i);
    
    s = x2;
    
endfunction

function y = f1(x)
    y = cos(x).*cosh(x)+1;
endfunction

function y = f2(x)
    y = 2*sin(x)-x^2;    
endfunction

function y = f3(x)
    y = exp(-x)-x^4;
endfunction

function y = f4(x)
    y = log(x)-x+1;
endfunction

function y = f5(x)
    y = x^2/4-sin(x);
endfunction

// Ploteos

rango = -4:0.01:4;

subplot(231);
plot2d(rango',f1(rango'),3);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("f1(x) = cos(x)*cosh(x)+1");

subplot(232);
plot2d(rango',f2(rango'),4);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("f2(x) = 2*sin(x)-x^2");

subplot(233);
plot2d(rango',f3(rango'),2);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("f2(x) = exp(-x)-x^4");

subplot(234);
plot2d(rango',f4(rango'),1);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("f2(x) = log(x)-x+1;");

subplot(235);
plot2d(rango',f5(rango'),5);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("f2(x) = x^2/4-sin(x)");

// Secante y biseccion.

maxTol = 1e-6;
iter = 1000;

bisec1 = biseccion(f1,1,2,maxTol,iter);
secan1 = secante(f1,1,2,maxTol,iter); 
printf("Valor biseccion f1 = %lf | Valor secante f1 = %lf\n\n", bisec1, secan1);

bisec2 = biseccion(f2,1,2,maxTol,iter);
secan2 = secante(f2,1,2,maxTol,iter); 
printf("Valor biseccion f2 = %lf | Valor secante f2 = %lf\n\n", bisec2, secan2);

bisec3 = biseccion(f3,-1.5,-1,maxTol,iter);
secan3 = secante(f3,-1.5,-1,maxTol,iter); 
printf("Valor biseccion f3 = %lf | Valor secante f3 = %lf\n\n", bisec3, secan3);

bisec4 = biseccion(f4,0.5,1.5,maxTol,iter);
secan4 = secante(f4,0.5,2,maxTol,iter); 
printf("Valor biseccion f4 = %lf | Valor secante f4 = %lf\n\n", bisec4, secan4);

bisec5 = biseccion(f5,1,2,maxTol,iter);
secan5 = secante(f5,1,2,maxTol,iter); 
printf("Valor biseccion f5 = %lf | Valor secante f5 = %lf", bisec5, secan5);
