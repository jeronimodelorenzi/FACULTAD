from Practica3 import *

def testPosicionesMultiplo ():
    assert posicionesMultiplo(["Hola", 1 ,2 ,3], 2) == ["Hola", 2]
    assert posicionesMultiplo([1,2,3,4,5,6,7,8,9,10], 3) == [1,4,7,10] 
    assert posicionesMultiplo([1,2,3,4,5,6,7,8,9,10], 11) == [1] 

def testSumaAcumulada ():
    assert sumaAcumulada([1,2,3]) == [1,3,6]
    assert sumaAcumulada([4,5,6]) == [4,9,15]
    assert sumaAcumulada([1,1,1]) == [1,2,3]

def testElimina ():
    assert elimina(["Hola","Como","Va"]) == ["Como"]
    assert elimina([1,2,3,4,5,6]) == [2,3,4,5]
    assert elimina([]) == []

def testOrdenada ():
    assert ordenada([1,2,3,4,5]) == True
    assert ordenada(["a","b","c","d"]) == True
    assert ordenada(["Calabaza","Batata","Zapallo","Acelga"]) == False

def testDuplicado ():
    assert duplicado(["Hola","Como","Va","Hola"]) == True
    assert duplicado(["Hola","Como","Va",]) == False
    assert duplicado([]) == False

def testEliminaDuplicado():
    assert eliminaDuplicado((["Hola","Como","Va","Hola"])) == ["Como","Hola","Va"]
    assert eliminaDuplicado(["Hola","Como","Va"]) == ["Hola","Como","Va"]
    assert eliminaDuplicado([]) == []

def testContarElementos ():
    assert contarElementos(["Hola","Como","Va","Hola"]) == 3
    assert contarElementos([1,2,3,4]) == 4
    assert contarElementos([]) == 0

def testBusquedaDicotomica ():
    assert busquedaDicotomica("Jero") == True
    assert busquedaDicotomica("Grasa") == True
    assert busquedaDicotomica("Tomate") == False

def testContar ():
    assert contar("Hola", "l") == 1
    assert contar("Mississippi", "s") == 4
    assert contar("Jeronimo", "f") == 0

def testMasCinco ():
    assert masCinco("Dos Mas Dos No es Cuarenta") == 1
    assert masCinco("Jeronimo Delorenzi") == 2
    assert masCinco("Si o No") == 0

def esDigito ():
    assert esDigito("2003") == True
    assert esDigito("0f0f0f") == False
    assert esDigito("Sal") == False