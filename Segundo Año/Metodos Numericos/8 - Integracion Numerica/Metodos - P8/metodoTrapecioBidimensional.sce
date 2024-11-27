function I = DobleTrapecio(f, a, b, c, d, n, m)

    hx = (b - a) / n; // Paso en x
    I=0;
    // Iterar sobre subintervalos de x
    for i = 0:n
        xi = a + i * hx; // Punto en x
        y1 = c(xi);      // Límite inferior en y
        y2 = d(xi);      // Límite superior en y
        
        // Paso en y
        hy = (y2 - y1) / m;

        // Regla del trapecio sobre y
        I_y = (f(xi, y1) + f(xi, y2)) / 2;
        for j = 1:m-1
            yj = y1 + j * hy;
            I_y = I_y + f(xi, yj);
        end

        I = I + hy * I_y; // Agregar contribución del subintervalo
    end

    // Escalar con hx
    I = I * hx;
endfunction
