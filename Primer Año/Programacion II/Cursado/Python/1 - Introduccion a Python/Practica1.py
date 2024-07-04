#Ejercicio 1,2

'''
numeros : Natural -> None
Dado un numero natural "n", imprime en pantalla los primeros "n" numeros pares.
'''

def numeros(n:int)->None:
    if n == 0:
        return 0
    else:
        print(n*2)
        return numeros(n-1)
    
#Ejercicio 3

'''
numeros2 : Natural Natural -> None
Dado dos numero naturales "n" y "m", imprime en pantalla los primeros "n" numeros pares mayores que "m".
'''

def numeros2(n:int, m:int)->None:

    if n == 0:
        return
  
    if m % 2 == 0:
        print(m)
    else:
        print(m + 1)

    numeros2(n - 1, m + 2)
    
#Ejercicio 4,5

'''
suma : Natural -> Natural
Dado un numero natural "n", retorna  el resultado de la suma de los primeros "n" numeros naturales.
'''

def suma(n:int)->int:
    if n == 0:
        return 0
    else:
        return n + suma(n-1)
    
#Ejercicio 6

'''
suma2 : Natural Natural -> Natural
Dado dos numero naturales "n" y "m", retorna el resultado de la suma de los numeros mayores que "n" y menores que "m"
'''

def suma2(n:int, m:int)->int:
    if n >= m:
        return 0
    else:
        return n + suma2(n + 1, m)
    
#Ejercicio 7,8 

'''
duplica: String Natural -> String
Dado un string y un numero natural "n", retorna el string duplicado "n" veces.
'''

def duplica(name:str,n:int)->int:
    return name*n

#Ejercicio 9

'''
suma3 : Int Int -> Int
Dado dos numeros enteros "n" y "m", retorna la suma de ellos.
'''

def suma3(n:int,m:int)->int:
    return n+m

'''
resta : Int Int -> Int
Dado dos numeros enteros "n" y "m", retorna la resta de ellos.
'''

def resta(n:int,m:int)->int:
    return n-m

'''
multiplica : Int Int -> Int
Dado dos numeros enteros "n" y "m", retorna el producto de ellos.
'''

def multiplica(n:int,m:int)->int:
    return n*m

'''
divide: Int Int -> Int
Dado dos numeros enteros "n" y "m", retorna la division entre ellos mientras "m" sea diferente de 0. 
Si se intenta dividir por 0 lo indica.
'''

def divide(n:int,m:int)->float:
    if m != 0:
        return n/m
    else:
        return "No se puede dividir por cero"

'''
calculadora : None -> Int
Dada una operacion elegida por el usuario: 1. Suma
                                           2. Resta
                                           3. Multiplica
                                           4. Divide
Se le pide ingresar dos numeros para realizar dicha operacion y retorna el resultado.
Si el usuario elige un numero de operacion distinto de los establecidos se le pide que ingrese uno valido.
Mientras el usuario no ingrese el numero 5 se repetira la funcion.
'''

def calculadora()->int:
    
    operacion = int(input("Que operación desea realizar?:"))

    if operacion >= 1 and operacion <= 4:
        n = int(input("Ingrese el primer número: "))
        m = int(input("Ingrese el segundo número: "))

        if operacion == 1:
            resultado = suma3(n,m)
        elif operacion == 2:
            resultado = resta(n,m)
        elif operacion == 3:
            resultado = multiplica(n,m)
        elif operacion == 4:
            resultado = divide(n,m)

        print(resultado)
        calculadora()
    elif operacion == 5:
            print ("Finalizo")   
    else: 
        print("No es una opcion valida") 
        calculadora()