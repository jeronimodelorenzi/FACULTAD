#Ejercicio 1

'''
numeros: None -> None
Devuelve en pantalla los numeros del 10 al 20
'''

def numeros ():

    for i in range(10,21):
        print(i) 

#Ejercicio 2

'''
domino : None -> None
Devuelve en pantalla las fichas del domino
'''

def domino ():
    
    for i in range(0,7):
        for j in range(0,7):
            if i <= j:
                print(i ,",", j)

#Ejercicio 3

'''
dominoN : Int -> None
Devuelve en pantalla las fichas del domino de 0 hasta n
'''

def dominoN (n):
    
    for i in range(0,n+1):
        for j in range(0,n+1):
            if i <= j:
                print(i ,",", j)

#Ejercicio 4

'''
factorial : None -> None
Dada una cantidad de valores que seran ingresados dados por el usuario, a medida que se ingresa cada numero
muestra en pantalla su factorial.
'''

def factorial ():
    
    m = int(input("Ingrese la cantidad de valores: "))
    
    for i in range (m):
        n = int(input("Ingrese un numero: "))
        factorial = 1
        for j in range(1,n+1):
            factorial *= j   
        print(factorial)
    

#Ejercicio 5

'''
Representamos temperaturas mediante números enteros
farCel : Int -> Int
El parámetro representa una temperatura en Fahrenheit y se retorna su equivalente en Celsius.
'''

def farCel (f:int)->int :
    return (f -32) *5/9

'''
farToCel : None -> None
Muestra en pantalla la conversion de temperaturas desde 0°F hasta 120°F en grados Celsius.
Usa la funcion farCel.
'''

def farToCel ():

    for i in range(0,121,10):
        print(farCel(i))
        
    #return [farCel(i) for i in range(0,121,10)]

#Ejercicio 6

'''
numTriang : Natural-> None
Imprime en pantalla los primeros n numeros triangulares junto a sus indices.
'''

def numTriang (n:int):
    
    cont = 0

    for i in range(1,n+1):
        cont += i
        print(i, "-", cont)

'''
numTriang2 : Natural-> String
Retorna los primeros n numeros triangulares junto a sus indices.
'''

def numTriang2 (n):

    return str(n) + " - " + str((n*(n+1))/2)

#Ejercicio 7

'''
pedido : None -> None
Devuelve en pantalla si el usuario ingresa un numero positivo, de lo contrario,
repite el pedido hasta que cumpla dicho parametro.
'''

def pedido ():
   
    n = int(input("Ingrese un numero positivo:"))

    while n <= 0:
        n = int(input("Ingrese un numero positivo:"))

    print("Cumpliste el pedido")

#Ejercicio 8

'''
promedios : None -> Float
El usuario ingresa notas hasta ingresar un -1 y el programa imprime el promedio.
'''

def promedio ():
    contador = 0
    suma = 0
    notas = float(input("Ingrese una nota o un -1 para terminar:"))

    while notas != -1:
        suma += notas
        contador += 1
        promedio = suma / contador
        notas = float(input("Ingrese otra nota o un -1 para finalizar:"))
    
    return promedio

#Ejercicio 9

'''
pedido2 : None -> None
Dados dos numeros enteros ingresados por el usuario, mientras que no sea el segundo numero
mayor que el primero, se pedira de vuelta. 
Imprime en pantalla los dos numeros al finalizar la funcion.
'''

def pedido2 ():

    n = int(input("Ingrese un numero entero:"))
    m = int(input("Ingrese un numero entero:"))

    while m < n:
        m = int(input("Ingrese otro numero entero:"))
    
    print("El primer numero es ", n, " y el segundo es ", m)

#Ejercicio 10

'''
multiplos: Natural Natural -> Natural
Dado dos numeros naturales ingresados como parametros,
retorna cuantos multiplos hay del primero menores que el segundo.
'''

def multiplos (n:int,m:int)->int:
    if n <= 0:
        return 0
    
    cont = m // n
    return cont

'''
multiplosFor: Natural Natural -> Natural
Dado dos numeros naturales ingresados como parametros,
retorna cuantos multiplos hay del primero menores que el segundo utilizando el bucle for.
'''

def multiplosFor (n:int, m:int)->int:
    cont = 0

    for i in range(n, m+1):
        cont = multiplos(n, i)
    
    return cont

'''
multiplosFor: Natural Natural -> Natural
Dado dos numeros naturales ingresados como parametros,
retorna cuantos multiplos hay del primero menores que el segundo,
multiplicando el primer numero hasta que sea mayor que el segundo.
'''

def multiplosWhile(n:int, m:int)->int:

    cont = 1

    while cont * n <= m:
        cont += 1
    resultado = cont - 1  

    return resultado

#Ejercicio 11

'''
manejoContraseñas : None -> None
Dada la contraseña "HolaMundo1", cuando el usuario ingrese la contraseña correcta continua el programa.
'''

