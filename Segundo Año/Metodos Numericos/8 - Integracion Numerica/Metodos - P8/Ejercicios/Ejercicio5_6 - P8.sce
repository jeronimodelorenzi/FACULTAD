function I = metodoTrapecioBidimensional(f, a, b, c, d, n, m)
    
    hx = (b - a) / n; 
    I=0;
    
    for i = 0:n
        xi = a + i * hx; 
        y1 = c(xi);      
        y2 = d(xi);      

        hy = (y2 - y1) / m;

        I_y = (f(xi, y1) + f(xi, y2)) / 2;
        for j = 1:m-1
            yj = y1 + j * hy;
            I_y = I_y + f(xi, yj);
        end

        I = I + hy * I_y;
    end

    // Escalar con hx
    I = I * hx;
endfunction

function z = f1(x,y)
    z = sin(x+y);
endfunction

function y = d1(x)
    y = 1;
endfunction

function y = c1(x)
    y = 0
endfunction

//-----------------

function z = f2(x,y)
    z = 1;
endfunction

function y = d2(x)
    y = sqrt(2*x-x^2);
endfunction

function y = c2(x)
    y = -sqrt(2*x-x^2);
endfunction

//-----------------

I1 = metodoTrapecioBidimensional(f1,0,2,c1,d1,2,2);
printf("El resultado de la integral ej5 es: %lf\n",I1);

I2 = metodoTrapecioBidimensional(f2,0,2,c2,d2,1000,1000);
printf("El resultado de la integral ej6 es: %lf\n",I2);
printf("El error que hay entre la integral y el numero pi es: %lf",%pi-I2);
