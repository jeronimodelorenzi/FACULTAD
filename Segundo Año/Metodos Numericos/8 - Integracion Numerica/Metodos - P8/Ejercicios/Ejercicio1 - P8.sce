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

err1_trapecio = I1_real - I1_trapecio;
err2_trapecio = I2_real - I2_trapecio;
err3_trapecio = I3_real - I3_trapecio;

err1_simpson = I1_real - I1_simpson;
err2_simpson = I2_real - I2_simpson;
err3_simpson = I3_real - I3_simpson;


printf("Integrales trapecio | integral de ln(x) entre 1 a 2 = %lf | integral de x^(1/3) entre 0 a 0.1 = %lf  | integral de sin(x)^2 entre 0 a pi/3 = %lf\n", I1_trapecio,I2_trapecio,I3_trapecio);

printf("Integrales Simpson | integral de ln(x) entre 1 a 2 = %lf | integral de x^(1/3) entre 0 a 0.1 = %lf  | integral de sin(x)^2 entre 0 a pi/3 = %lf\n", I1_simpson,I2_simpson,I3_simpson);

printf("Integrales exactas | integral de ln(x) entre 1 a 2 = %lf | integral de x^(1/3) entre 0 a 0.1 = %lf  | integral de sin(x)^2 entre 0 a pi/3 = %lf\n", I1_real,I2_real,I3_real);

printf("Errores int real - trapecio | error integral de ln(x) entre 1 a 2 = %lf | error integral de x^(1/3) entre 0 a 0.1 = %lf  | error integral de sin(x)^2 entre 0 a pi/3 = %lf\n",err1_trapecio,err2_trapecio,err3_trapecio);

printf("Errores int real - simpson | error integral de ln(x) entre 1 a 2 = %lf | error integral de x^(1/3) entre 0 a 0.1 = %lf  | error integral de sin(x)^2 entre 0 a pi/3 = %lf\n",err1_simpson,err2_simpson,err3_simpson);


/*
Queremos encontrar una cota del error para la integracion numerica trapezoidal y de Simpson. Primero vamos con la trapezoidal.
Sabemos que la formula del error es E_n(f) = (int de a a b f(x))- T_n(f) = -h^3/12 * f''(c), c ∈ [a,b];

Entonces vamos con |int de 1 a 2 ln(x) - Tn| = h^3/12 * |f''(c)| = 1/12 * |-1/c^2| = 1/12 * |1/c^2| = 1/12 *
                        (i)
1/|c^2| = 1/12 * 1/c^2  <= 1/12 * 1/1 = 1/12
(i) Dado a que la funcion 1/x^2 es decreciente y continua en el intervalo [1,2] podemos acotarla por el
maximo, que es 1.

f'(x) = 1/x ; f''(x) = -1/x^2

----------------

|int de 0 a 0.1 x^(1/3) - Tn| = h^3/12 * |-2/(9*c^(5/3))| = (0.1)^3/12 * 2/|(9*x^(5/3))| = 
                           (i)
1/12000 * 2/(9*|x^(5/3)|)  <= 1/12000 * 2/(9*|0.01^(5/3)|) = 1/12000 * 2/0.0041778 = 1/12000 * 478.72086 =
0.0398934.

(i) Dado a que la funcion 2/(9*|x^(5/3)|) es decreciente en el intervalo (0,0.1]. Como en 0 no esta
definida, tomamos un valor cercano a 0 para acotarla, en este caso tomemos 0.01

f'(x) = 1/3x^(-2/3) ; f''(x) = -2/9*x^(-5/3) = -2/(9*x^(5/3))

----------------

|int de 0 a pi/3 sen^2(x) - Tn| = h^3/12 * 2*|cos(2c)| =  (pi^3/27)/12 * 2 |cos(2x)| = pi^3/162 * |cos(2c)|
<= pi^3/162 * 1 = pi^3/162

f'(x) = 2sen(x)cos(x) = sen(2x) ; f''(x) = cos(2x)*2

---------------- 

Ahora vamos con el error de Simpson:
Sabemos que la formula del error es E_n(f) = (int de a a b f(x))- S_n(f) = -h^5/90 * f^(4)(c), c ∈ [a,b];

|int de 1 a 2 ln(x) - Sn| = h^5/90 * |f^(4)(c)| = 1/90 * |-6/x^4| = 1/90 * |6/x^4| = 1/90 * 6/|x^4|
                (i)
= 1/90 * 6/x^4  <= 1/90 * 6/1 = 1/15
(i) Dado a que la funcion 6/x^4 es decreciente y continua en el intervalo [1,2] podemos acotarla por el
maximo, que es 1.

f'(x) = 1/x ; f''(x) = -1/x^2 ; f'''(x) = -x^(-2) = 2*x^(-3) ; f^(4)(x) = -6x^(-4) = -6/x^4

----------------

|int de 0 a 0.1 x^(1/3) - Sn| = h^5/90 * |-80/(81*x^(11/3))| = (0.1)^5/90 * 80/|81*x^(11/3)| = 
                              (i)
1/9000000 * 80/81*|x^(11/3)|  <= 1/9000000 * 80/(81*0.01^(11/3)) = 1/9000000 * 21278367 = 2.364263

(i) Dado a que la funcion 80/81*|x^(11/3)| es decreciente en el intervalo (0,0.1]. Como en 0 no esta
definida, tomamos un valor cercano a 0 para acotarla, en este caso tomemos 0.01

f'(x) = 1/3x^(-2/3) ; f''(x) = -2/9*x^(-5/3) ; f'''(x) = 10/27*x^(-8/3) ; f^(4)(x) = -80/81*x^(-11/3)
= -80/(81*x^(11/3))

----------------

|int de 0 a pi/3 sen^2(x) - Sn| = h^5/90 * 8*|cos(2x)| =  (pi^5/243)/90 * 8 |cos(2x)| = 
4*pi^5/10935 * |cos(2c)| <= 4*pi^5/10935 * 1 = 4*pi^5/10935

f'(x) = 2sen(x)cos(x) = sen(2x) ; f''(x) = cos(2x)*2 ; f'''(x) = -sen(2x)*4 ; f^(4)(x) = -cos(2x)*8
*/

