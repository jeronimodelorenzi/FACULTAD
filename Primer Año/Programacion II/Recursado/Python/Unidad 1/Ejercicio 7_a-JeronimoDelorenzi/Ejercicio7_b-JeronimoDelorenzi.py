#----------------------------------------------------------------------------------
#Entrega del Ejercicio 7 b de la practica 1 Python.
#Jeronimo Delorenzi
#----------------------------------------------------------------------------------

'''
n: int
tabla_multiplicar: int -> None
Dado un numero entero, devuelve su tabla de multiplicar.
Testeo:
tabla_multiplicar(5) =              
                        5 x 0 = 0  
                        5 x 1 = 5  
                        5 x 2 = 10 
                        5 x 3 = 15 
                        5 x 4 = 20 
                        5 x 5 = 25 
                        5 x 6 = 30 
                        5 x 7 = 35 
                        5 x 8 = 40 
                        5 x 9 = 45 
                        5 x 10 = 50
tabla_multiplicar(7) =
                        7 x 0 = 0
                        7 x 1 = 7
                        7 x 2 = 14
                        7 x 3 = 21
                        7 x 4 = 28
                        7 x 5 = 35
                        7 x 6 = 42
                        7 x 7 = 49
                        7 x 8 = 56
                        7 x 9 = 63
                        7 x 10 = 70
tabla_multiplicar(18) = 
                        18 x 0 = 0
                        18 x 1 = 18
                        18 x 2 = 36
                        18 x 3 = 54
                        18 x 4 = 72
                        18 x 5 = 90
                        18 x 6 = 108
                        18 x 7 = 126
                        18 x 8 = 144
                        18 x 9 = 162
                        18 x 10 = 180
'''

def tabla_multiplicar(n):
    producto = 0
    for i in range(11):
        producto = n * i
        print(f"{n} x {i} = {producto}")

def main():
    n = int(input("Ingrese un numero: "))
    tabla_multiplicar(n)

if __name__ == '__main__':
    main()