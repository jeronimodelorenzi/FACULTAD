function r = raicesRobustas(p);
    
    a = coeff(p,2);
    b = coeff(p,1);
    c = coeff(p,0);
    
    disc = sqrt(b^2-4*a*c)
    
    if b < 0 then
        r1 = (2*c)/(-b + disc);
        r2 = (-b + disc)/(2*a);
    else
        r1 = (-b - disc)/(2*a);
        r2 = (2*c)/(-b-disc);
    end
    
endfunction

function r = misraices(p)
    
    c = coeff(p,0);
    b = coeff(p,1);
    a = coeff(p,2);
    r(1) = (-b + sqrt(b^2-4*a*c))/(2*a);
    r(2) = (-b - sqrt(b^2-4*a*c))/(2*a);
    
endfunction

p = poly([-0.0001 1/0.0001 0.0001],'x','coeff');
//--------------------------
roots1 = raicesRobustas(p);
r1 = roots1(1);

roots2 = roots(p);
r2 = roots2(1);

error1 = abs(r1 - r2);
//--------------------------
roots3 = misraices(p);
r3 = roots3(1);
error2 = abs(r1-r3);
//--------------------------
printf("Raices robustas: r1=%e , r2= %e\n",raicesRobustas(p)(1),raicesRobustas(p)(2));
printf("Raices resolvente: r1=%e , r2= %e\n",misraices(p)(1),misraices(p)(2));
printf("Error | Raices robustas - Roots: %e\n", error1);
printf("Error | Raices robustas - Resolvente: %e\n", error2);
