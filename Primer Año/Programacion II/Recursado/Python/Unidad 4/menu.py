import os
import time
import math

def imprimirMenu():
  """None->Integer
    Muestra un menú de opciones y devuelve la 
    opción ingresada por el usuario.
    Opciones:
    1. Factorial 
    2. Fibonacci
    3. Promedio Aritmetico
    4. Primo
    5. Para Salir

  """
  os.system ("clear") 
  print ("1. Calcula el Factorial ")
  print ("2. Calcula el Fibonacci ")
  print ("3. Calcula el Promedio Aritmético")
  print ("4. Determina si es un número primo")
  print ("5. Calcula una funcion trigonometrica")
  print ("6. Opción de Salida \n")

  opcion = int (input("Ingrese la opción elegida: "))
  return opcion

def factorial (numero):
    """Integer -> Integer
     Ejemplos:
      factorial(2)==2
      factorial(0)==1
      factorial(4)==24
    """
    respuesta = 1
    for i in range(1,numero+1):
        respuesta *= i
    return respuesta

def fibonacci(numero, a = 0,b=1):
    """Integer -> Integer"""

    while numero!=0:
        return fibonacci(numero-1, b, a + b)
    return a


def promedioAritmetico (numero1, numero2):
  """Integer Integer-> Integer"""
  respuesta = (numero1 + numero2)/2
  return respuesta

def esPrimo (numero):
    """Integer -> Boolean"""

    respuesta = True
    i = 2
    if numero == 1 or numero == 2:
       return respuesta
    while i < numero and respuesta:
        if numero % i == 0:
            respuesta = False
        i += 1    
    return respuesta

def menu_trigonometrica():
    print("\n1. Calcula el coseno")
    print("2. Calcula el seno")
    print("3. Calcula la tangente")

    opcion = int(input("Ingrese una opcion: "))
    return opcion

def pasaje_radianes(num):
    radianes = num*(math.pi/180)
    return radianes

def coseno(numero):
    radianes = pasaje_radianes(numero)
    return math.cos(radianes)

def seno(numero):
    radianes = pasaje_radianes(numero)
    return math.sin(radianes)

def tangente(numero):
    radianes = pasaje_radianes(numero)
    return math.tan(radianes)

def accionTrigonometrica(opcion):
    if opcion == 1:
        numero = int(input("Ingrese nro a calcular: "))
        respuesta = coseno(numero)
        print(f"El coseno de {numero} es {respuesta}")
    
    elif opcion == 2:
        numero = int(input("Ingrese nro a calcular: "))
        respuesta = seno(numero)
        print(f"El seno de {numero} es {respuesta}")
    
    elif opcion == 3:
        numero = int(input("Ingrese nro a calcular: "))
        respuesta = tangente(numero)
        print(f"La tangente de {numero} es {respuesta}")
    else:
       print("Operacion no valida.")

def realizarAcciones(opcion):
    """ Integer -> None
        Realiza una acción según la opción del menú elegida. Si la opcion no es valida entonces muestra en pantalla un mensaje de error. 
    """
    if (opcion ==  1):
        numero= int(input("Ingrese nro a calcular: "))
        respuesta = factorial (numero)
        print (f"El factorial del numero {numero} es {respuesta}")
        time.sleep(2)
    
    elif (opcion == 2):
        numero= int(input("Ingrese nro a calcular: "))
        respuesta = fibonacci (numero)
        print (f"\nEl fibonacci del numero {numero} es {respuesta}")
        time.sleep(2)

    elif (opcion == 3):
        numero1 = int(input("Ingrese nro1: "))
        numero2=  int(input("Ingrese nro2: "))
        respuesta = promedioAritmetico(numero1, numero2)
        print (f"El promedio aritmetico de numero {numero1} y {numero2} es {respuesta}")
        time.sleep(2)
    
    elif (opcion == 4):
        numero= int(input("Ingrese un numero para saber si es primo: "))
        respuesta = esPrimo(numero)
        if respuesta:
           print(f"El numero {numero} es primo")
        else:
           print(f"El numero {numero} no es primo")
        time.sleep(2)

    elif (opcion == 5):
        numero = menu_trigonometrica()
        accionTrigonometrica(numero)


    else:
      print ("La opción seleccionada no es valida.")


def main():
  respuesta = imprimirMenu()
  while (respuesta != 6):
    realizarAcciones(respuesta)
    respuesta= int(input("Ingrese otra operacion: "))
  print("Gracias por usar este Menú")

