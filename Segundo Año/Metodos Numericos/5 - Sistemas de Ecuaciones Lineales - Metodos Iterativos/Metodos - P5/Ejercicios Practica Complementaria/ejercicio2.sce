function R = cholesky(A)
    
    [nA, mA] = size(A);
    
    if (nA <> mA) then
        printf("Error - La matriz A debe ser cuadrada");
        abort;
    end
    
    eps = 1.0e-8;
    
    R = zeros(nA, nA);
    
    for k = 1:nA
        
        if (k == 1) then
            t = A(k,k);
        else
            t = A(k, k) - R(1:k-1, k)' * R(1:k-1, k);
        end
        
        
        if (t <= eps) then
            printf("Matriz no definida positiva");
            abort;
        end
        
        R(k, k) = sqrt(t);
        
        for j = k + 1:nA
            
            if(k == 1) then
                R(k,j) = A(k,j) / R(k,k);
            else
                R(k, j) = (A(k, j) - R(1:k-1, k)' * R(1:k-1, j)) / R(k, k);      
            end
           
        end
        
    end
    
endfunction

a = [0.1;0.1;0.1;0.1;0.1];
I = eye(5,5);
A = [1 a' ; a I];
// factorizacion 1
R = [0.9949874  -0.0100504  -0.0100504  -0.0100504  -0.0100504;0 0.9949367  -0.0101524  -0.0101524  -0.0101524;0 0 0.9948849  -0.0102565  -0.0102565;0 0 0 0.994832 -0.0103628; 0 0 0 0 0.994778];
zero = zeros(5,1);
A1 = [1 zero';a R'];
A2 = [1 a';zero R];
F1 = A1*A2;
// factorizacion 2
raiz = sqrt(1-a'*a);
A3 = [I zero;a' raiz];
A4 = [I a;zero' raiz];
F2 = A3*A4;
