function I = metodoTrapecio(fun,a,b) 
    
    if (a>b) then
        temp = a;
        a = b
        b = temp;
    end
    
    //deff("y=f(x)","y="+fun); 
    
    h = b-a
    I = h/2*(fun(a)+fun(b));
    
endfunction

function I = metodoSimpson(fun,a,b) 
    
    if (a>b) then
        temp = a;
        a = b
        b = temp;
    end
    
    //deff("y=f(x)","y="+fun);
    
    h = (b-a)/2;
    x1 = a+h;
    I = h/3*(fun(a)+4*fun(x1)+fun(b));
    
endfunction

function y = f1(x)
    y = log(x);
endfunction

function y = f2(x)
    y = x^(1/3);
endfunction

function y = f3(x)
    y = sin(x)^2;
endfunction

I1_trapecio = metodoTrapecio(f1,1,2);
I2_trapecio = metodoTrapecio(f2,0,0.1);
I3_trapecio = metodoTrapecio(f3,0,%pi/3);

I1_simpson = metodoSimpson(f1,1,2);
I2_simpson = metodoSimpson(f2,0,0.1);
I3_simpson = metodoSimpson(f3,0,%pi/3);

I1_real = intg(1,2,f1);
I2_real = intg(0,0.1,f2);
I3_real = intg(0,%pi/3,f3);

printf("Integrales trapecio | integral de ln(x) entre 1 a 2 = %lf | integral de x^(1/3) entre 0 a 0.1 = %lf  | integral de sin(x)^2 entre 0 a pi/3 = %lf\n", I1_trapecio,I2_trapecio,I3_trapecio);

printf("Integrales Simpson | integral de ln(x) entre 1 a 2 = %lf | integral de x^(1/3) entre 0 a 0.1 = %lf  | integral de sin(x)^2 entre 0 a pi/3 = %lf\n", I1_simpson,I2_simpson,I3_simpson);

printf("Integrales exactas | integral de ln(x) entre 1 a 2 = %lf | integral de x^(1/3) entre 0 a 0.1 = %lf  | integral de sin(x)^2 entre 0 a pi/3 = %lf\n", I1_real,I2_real,I3_real);