def manejoContraseñas ():

    contraseña = "HolaMundo1"
    entrada = input("Ingrese la contraseña:")

    while entrada != contraseña:
        entrada = input("Ingrese la contraseña correcta:")

    print ("Continua el programa...")

'''
manejoContraseñasIntentos : None -> Boolean
Dada la contraseña "HolaMundo1", el usuario tiene 5 intentos para ingresar la contraseña correcta.
En caso de que no ingrese la contraseña en esos 5 intentos es expulsado.
'''

def manejoContraseñasIntentos ()->bool:

    contraseña = "HolaMundo1"
    
    intentos = 5

    ingreso = False

    while intentos > 0 and not ingreso:
        
        entrada = input("Ingrese la contraseña:")

        if entrada == contraseña:
            print("Continua el programa...")
            ingreso = True
        else:
            intentos -= 1
            if intentos > 0:
                print("Contraseña incorrecta. Te quedan", intentos, "intentos.")
            else:
                print("Al no saber la contraseña no puedes continuar con el programa.")
        
    return ingreso

'''
ingresoContraseña : None -> None
Si el usuario ingreso la contraseña correcta antes de que se le terminen los intentos devuelve imprime True,
caso contrario, imprime False.
'''

def ingresoContraseña ():

    resultado = manejoContraseñasIntentos()
    print("Ingreso correctamente la contraseña? ", resultado)

#Ejercicio 12

'''
esPrimo : Natural -> Boolean
Dado un numero natural "n" retorna si "n" es primo o no.
'''

def esPrimo (n:int)->bool:

    cont = n - 1
    encontrado = False

    while cont >= 2 and not encontrado:
        if n % cont == 0:
            encontrado = True
        cont -= 1


    return not encontrado

'''
primos : Natural -> None
Dado un numero natural "n", si es primo devuelve todos los primos menores que "n".
'''

def primos (n:int):

    for i in range(2, n+1):
        if esPrimo(i):
            print(i)

#Ejercicio 13

'''
esPotenciaDos: Natural -> Boolean
Dado un numero natural "n", retorna si es potencia de 2.
'''

def esPotenciaDos (n:int)->bool:

    encontrado = False
     
    while n > 1 and not encontrado:
        if n % 2 != 0:
            encontrado = True
        n /= 2
    
    return not encontrado

'''
sumaPotenciaDos : Natural Natural -> None
Dada dos numeros naturales "n" y "m", si son potencia de dos, imprime en pantalla el resultado de la suma.
Caso contrario devuelve 0.
'''

def sumaPotenciaDos (n:int,m:int):
    suma = 0
    for i in range(n,m+1):
        if not(esPotenciaDos(i)):
            0
        else:
            suma += i
    print(suma)

#Ejercicio 14

from random import *

'''
dado : None -> None
La funcion dado simula los lanzamientos de un dado.
Finaliza cuando el dado caiga en 6, imprimiendo en pantalla cuantos intentos tardo en llegar.
'''

def dado ():
    tiradas = 0
    numero = 0
    while numero != 6 :
        numero = randint(1,6)
        tiradas += 1
        print("Salio el numero ", numero, "en la tirada", tiradas)

'''
dosDados : None -> None
La funcion dosDados simula los lanzamientos de dos dados.
El usuario ingresa el numero de tiradas. Al terminar las tiradas muestra en pantallas
cuantas veces se obtuvo el mismo resultado.
'''

def dosDados():

    tiradas = int(input("Ingrese el lanzamiento de los dos dados:"))
    numeroDado1 = 0
    numeroDado2 = 0
    contIgual = 0
    
    while tiradas != 0:
        numeroDado1 = randint(1,6)
        numeroDado2 = randint(1,6)
        tiradas -= 1
        
        if numeroDado1 == numeroDado2:
            contIgual += 1

    if contIgual > 0:
        print("Obtuvieron el mismo resultado", contIgual, "veces.")

    else:
        print("En ninguna tirada se obtuvo el mismo resultado.")

'''
juegoDado : None -> None
La funcion juegoDado simula los lanzamientos de un dado.
El usuario ingresa cuantas veces va a ser tirado el dado.
Si sale 6, gana 4 pesos. Si sale 3, gana 1 peso. Si sale 1, sigue jugando.
Si sale 2, 4 o 5, pierde 2 pesos.
Al final imprime en pantalla cuanto dinero gano o cuanto dinero debe.
'''

def juegoDado ():
    
    tiradas = int(input("Ingrese las tiradas del dado:"))
    numeroDado1 = 0
    acumulador = 0
    
    while tiradas > 0:
        numeroDado1 = randint(1,6)
        tiradas -= 1
        
        if numeroDado1 == 1:
            tiradas +=1
        if numeroDado1 == 6:
            acumulador += 4
        elif numeroDado1 == 3:
            acumulador +=1
        elif numeroDado1 == 2 or numeroDado1 == 4 or numeroDado1 == 5:
            acumulador -=2
        print("Salio el numero ",numeroDado1, "en la tirada", tiradas+1,"Cantidad acumulado: ",acumulador)
 
    print("Total acumulado: ",acumulador)