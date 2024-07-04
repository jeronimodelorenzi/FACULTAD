#PARTE CURSADO

#Ejercicio 1

def numeros():
    for i in range(10,21):
        print(i)

#Ejercicio 2,3

def fichas_n(n):
    for i in range(n+1):
        for j in range(n+1):
            if i <= j:
                print(f"{i}-{j}")

#Ejercicio 4

def factorial_m_veces():
    m = int(input("Ingrese cuantos factoriales va a hacer: "))
    

    for i in range(m):
        n = int(input("Ingrese un numero: "))
        factorial = 1

        for j in range(1,n+1):
            factorial *= j
        print(factorial)

#Ejercicio 5
        
#Ejercicio 6

def numeros_triangulares(n):
    suma = 0
    for i in range(n+1):
        suma += i
        print(f"{i}-{suma}")

def numeros_triangularesa(n):
    suma = 0
    for i in range(n+1):
        suma = (i*(i+1))/2
        print(f"{i}-{suma}")
        

             