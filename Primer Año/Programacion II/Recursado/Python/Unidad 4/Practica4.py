#Ejercicio 1
def veinteNumero():
    for i in range(10,21):
        print(i)

#Ejercicio 2

def factorial(n):
    calculo = 1
    for i in range(1,n+1):
        calculo *= i
    return calculo

def factoriales():
    m = int(input("Ingrese la cantidad de numeros a los que quiera realizar el factorial: "))
    acumulador = 0
    for i in range(m):
        num = int(input(f"Ingrese un numero para el factorial n° {i+1}: "))
        acumulador = factorial(num)
        print(f"El factorial de {num} es {acumulador}")

#Ejercicio 5

def suma_hasta_n(n):
    suma = 0
    for i in range(1,n+1):
        suma += i
    return suma

def numero_trianguales(n):
    suma = 0
    for i in range(1,n+1):
        suma = suma_hasta_n(i)
        print(f"{i} - {suma}")

#Ejercicio 6

#a

def pedido():
    solicitud = int(input("Ingrese un numero positivo:"))
    while solicitud <= 0:
        if solicitud == 0:
            print("El numero ingresado es 0, no es ni positivo ni negativo. Ingrese nuevamente un numero.")
        else:
            print("El numero ingresado es negativo. Ingrese nuaevamente un numero.")
        solicitud = int(input("Ingrese un numero positivo: "))
    print("Muy bien!")

#b

def leerSolicitud():
    return input("Ingrese un numero positivo (o q para terminar): ")

def pedidoConSolicitud():
    solicitud = leerSolicitud()
    while solicitud != "q":
        if solicitud == 0:
            print("El numero ingresado es 0, no es ni positivo ni negativo. Ingrese nuevamente un numero.")
        else:
            print("El numero ingresado es negativo. Ingrese nuaevamente un numero.")
            solicitud = leerSolicitud()
    if solicitud == "q":
        print("No queres hacer el ejercicio")
    else:
        print("Muy bien!")

#Ejercicio 7

def pedirNotas():
    return int(input("Ingrese una nota: "))

# def notas():
#     pedir = pedirNotas()
#     while

#Ejercicio 8

def pedido():
    n = int(input("Ingrese un numero natural (-1 para salir): "))
    contador = 0
    suma = 0
    while n != -1:
        suma += n
        contador += 1
        n = int(input("Ingrese otro numero natural (-1 para salir): "))
    if suma <= 0:
        print("Como no ingresaste notas no hay promedio")
    else:
        promedio = suma/contador
        print(f"Numeros ingresados: {contador}, suma de los numeros: {suma}, promedio: {promedio}")

#Ejercicio 9

#a

def multiplos_for(m,n):
    multiplos = 0
    for i in range(m,n+1):
        if i % m == 0:
            multiplos += 1
    return multiplos

#b

def multiplos_while(m,n):
    i = 0
    while (m * i) < n:
        i += 1
    return i


#Ejercicio 10

def es_primo(n):
    primo = True
    for i in range(2,n):
        if n % i == 0:
            primo = False
    return primo

def es_primo_while(n):
    primo = True
    if n == 1:
        primo = False
    i = 2
    while i < n and primo:
        if n % i == 0:
            primo = False
        i += 1
    return primo

def primos_n(n):
    for i in range(1,n+1):
        if es_primo(i):
            print(i)

def primos_n_while(n):
    i = 1
    while i <=n:
        if es_primo_while(i):
            print(i)
        i += 1

#Ejercicio 11

#a

def primercontraseña():
    CONTRASEÑA = "HolaMundo"
    ingreso = input("Ingrese la contraseña para continuar: ")
    while ingreso != CONTRASEÑA:
        print("Contraseña incorrecta.")
        ingreso = input("Ingrese la contraseña para continuar: ")
    print("Contraseña correcta... Continue")

#b

def segundacontraseña():
    CONTRASEÑA = "HolaMundo"
    intentos = 5
    ingreso = input("Ingrese la contraseña para continuar: ")

    while ingreso != CONTRASEÑA and intentos > 1:
        intentos -= 1
        print(f"Contraseña incorrecta. Te quedan {intentos}")
        ingreso = input("Ingrese la contraseña para continuar: ")

    if intentos == 1:
        print("Te quedaste sin intentos, no continuas")
    else:
        print("Contraseña correcta... Continue")

#Ejercicio 12

#a

def es_potencia_dos(n):
    condicion = False
    while n % 2 == 0:  
        if n / 2 == 1:
            condicion = True    
        n /= 2          
    return condicion

#b

def suma_potencias(n,m):
    i = n
    j= m
    if m < n:
        i = m
        j = n
    suma = 0
    while i <= j:
        if es_potencia_dos(i):
            suma += i
        i += 1
    return suma

def buscar_impar (x):
    """Divide el número recibido por 2 hasta que sea impar."""

    while x % 2 == 0:
        x = x / 2   
    return x

def menor_factor_primo (x):
    """Devuelve el menor factor primo del número x."""
    n = 2
    while n <= x:
        if x % n == 0:
            return n

#Practica 5

#1

def tabla_multiplicar():
    for i in range(1,11):
        print("")
        for j in range(1,11):
            print(f"{i}*{j} = {i*j}")
    

#2

#a

def figura_rectangulo():
    for _ in range(5):
        for _ in range(4):
            print("*", end= " ")
        print("")

def figura_cuadrado():
    for _ in range(5):
        for _ in range(5):
            print("*", end= " ")
        print("")

def figura_algo():
    for i in range(5, -1, -1):  # Cambiando el rango para invertir el triángulo
        for _ in range(i):
            print("*", end=" ")
        print("")




def collatz_rec(n, aplicaciones = 0):
    if n == 1:
        return aplicaciones
    elif n % 2 == 0:
        return collatz_rec(n/2, aplicaciones+1)
    else:
        return collatz_rec(3*n+1, aplicaciones+1)

def collatz_ite(n):
    aplicaciones = 0
    while n > 1:
        if n % 2 == 0:
            n /= 2
            aplicaciones += 1
        else:
            n = 3*n+1
            aplicaciones += 1
    return aplicaciones

        


        