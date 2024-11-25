// rango = ...

function graficar(rango)

    // Si queremos graficar mas plots usamos subplot

    //subplot(221);
    plot2d(rango',[], [], leg="");
    plot2d(x,y_min',-1);  // forma de 
    a = gca();
    a.x_location = "origin";
    a.y_location = "origin";
    title("Polinomios min");
    
    /*subplot(222);
    plot2d(rango',[horner(p3_max,rango') horner(p5_max,rango') horner(p7_max,rango')horner(p9_max,rango')], [2,3,4,5], leg="p3(x)@p5(x)@p7(x)@p9(x)");
    plot2d(x,y_max',-1);
    a = gca();
    a.x_location = "origin";
    a.y_location = "origin";
    title("Polinomios max");
    
    subplot(223);
    plot2d(rango',[horner(p3_minQR,rango') horner(p5_minQR,rango') horner(p7_minQR,rango')horner(p9_minQR,rango')], [2,3,4,5], leg="p3(x)@p5(x)@p7(x)@p9(x)");
    plot2d(x,y_min',-1);
    a = gca();
    a.x_location = "origin";
    a.y_location = "origin";
    title("Polinomios minQR");
    
    subplot(224);
    plot2d(rango',[horner(p3_maxQR,rango') horner(p5_maxQR,rango') horner(p7_maxQR,rango')horner(p9_maxQR,rango')], [2,3,4,5], leg="p3(x)@p5(x)@p7(x)@p9(x)");
    plot2d(x,y_max',-1);
    a = gca();
    a.x_location = "origin";
    a.y_location = "origin";
    title("");*/
endfunction
