function [A_aum , x] = gaussPivoteo(A,b)
    
    [nA,mA] = size(A); // tamaño de A
    [nB,mB] = size(b); // tamaño de b
    
    if(nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
    elseif(mA <> nB) then
        printf("Error - Incompatibilidad entre A y b");    
    end
    
    A_aum = [A b]; // matriz aumentada
    
    
    // Gauss
    for k = 1:nA-1 // columna
        
        k_pivot = k; // suponemos posicion del pivote maximo
        max_pivot = abs(A_aum(k,k)); // suponemos valor del pivote maximo
        
        for i = k+1:nA // fila
            
            if(abs(A_aum(i,k)) > max_pivot) then
                k_pivot = i; // cambiamos la posicion del pivote maximo
                max_pivot = abs(A_aum(i,k)); // cambiamos el valor del pivote maximo
            end
            
        end
        
        //intercambio de filas
        temp = A_aum(k_pivot,:); // variable temporal para cambiar la fila
        A_aum(k_pivot,:) = A_aum(k,:); //cambiamos la fila donde esta el pivote maximo por la fila donde esta el 0
        A_aum(k,:) = temp; // cambiamos la fila donde esta el 0 por la fila donde esta el pivote maximo
        
        
        for i = k+1:nA // fila
            
            mik = A_aum(i,k)/A_aum(k,k);
            A_aum(i,k) = 0;
            A_aum(i,k+1:nA+1) = A_aum(i,k+1:nA+1) - mik*A_aum(k,k+1:nA+1);
       
       end
    end
    
    
    // Sustitucion regresiva
    x(nA) = A_aum(nA,nA+1)/A_aum(nA,nA);
    
    for k = nA-1:-1:1
        x(k) = (A_aum(k,nA+1) - A_aum(k,k+1:nA)*x(k+1:nA))/A_aum(k,k);
    end
    
endfunction

/*
Sea f(x,v) = a+bx+cv, queremos encotrar las constantes a,b,c.
Definamos ø1(x,v) = 1 ; ø2(x,v) = x ; ø3(x,v) = v
Entonces tenemos x = [a b c]' como el vector con las componentes que 
queremos encontrar. La matriz esta dada por 
A = [ø1(x0,v0) ø2(x0,v0) ø3(x0,v0)]
    [ø1(x1,v1) ø2(x1,v1) ø3(x1,v1)]
    [...         ...         ...  ]
    [ø1(xn,vn) ø2(xn,vn) ø3(xn,vn)]
    
Quedando, A = [ 1   x0  v0 ]
              [ 1   x1  v1 ]
              [ ... ... ...]
              [ 1   xn  vn ]
*/

x = [0 0 1 2 2 2];
v = [0 1 0 0 1 2];

// Creemos la matriz

function A = crearMatriz(x,v)
    
    nX = length(x);
    
    A = ones(nX,1);
    
    for i=1:nX
        A(i,2) = x(i);
        A(i,3) = v(i);
    end
      
endfunction

A = crearMatriz(x,v);

y = [1.42 1.85 0.78 0.18 0.60 1.05];

function [px,err] = minimosCuadrados(A,y)
    
    [A_aum,res] = gaussPivoteo(A'*A,A'*y');
    px = poly(res,'x','coeff');
    err = norm(A*res-y');
    
endfunction

[pxv,err] = minimosCuadrados(A,y);

/*
Obtuvimos el polinomio px 1.4132558 -0.6213953x +0.4375581x^2
donde a = 1.4132558, b = -0.6213953x, c = 0.4375581.
Luego nos queda f(x,v) = 1.4132558 - 0.6213953*x + 0.4375581*v
*/

function z = f(x,v)
    
    z = 1.4132558 - 0.6213953.*x + 0.4375581.*v;
    
endfunction

rango = -3:0.1:3

set(gca(),"auto_clear","off");
a = gca();
a.x_location = "origin";
a.y_location = "origin";
[xx, vv] = ndgrid(rango, rango);

plot3d(rango, rango, f(xx,vv),flag=[5,6,3]);

scatter3(x,v,y,'fill');
