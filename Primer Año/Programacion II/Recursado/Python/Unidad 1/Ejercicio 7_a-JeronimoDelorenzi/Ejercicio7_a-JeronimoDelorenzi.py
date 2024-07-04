#----------------------------------------------------------------------------------
#Entrega del Ejercicio 7 a de la practica 1 Python.
#Jeronimo Delorenzi
#----------------------------------------------------------------------------------

#a

'''
n1: float
n2: float
suma: float float -> float
Dados dos numeros, retorna la suma entre ellos.
'''

def suma(n1,n2):
    return n1 + n2

def test_suma():
    assert(suma(2,4) == 6)
    assert(suma(5,10) == 15)
    assert(suma(7,4) == 11)

'''
n1: float
n2: float
resta: float float -> float
Dados dos numeros, retorna la resta entre ellos.
'''

def resta(n1,n2):
    return n1 - n2

def test_resta():
    assert(resta(2,4) == -2)
    assert(resta(5,10) == -5)
    assert(resta(7,4) == 3)

'''
n1: float
n2: float
multiplicacion: float float -> float
Dados dos numeros, retorna el producti entre ellos.
'''

def multiplicacion(n1,n2):
    return n1 * n2

def test_multiplicacion():
    assert(multiplicacion(2,4) == 8)
    assert(multiplicacion(5,10) == 50)
    assert(multiplicacion(7,4) == 28)

'''
n1: float
n2: float
division: float float -> float
Dados dos numeros, retorna la division entre ellos.
'''

def division(n1,n2):
    return n1 / n2

def test_division():
    assert(division(2,4) == 0.5)
    assert(division(10,5) == 2)
    assert(division(7,4) == 1.75)


def main():
    n1 = float(input("Ingrese un primer numero: "))
    n2 = float(input("Ingrese un segundo numero: "))
    adicion = suma(n1,n2)
    diferencia = resta(n1,n2)
    producto = multiplicacion(n1,n2)
    cociente = division(n1,n2)
    print(f"Dado {n1} y {n2} el resultado de su suma es: {adicion}, de su resta: {diferencia}, del producto entre ellos: {producto}, y de su division: {cociente}")

if __name__ == "__main__":
    main()