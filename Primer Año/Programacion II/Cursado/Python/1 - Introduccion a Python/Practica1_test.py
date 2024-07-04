from Practica1 import *

#Ejercicio 1
#No se hacerlo

#Ejercicio 2
#No se hacerlo

#Ejercicio 3
def testSuma():
    assert suma(3) == 6
    assert suma(4) == 10
    assert suma(5) == 15

def testSuma2():
    assert suma2(1,5) == 10
    assert suma2(1,10) == 45
    assert suma2(5,12) == 56

def testDuplica():
    assert duplica("Hola",2) == "HolaHola"
    assert duplica("Mi",6) == "MiMiMiMiMiMi"
    assert duplica("Nombre",4) == "NombreNombreNombreNombre"

def testSuma3():
    assert suma3(2,5) == 7
    assert suma3(15,5) == 20
    assert suma3(1,0) == 1

def testResta():
    assert resta(2,5) == -3
    assert resta(15,5) == 10
    assert resta(1,2) == -1

def testMultiplica():
    assert multiplica(2,5) == 10
    assert multiplica(15,5) == 75
    assert multiplica(1,2) == 2

def testDivide():
    assert divide(2,5) == 0.4
    assert divide(15,5) == 3
    assert divide(1,0) == "No se puede dividir por cero"





