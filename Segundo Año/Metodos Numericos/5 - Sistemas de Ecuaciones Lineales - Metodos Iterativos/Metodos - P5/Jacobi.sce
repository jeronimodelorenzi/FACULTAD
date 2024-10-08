//Jacobi
//xi^{k+1} = 1/aii * (bi - sum_{j=1,j/=i}^{n} aij xj^{k})

function x = metodoJacobi(A,b,x0,eps)
    
    nA = size(A,1);
    cont = 0;
    x = x0;
    xk = x;
    
    for i = 1:nA
        
      suma = 0;
      
      for j = 1:nA  
      
        if(j<>i) then
           suma = suma + A(i,j)*xk(j);
        end
      
      end  
        
       x(i) = 1/A(i,i)*(b(i) - suma); 
        
    end
    
    cont = cont + 1;
    
    while ((norm(x-xk))>eps)
        
        xk = x;
    
        for i = 1:nA
        
            suma = 0;
      
            for j = 1:nA  
      
                if(j<>i) then
                    suma = suma + A(i,j)*xk(j);
                end
      
            end  
        
            x(i) = 1/A(i,i)*(b(i) - suma); 
        
        end
        
        cont = cont + 1;
        
    end
        
    disp(cont);
    
endfunction
