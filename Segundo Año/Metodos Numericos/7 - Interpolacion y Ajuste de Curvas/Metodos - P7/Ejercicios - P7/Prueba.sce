// Método de Eliminación Gaussiana con pivoteo parcial
function [x,a] = gausselimPP(A,b)
[nA,mA] = size(A) 
[nb,mb] = size(b)
a = [A b];
n = nA;

for k=1:n-1
    kpivot = k; amax = abs(a(k,k));
    for i=k+1:n
        if abs(a(i,k))>amax then
            kpivot = i; amax = a(i,k);
        end;
    end;
    temp = a(kpivot,:); a(kpivot,:) = a(k,:);
    a(k,:) = temp
    
    for i=k+1:n
        for j=k+1:n+1
            a(i,j) = a(i,j) - a(k,j)*a(i,k)/a(k,k)
        end;
        for j=1:k
            a(i,j) = 0;
        end
    end
end

x(n) = a(n,n+1)/a(n,n)

for i = n-1:-1:1
    sumk = 0
    for k=i+1:n
        sumk = sumk + a(i,k)*x(k)
    end
    x(i) = (a(i,n+1)-sumk)/a(i,i)
end

endfunction

// f(x) = a1*e^x + a2*cos(x)

x1 = 0
y1 = 1
x2 = 1
y2 = 4

/*A_ec = [
    %e^x1 cos(x1);
    %e^x2 cos(x2)
]*/

A_ec = [x1^2 cos(x1);x2^2 cos(x2)]
b_ec = [y1; y2]

[w,amp] = gausselimPP(A_ec,b_ec)

/*function y = mc_ec(x)
    y = w(1)*%e.^x + w(2)*cos(x)
endfunction*/

function y = mc_ec(x)
    y = w(1)*x^2 + w(2)*cos(x)
endfunction

xx=-1:0.001:2
x = [x1;x2]
plot2d(x,b_ec,-1)
plot2d(xx',[xx'.^2,cos(xx'),mc_ec(xx')],[2,3,4],leg="p1(x)@p2(x)@p8(x)")
