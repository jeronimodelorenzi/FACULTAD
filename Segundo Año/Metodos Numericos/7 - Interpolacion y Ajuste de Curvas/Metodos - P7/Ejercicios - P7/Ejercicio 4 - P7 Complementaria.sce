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

function [A,px,err] = minimosCuadrados(x,y,grado)
    
    nY = length(y);
    mX = length(x);
    
    if(mX <> nY) then
        error("Los tamaños de x e y deben ser iguales.");
    end
    
    A = ones(mX,1);
    
    for j = 2:grado+1
        A = [A,(x').^(j-1)];
    end
    
    
    
    [A_aum,res] = gaussPivoteo(inv(A'*A),A'*y');
    px = poly(res,'x','coeff');
    err = norm(A*res-y');
    
endfunction

function [Q,R] = factorizacionQR(A)
    
    [m,n] = size(A);
    

    if rank(A) <> n  then
        error("factorizacionQR - El rango de la matriz no es n");
    end

    Q = zeros(m,n);
    R = zeros(n,n);
    
    for k = 1 : n // Iteramos por las columnas de la matriz
        
        vectorProyectado = A(1:m, k);
        
        for i = 1 : k - 1 
            
            R(i,k) = A(1:m, k)' * Q(1:m, i);
            
            vectorProyectado = vectorProyectado - R(i,k) * Q(1:m, i);
        end
        
        Q(1:m, k) = vectorProyectado / norm(vectorProyectado);

        R(k,k) = norm(vectorProyectado);

        
    end
    
endfunction

function x = triangularSuperior(A,b)
    
    [nA,mA] = size(A);

    x(nA) = b(nA)/A(nA,nA);
    
    for i=nA-1:-1:1
        x(i)= (b(i) - A(i,i+1:nA)*x(i+1:nA))/A(i,i); // A(i,i+1:n) fila i columna i+1 a n
    end
    
endfunction

function [A,px,err] = minimosCuadradosQR(x,y,grado)
    
    nY = length(y);
    mX = length(x);
    
    if(mX <> nY) then
        error("Los tamaños de x e y deben ser iguales.");
    end
    
    A = ones(mX,1);
    
    for j = 2:grado+1
        A = [A,(x').^(j-1)];
    end
    
    [Q,R] = factorizacionQR(A);
    res = triangularSuperior(R,Q'*y');
    px = poly(res,'x','coeff');
    err = norm(A*res-y');
    
endfunction

//---------------------------------------------------------------------

// a

x = [1 2 3 4 5 6 7 8 9 10];
y_min = [32.9 30.8 26.4 24.2 19.2 16.5 19.3 21 23 26.2];
y_max = [19.5 15.5 13.1 9.8 5.7 2.2 5.3 4.7 6 10.5];

// Polinomios y_min

[A1_min,p3_min,err1_min] = minimosCuadrados(x,y_min,3);
[A2_min,p5_min,err2_min] = minimosCuadrados(x,y_min,5);
[A3_min,p7_min,err3_min] = minimosCuadrados(x,y_min,7);
[A4_min,p9_min,err4_min] = minimosCuadrados(x,y_min,9);

printf("Polinomios min\n");
printf("Grado 3:");
disp(p3_min);
printf("Grado 5:");
disp(p5_min);
printf("Grado 7:");
disp(p7_min);
printf("Grado 9:");
disp(p9_min);

// Polinomios y_max

[A1_max,p3_max,err1_max] = minimosCuadrados(x,y_max,3);
[A2_max,p5_max,err2_max] = minimosCuadrados(x,y_max,5);
[A3_max,p7_max,err3_max] = minimosCuadrados(x,y_max,7);
[A4_max,p9_max,err4_max] = minimosCuadrados(x,y_max,9);

printf("Polinomios max\n");
printf("Grado 3:");
disp(p3_max);
printf("Grado 5:");
disp(p5_max);
printf("Grado 7:");
disp(p7_max);
printf("Grado 9:");
disp(p9_max);

rango = 1:0.1:10;

subplot(221);
plot2d(rango',[horner(p3_min,rango') horner(p5_min,rango') horner(p7_min,rango')horner(p9_min,rango')], [2,3,4,5], leg="p3(x)@p5(x)@p7(x)@p9(x)");
plot2d(x,y_min',-1);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Polinomios min");

subplot(222);
plot2d(rango',[horner(p3_max,rango') horner(p5_max,rango') horner(p7_max,rango')horner(p9_max,rango')], [2,3,4,5], leg="p3(x)@p5(x)@p7(x)@p9(x)");
plot2d(x,y_max',-1);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Polinomios max");

// b

[A1_minQR,p3_minQR,err1_minQR] = minimosCuadradosQR(x,y_min,3);
[A2_minQR,p5_minQR,err2_minQR] = minimosCuadradosQR(x,y_min,5);
[A3_minQR,p7_minQR,err3_minQR] = minimosCuadradosQR(x,y_min,7);
[A4_minQR,p9_minQR,err4_minQR] = minimosCuadradosQR(x,y_min,9);

printf("Polinomios min QR\n");
printf("Grado 3:");
disp(p3_minQR);
printf("Grado 5:");
disp(p5_minQR);
printf("Grado 7:");
disp(p7_minQR);
printf("Grado 9:");
disp(p9_minQR);

// Polinomios y_max

[A1_maxQR,p3_maxQR,err1_maxQR] = minimosCuadradosQR(x,y_max,3);
[A2_maxQR,p5_maxQR,err2_maxQR] = minimosCuadradosQR(x,y_max,5);
[A3_maxQR,p7_maxQR,err3_maxQR] = minimosCuadradosQR(x,y_max,7);
[A4_maxQR,p9_maxQR,err4_maxQR] = minimosCuadradosQR(x,y_max,9);

printf("Polinomios max QR\n");
printf("Grado 3:");
disp(p3_maxQR);
printf("Grado 5:");
disp(p5_maxQR);
printf("Grado 7:");
disp(p7_maxQR);
printf("Grado 9:");
disp(p9_maxQR);

//Errores

printf("Errores QR min | error p3 = %lf | error p5 = %lf | error p7 = %lf | error p9 = %lf \n",err1_minQR,err2_minQR,err3_minQR,err4_minQR);
printf("Errores QR max | error p3 = %lf | error p5 = %lf | error p7 = %lf | error p9 = %lf \n",err1_maxQR,err2_maxQR,err3_maxQR,err4_maxQR);

subplot(223);
plot2d(rango',[horner(p3_minQR,rango') horner(p5_minQR,rango') horner(p7_minQR,rango')horner(p9_minQR,rango')], [2,3,4,5], leg="p3(x)@p5(x)@p7(x)@p9(x)");
plot2d(x,y_min',-1);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Polinomios minQR");

subplot(224);
plot2d(rango',[horner(p3_maxQR,rango') horner(p5_maxQR,rango') horner(p7_maxQR,rango')horner(p9_maxQR,rango')], [2,3,4,5], leg="p3(x)@p5(x)@p7(x)@p9(x)");
plot2d(x,y_max',-1);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Polinomios maxQR");

/*
La discrepancia que hay entre el los polimios obtenidos entre el item a y el b
es que los que obtuvimos en el item a son polinomios casi nulos ya que la matri
de Vandermonde esta mal condicionada, es decir, su determinante tiende a 0,
entonces, al realizar la inversa, tendremos errores. En cambio con la factorizacion QR...
*/






