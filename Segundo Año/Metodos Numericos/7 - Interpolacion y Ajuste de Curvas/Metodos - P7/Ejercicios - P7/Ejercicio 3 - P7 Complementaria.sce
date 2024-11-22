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
    
    [A_aum,res] = gaussPivoteo(A'*A,A'*y');
    px = poly(res,'x','coeff');
    err = norm(A*res-y');
    
endfunction

x = [1 2 3 4 5 6 7 8 9 10 11 12];

y_2021 = [145.61 151.12 157.27 164.72 172.29 182.91 185.12 188.62 190.09 197.99 204.32 207.97]

y_2022 = [209.92 225.82 265.71 295.24 301.62 311.80 327.39 343.10 366.54 385.20 407.77 428.42]

// 2021

[A1,p2_2021,err1_2021] = minimosCuadrados(x,y_2021,2);
[A2,p3_2021,err2_2021] = minimosCuadrados(x,y_2021,3);

// 2022

[A3,p2_2022,err1_2022] = minimosCuadrados(x,y_2022,2);
[A4,p3_2022,err2_2022] = minimosCuadrados(x,y_2022,3);
printf("Polinomios 2021:\n");
printf("Cuadratico:\n");
disp(p2_2021);
printf("Cubico:\n")
disp(p3_2021);
printf("Polinomios 2022:\n");
printf("Cuadratico:\n");
disp(p2_2022);
printf("Cubico:\n")
disp(p3_2022);

// Errores

printf("Errores 2021 | Error cuadratico: %lf | Error cubico: %lf\n",err1_2021,err2_2021);
printf("Errores 2022 | Error cuadratico: %lf | Error cubico: %lf\n",err1_2022,err2_2022);

// Ploteo

subplot(221);
rango = 1:0.1:13
plot2d(rango,[horner(p2_2021,rango')],2);
plot2d(x,y_2021,-1);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Polinomio cuadratico 2021");

subplot(222);
rango = 1:0.1:13
plot2d(rango,[horner(p3_2021,rango')],3);
plot2d(x,y_2021,-1);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Polinomio cubico 2021");

subplot(223);
rango = 1:0.1:13
plot2d(rango,[horner(p2_2022,rango')],4);
plot2d(x,y_2022,-1);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Polinomio cuadratico 2022");

subplot(224);
rango = 1:0.1:13
plot2d(rango,[horner(p3_2022,rango')],2);
plot2d(x,y_2022,-1);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
title("Polinomio cubico 2022");

/*
En ambos casos la aproximacion que mas se ajusta es la cubica.
Podemos concluir que el precio del pan tuvo una subida bastante grande de 2021 a 2022.
Esto lo podemos concluir viendo la relacion que tuvo la mejor aproximacion, es este caso la cubica.
*/


