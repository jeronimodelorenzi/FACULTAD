//EJERCICIO 3 JERONIMO DELORENZI

/*a*/

function circ(r,x,y)
    
    plot2d(0,0,0,rect=[-10,-10,10,10],frameflag=3,axesflag=4);
    xarc(x-r,y+r,r*2,r*2,0,360*64);
    
endfunction

function Gersh(A)
    
    [nA,mA] = size(A);
    
    if (nA <> mA) then
       printf("Error - La matriz A debe ser cuadrada.");
       abort; 
    end
    
    for i = 1:nA
        
        centro = A(i,i);
        radio = sum(abs(A(i,:))) - abs(centro);
        
        circ(radio,centro,0); 
        
    end
    
endfunction

function CircGershValor(A)
    
    [nA,mA] = size(A);
    
    if (nA <> mA) then
       printf("Error - La matriz A debe ser cuadrada.");
       abort; 
    end
    
    autovalores = spec(A);
    disp(autovalores);
    
    Gersh(A);
    
    plot2d(real(autovalores), imag(autovalores), style=-9);
    
endfunction

A = [10 1 1 ; 1 4 2 ; 1 2 1];
CircGershValor(A);

/*b*/

/*Viendo el grafico del item a podemos ver que tenemos dos grupos disjuntos de circulos de Gershgorin donde uno contiene 2 yotro 1. Como es simetrica la matriz tendra autovalores reales por lo que podemos decir que dos autovalores se encontraran en el intervalo [-2,7] y otro en [8,12] de este ultimo podemos afirmar que la matriz tendra un autovalor dominante.*/

/*c*/

function [autovalor, zn] = metodoPotencia(A,z0,iter,tol)
    
    [nA,mA] = size(A);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");        
    end
    
    autovalor = 0;
    w = A*z0;
    zn = w / norm(w,%inf);
    [m, m_indice] = max(abs(w));
    autovalor = w(m_indice) / z0(m_indice);
    zn = w / autovalor;
    delta = norm(zn - z0,%inf);
    i = 1;
    
    while (delta > tol) && (i < iter)
        
        z0 = zn;
        w = A*z0;
        zn = w / norm(w,%inf);
        [m, m_indice] = max(abs(w));
        autovalor = w(m_indice) / z0(m_indice);
        zn = w / autovalor;
        
        delta = norm(zn - z0,%inf);
        i = i + 1;
        
    end
    
    printf("Cantidad de iteraciones Potencia: %d\n",i);
    
endfunction

A = [10 1 1 ; 1 4 2 ; 1 2 1];
z0_1 = [1;1;1];
tol = 1e-5;
iter = 1000
[autovalor1, zn1] = metodoPotencia(A,z0_1,iter,tol)
printf("Con z0 = [1;1;1] inicial, autovalor dominante:");
disp(autovalor1);
/*
Cantidad de iteraciones Potencia: 15
Con z0 = [1;1;1] inicial, autovalor dominante:
   10.355438
*/

A = [10 1 1 ; 1 4 2 ; 1 2 1];
z0_2 = [-0.462 ; -4.357 ; 8.989];
tol = 1e-5;
iter = 1000
[autovalor2, zn2] = metodoPotencia(A,z0_2,iter,tol)
printf("Con z0 = [-0.462;-4.357;8.989] autovalor dominante:");
disp(autovalor2);
/*
Cantidad de iteraciones Potencia: 16
Con z0 = [-0.462;-4.357;8.989] autovalor dominante:
   10.355389
*/

A = [10 1 1 ; 1 4 2 ; 1 2 1];
z0_3 = [0;100;1000];
tol = 1e-5;
iter = 1000
[autovalor3, zn3] = metodoPotencia(A,z0_3,iter,tol)
printf("Con z0 = [0;100;1000]; autovalor dominante:");
disp(autovalor3);
/*
Cantidad de iteraciones Potencia: 21
Con z0 = [0;100;1000]; autovalor dominante:
   10.355422
*/
