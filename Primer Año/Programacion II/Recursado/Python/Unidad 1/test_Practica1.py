from Practica1 import *
#Ejercicio 4

#a

def test_perimetro_rectangulo ():
    assert(perimetro_rectangulo(2,3) == 10)
    assert(perimetro_rectangulo(4,8) == 24)
    assert(perimetro_rectangulo(3,1) == 8)

#b
    
def test_area_rectangulo():
    assert(area_rectangulo(2,3) == 6)
    assert(area_rectangulo(4,8) == 32)
    assert(area_rectangulo(3,1) == 3)

#c

def test_calcular_base():
    assert(calcular_base(4,6) == 2) 
    assert(calcular_base(1,5) == 4) 
    assert(calcular_base(-3,0) == 3)

def test_calcular_altura():
    assert(calcular_altura(-5,-2) == 3) 
    assert(calcular_altura(4,12) == 8) 
    assert(calcular_altura(1,2) == 1)

def test_perimetro_area_xy():
    assert(perimetro_area_xy(4,6,-5,-2) == (10,6))
    assert(perimetro_area_xy(1,5,4,12) == (24,32))
    assert(perimetro_area_xy(-3,0,1,2) == (8,3))

#e

def test_area_circulo():
    assert(round(area_circulo(4),2) == 50.27)
    assert(round(area_circulo(7),3) == 153.938)
    assert(round(area_circulo(2),2) == 12.57)

#f

def test_volumen_esfera():
    assert(round(volumen_esfera(4),2) == 268.08)
    assert(round(volumen_esfera(7),2) == 1436.75)
    assert(round(volumen_esfera(2),2) == 33.51)

#g

def test_raiz_cuadrada():
    assert(raiz_cuadrada(4) == 2)
    assert(raiz_cuadrada(9) == 3)
    assert(raiz_cuadrada(16) == 4)

def test_calcular_hipotenusa():
    assert(calcular_hipotenusa(3,4) == 5)
    assert(calcular_hipotenusa(5,12) == 13)
    assert(calcular_hipotenusa(6,8) == 10)

#Ejercicio 6

def test_factorial():
    assert(factorial(4) == 24)
    assert(factorial(6) == 720)
    assert(factorial(7) == 5040)

#Ejercicio 7
    
#a
    
def test_suma():
    assert(suma(2,4) == 6)
    assert(suma(5,10) == 15)
    assert(suma(7,4) == 11)

def test_resta():
    assert(resta(2,4) == -2)
    assert(resta(5,10) == -5)
    assert(resta(7,4) == 3)

def test_multiplicacion():
    assert(multiplicacion(2,4) == 8)
    assert(multiplicacion(5,10) == 50)
    assert(multiplicacion(7,4) == 28)

def test_division():
    assert(division(2,4) == 0.5)
    assert(division(10,5) == 2)
    assert(division(7,4) == 1.75)

