from Practica2 import *

def testNumTriangular():
    assert numTriang2(4) == '4 - 10.0'
    assert numTriang2(10) ==  '10 - 55.0'
    assert numTriang2(100) == '100 - 5050.0'

def testMultiplos(): #Mismo para multiplosFor y multiplosWhile
    assert multiplos(2,3) == 1
    assert multiplos(2,6) == 3
    assert multiplos(3,15) == 5

def testEsPrimo():
    assert esPrimo(4) == False
    assert esPrimo(19) == True

def testEsPotenciaDos():
    assert esPotenciaDos(16) == True
    assert esPotenciaDos(22) == False