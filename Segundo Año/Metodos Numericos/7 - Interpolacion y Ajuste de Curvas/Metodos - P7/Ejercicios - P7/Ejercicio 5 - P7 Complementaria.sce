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

function [coef,err] = minimosCuadrados(A,y)

    [A_aum,res] = gaussPivoteo(A'*A,A'*y');
    coef = res;
    err = norm(A*res-y');
    
endfunction

// ------------------------------------------------------------------

tita1 = 13129.3;

/*
g(t) = tita1*e^(-tita2*e^(-tita3*t)) =>
ln(g(t)) = ln(tita1*e^(-tita2*e^(-tita3*t))) =>
ln(g(t)) = ln(tita1)*ln(e^(-tita2*e^(-tita3*t))) =>
ln(g(t)) = ln(tita1) * (-tita2*e^(-tita3*t)) * ln(e) =>
ln(g(t)) = ln(tita1) * (-tita2*e^(-tita3*t)) =>
ln(g(t)) - ln(tita1) = -tita2*e^(-tita3*t) =>
-ln(g(t)/tita1) = tita2*e^(-tita3*t) =>
ln(-ln(g(t)/tita1) = ln(tita2*e^(-tita3*t)) =>
ln(ln(tita1/g(t)) = ln(tita2) + ln(e^(-tita3*t)) =>
ln(ln(tita1/g(t)) = ln(tita2) + (-tita3*t)*ln(e) =>
ln(ln(tita1/g(t)) = ln(tita2) + (-tita3*t)

Sea a1 = ln(tita2) => e^a1 = tita2 y a2 = -tita3 => -a2 = tita3.
Definimos ø1 = 1 y ø2 = t;
*/

x = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30];
yy = [35, 23, 47, 59, 82, 113, 143, 179, 233, 269, 303, 335, 371, 404, 434, 446, 457, 470, 481, 482, 476, 465, 454, 436, 424, 397, 385, 359, 340, 322, 303];


y = [35];
for i = 2:length(yy)
    y(i) = y(i-1)+yy(i);
end

function A = crearMatriz(x)
    
    nX = length(x);
    A = ones(nX,1);
    for i = 1:nX
        A(i,2) = x(i);
    end
    
endfunction

A = crearMatriz(x);

y_2 = log(log(tita1./y'));

[coef,err] = minimosCuadrados(A,y_2);


/*
Obtuvimos los coeficientes 1.7775332 y -0.0994176 donde
a1 = 1.7775332 y a2 = -0.0994176, luego
1.7775332 = ln(tita2) => e^1.7775332 = tita2 => 5.9152464 = tita2.
-0.0994176 = -tita3 => 0.0994176 = tita3.
*/

//Definimos g(t)

tita2 = 5.9152464;
tita3 = 0.0994176;

function z = g(t)
    
    z = tita1*%e^(-tita2*%e^(-tita3.*t));
    
endfunction

rango = 0:0.001:31

plot2d(rango', g(rango'), 2);
plot2d(x,y,-1);
