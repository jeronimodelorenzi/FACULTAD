def maximo ():
    lista = []
    
    n = int(input("Ingrese un numero: "))

    lista.append(n)

    while n != 0:
        n = int(input("Ingrese otro numero: "))
        lista.append(n)

    max=lista[0] # Asumimos que es el valor maximo para luego recorrer la lista.

    for i in lista:
        if i>max:
            max = i
    return max

def longitud ():
    
    string = str(input("Ingrese un string: "))

    cont= 0
    for i in string:
        cont += 1
    return cont


def cantVocal ():
    
    string = str(input("Ingrese un string: "))
    cont = 0
    for x in string:
        if x == "a" or x == "e" or x == "i" or x == "o" or x == "u":
            cont +=1
    return cont

def esVocal ():
  
    character = input("Ingrese un caracter: ")
    
    if character == "a" or character == "e" or character == "i" or character == "o" or character == "u":
        return True
    else:
        return False
    
def esVocal1 (s):
  
    if s == "a" or s == "e" or s == "i" or s == "o" or s == "u":
        return True
    else:
        return False
    
def años ():
    año_actual = int(input("Ingrese el año actual: "))
    cant_personas = int(input("Ingrese la cantidad de personas: "))
    cont = 1
    
    while cont <= cant_personas:
        nombre = input(f"Nombre de la persona {cont}: ")
        año_nacimiento = int(input(f"Año de nacimiento de {nombre}: "))
        print(f"{nombre} cumple en {año_actual}: {año_actual-año_nacimiento} años")
        cont +=1

def nombres ():
    lista = []
    
    nombre = input("Ingrese un nombre: ")

    lista.append(nombre)

    condicion = input("Desea ingresar otro nombre? ")

    while condicion == "si":

        nombre = input("Ingrese otro nombre: ")
        condicion = input("Desea ingresar otro nombre? ")
        lista.append(nombre)
    
    contador = 0

    for nombre in lista:
        if esVocal1(nombre[0]):
            contador += 1

    print("Cantidad de nombres que comienzan con vocal:", contador)

def mostrarSimbolos ():
    simbolo = "♠"

    for i in range(1, 6):
        print (simbolo*i)
    
    for i in range(4, 0, -1):
        print(simbolo * i)

l = [99, True, "una lista", [1,2,3,4]]

def impar():
    n = int(input("Ingrese un numero: "))
    n_str = str(n)

    for i in range(len(n_str)):
        digito = int(n_str[i])
        if digito % 2 != 0 and i != 0:
            return digito
        
def factorialRec(n):
    if n < 0:
        return "No se puede calcular el factorial de un número negativo"
    elif n == 0:
        return 1
    else:
        return n * factorialRec(n - 1)
    
def ordenar(l, n):
    for i in range(len(l)):
        for j in range(i, len(l)):
            if l[i] > l[j]:
                l[i] = l[j]
    if n > len(l):
        print("No se puede")
    else:
        return l[-n]

def cartas ():
    palos = ["Espada", "Basto" , "Oro", "Copa"]
    numeros = [1,2,3,4,5,6,7,10,11,12]
    list_cartas = []

    for i in numeros:
        for j in palos:
            list_cartas.append((i,j))
    return list_cartas  

from random import *

def mano():
    
    carta = cartas()

    mano1 = []
    mano2 = []

    largo = len(carta)
    
    while len(mano1) < 3:
        i = randrange(largo)
        if not(carta[i] in mano1):
            mano1.append(carta[i])
    
    while len(mano2) < 3:
        i = randrange(largo)
        if not(carta[i] in mano2) and not(carta[i] in mano1):
            mano2.append(carta[i])

    jugadores = [mano1,mano2]
    return  jugadores





