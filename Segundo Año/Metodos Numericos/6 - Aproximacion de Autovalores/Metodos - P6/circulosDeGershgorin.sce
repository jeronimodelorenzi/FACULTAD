function circ(r,x,y)
    
    plot2d(0,0,0,rect=[-10,-10,10,10],frameflag=3,axesflag=5);
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
