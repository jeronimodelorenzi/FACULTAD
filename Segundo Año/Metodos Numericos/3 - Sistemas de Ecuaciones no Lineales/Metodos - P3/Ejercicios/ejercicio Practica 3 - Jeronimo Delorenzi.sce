rango = 0:0.01:5

function y = g2(x)
    y = (2*x-1)^(1/3);
endfunction

x = (2*x-1)^(1/3);
x^3 = (2*x-1)
x^3 - 2x+1

x^3 - 2x+1 = 0
-2x + 1 = x^3

plot2d(rango', g2(rango'),3);
a = gca();
a.x_location = "origin";
a.y_location = "origin";
