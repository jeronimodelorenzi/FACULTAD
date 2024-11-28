// Funciones

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
    coef =  res;
    err = norm(A*res-y');
    
endfunction

// Ejercicio 1

//a

V = [54.3 61.8 72.4 88.7 118.6 194.0]; // Volumen
P = [61.2 49.2 37.6 28.4 19.2 10.1]; // Presión


function A = crearMatriz(x)
    nX = length(x);
    A = ones(nX,1);
    A = [A, log(x)']
endfunction

A = crearMatriz(V)

printf("La matriz de Vandermonde para el ejercicio es: ");
disp(A);
/*
La matriz de Vandermonde para el ejercicio es: 
   1.   3.9945242
   1.   4.1239034
   1.   4.2822063
   1.   4.4852599
   1.   4.7757565
   1.   5.2678582
*/

logP = log(P)

[coef,err] = minimosCuadrados(A,logP)

printf("Coeficientes obtenidos:");
disp(coef);

/*
Coeficientes obtenidos:
   9.6686067
  -1.4022076
*/

/*
Entonces definimos ln(C) = 9.6686067 sii C = e^9.6686067 sii C = 15813.301
-alpha = -1.4022076 sii alpha = 1.4022076
*/

C = 15813.301;
alpha = 1.4022076;

//b (despeje en hoja)
function y = P_ev(V)
    
    y = C./V.^alpha;
    
endfunction

//c
P_ev100 = P_ev(100);
printf("Estimacion de P cuando V = 100 pulg^3: %lf\n",P_ev100);

/*
Estimacion de P cuando V = 100 pulg^3: 24.808890
*/

//d 
rango = 50:0.01:200
plot2d(rango', P_ev(rango'),[3],leg="PV^alpha = C");
plot2d(V,P',-1);
