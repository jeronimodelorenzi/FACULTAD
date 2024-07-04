#----------------------------------------------------------------------------------
#Entrega del Ejercicio 7 de la practica 1 Python.
#Jeronimo Delorenzi
#----------------------------------------------------------------------------------

#a

'''
suma: float float -> float
Dados dos numeros, retorna la suma entre ellos.
'''
def test_suma():
    assert(suma(2,4) == 6)
    assert(suma(5,10) == 15)
    assert(suma(7,4) == 11)

def suma(n1,n2):
    return n1 + n2

'''
resta: float float -> float
Dados dos numeros, retorna la resta entre ellos.
'''

def test_resta():
    assert(resta(2,4) == -2)
    assert(resta(5,10) == -5)
    assert(resta(7,4) == 3)

def resta(n1,n2):
    return n1 - n2

'''
multiplicacion: float float -> float
Dados dos numeros, retorna el producti entre ellos.
'''

def test_multiplicacion():
    assert(multiplicacion(2,4) == 8)
    assert(multiplicacion(5,10) == 50)
    assert(multiplicacion(7,4) == 28)

def multiplicacion(n1,n2):
    return n1 * n2

'''
division: float float -> float
Dados dos numeros, retorna la division entre ellos.
'''

def test_division():
    assert(division(2,4) == 0.5)
    assert(division(10,5) == 2)
    assert(division(7,4) == 1.75)

def division(n1,n2):
    return n1 / n2

'''
calculos: float float -> float
Dados dos numeros, imprime en pantalla el resultado de las operaciones entre ellos.

operaciones(2,4) = Dado 2 y 4 el resultado de su suma es: 6, de su resta: -2, del producto entre ellos: 8, y de su division: 0.5
operaciones(10,5) = Dado 10 y 5 el resultado de su suma es: 15, de su resta: 5, del producto entre ellos: 50, y de su division: 2.0
operaciones(22,100) = Dado 22 y 100 el resultado de su suma es: 122, de su resta: -78, del producto entre ellos: 2200, y de su division: 0.22

'''

def operaciones(n1,n2):
    adicion = suma(n1,n2)
    diferencia = resta(n1,n2)
    producto = multiplicacion(n1,n2)
    cociente = division(n1,n2)
    print(f"Dado {n1} y {n2} el resultado de su suma es: {adicion}, de su resta: {diferencia}, del producto entre ellos: {producto}, y de su division: {cociente}")


#b

'''
tabla_multiplicar: float -> None
Dado un numero , devuelve su tabla de multiplicar
Testeo:
tabla_multiplicar(5) =              
                        5 x 0 = 0  
                        5 x 1 = 5  
                        5 x 2 = 10 
                        5 x 3 = 15 
                        5 x 4 = 20 
                        5 x 5 = 25 
                        5 x 6 = 30 
                        5 x 7 = 35 
                        5 x 8 = 40 
                        5 x 9 = 45 
                        5 x 10 = 50
tabla_multiplicar(7) =
                        7 x 0 = 0
                        7 x 1 = 7
                        7 x 2 = 14
                        7 x 3 = 21
                        7 x 4 = 28
                        7 x 5 = 35
                        7 x 6 = 42
                        7 x 7 = 49
                        7 x 8 = 56
                        7 x 9 = 63
                        7 x 10 = 70
tabla_multiplicar(18) = 
                        18 x 0 = 0
                        18 x 1 = 18
                        18 x 2 = 36
                        18 x 3 = 54
                        18 x 4 = 72
                        18 x 5 = 90
                        18 x 6 = 108
                        18 x 7 = 126
                        18 x 8 = 144
                        18 x 9 = 162
                        18 x 10 = 180
'''

def tabla_multiplicar(n):
    producto = 0
    for i in range(11):
        producto = n * i
        print(f"{n} x {i} = {producto}")