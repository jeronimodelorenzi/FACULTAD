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
    
    printf("Cantidad de iteraciones: %d\n",i);
    
endfunction

/*A2 = [12 1 3 4; 1 -3 1 5; 3 1 6 -2; 4 5 -2 -1];
A1 = [6 4 4 1 ; 4 6 1 4 ; 4 1 6 4 ; 1 4 4 6];
z = [1;1;1;1];
eps = 10e-6;
maxiter = 100;

[autovalor1, autovector1] = metodoPotencia(A1, z, maxiter, eps);
disp("Autovalor 1:");
disp(autovalor1);

disp("A*v;");
disp(A1*autovector1);

disp("lambda*v:");
disp(autovalor1*autovector1);

verif1 = (A1 - autovalor1*eye(4,4))*autovector1;
disp("(A - lambda*I)*v = 0");
disp(verif1);

//--------------------//

[autovalor2, autovector2] = metodoPotencia(A2, z, maxiter, eps);
disp("Autovalor 2:");
disp(autovalor2);

disp("A*v;");
disp(A2*autovector2);

disp("lambda*v:");
disp(autovalor2*autovector2);

verif2 = (A2 - autovalor2*eye(4,4))*autovector2;
disp("(A - lambda*I)*v = 0");
disp(verif2);*/

A = [9 1 -2 1 ; 0 8 1 1 ; -1 0 7 0 ; 1 0 0 1];
z01 = [3;3;3;3];
z02 = [1;1;1;1];
iter = 100;
tol = 1e-5;

[autovalor1,autovector1] = metodoPotencia(A,z01,iter,tol);
disp(autovalor1);
disp(autovector1);
printf("//--------------//");
[autovalor2,autovector2] = metodoPotencia(A,z02,iter,tol);
disp(autovalor2);
disp(autovector2);


