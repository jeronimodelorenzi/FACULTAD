import random

def dado():
    lanzamiento = random.randint(1,6)
    print(lanzamiento)
    return lanzamiento

def lanzar_dado():
    contador = 0
    lanzamiento = dado()
    while lanzamiento != 6:
        contador += 1
        lanzamiento = dado()
    return f"El numero 6 salio en la tirada {contador+1}"
        
def dos_dados():
    n = int(input("Ingrese cantidad de tiradas: "))
    dado1 = dado()
    dado2 = dado()
    cont_iguales = 0
    if dado1 == dado2:
        cont_iguales = 1
    i = 0
    while i <= n:
        dado1 = dado()
        dado2 = dado()
        if dado1 == dado2:
            cont_iguales += 1
        i += 1
    return f"Los dados coincidieron {cont_iguales} veces"
        
import random

def juego():
    n = int(input("Cantidad de tiradas: "))
    dinero = int(input("Cantidad de dinero: "))
    while n > 0 and dinero > 0:
        tirada = random.randint(1,6)
        print(f"\nSalio el numero {tirada}\n")
        if tirada == 6:
            dinero += 4
            print("Ganaste 4 pesos.")
            print(f"Cuenta = {dinero}.")
            print(f"Tiradas = {n-1}.\n")
        elif tirada == 3:
            dinero += 1
            print("Ganaste 1 peso.")
            print(f"Cuenta = {dinero}")
            print(f"Tiradas = {n-1}.\n")
        elif tirada == 1:
            n += 1
            print("Se suma una tirada")
            print(f"Cuenta = {dinero}")
            print(f"Tiradas = {n+1}.\n")
        else:
            dinero -= 2
            print("Perdiste 2 pesos")
            print(f"Cuenta = {dinero}")
            print(f"Tiradas = {n-1}.\n")        
        n -=1
    print(f"Cuenta final = {dinero}")
    if dinero <= 0:
        print("Perdiste todo")


