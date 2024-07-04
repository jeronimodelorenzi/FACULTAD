#PARTE RECURSADO

#Ejercicio 1

'''
imprimir_cuadrados: None -> None
Dado dos numeros ingresador por el usuario, muestra en pantalla la suma de los cuadrados.
'''

def imprimir_cuadrados():
    print("Se calculará la suma de los cuadrados entre dos números ingresados")

    n1 = int (input ("Ingrese un número entero: "))
    n2 = int (input ("Ingrese otro número entero: "))

    suma=0

    for x in range (n1, n2):
        suma= suma + x*x

    print ("La suma de los cuadrados entre ", n1, "y ", n2, " es: ", suma)
    print("Es todo por ahora!")

'''
Ingresando (3,5) el valor que muestra en pantalla es 25.
Ingresando (3,3) el valor que muestra en pantalla es 0.
Ingresando (5,3) el valor que muestra en pantalla es 0.
'''

#Ejercicio 2

def imprimir_cuadrados():
    print("Se calculará la suma de los cuadrados entre dos números ingresados")

    n1 = int (input ("Ingrese un número entero: "))
    n2 = int (input ("Ingrese otro número entero: "))

    suma=0

    for x in range (n1, n2):
        suma= suma + x*x
        print(f"El numero es {x}, y su cuadrado: {x*x}")

    print ("La suma de los cuadrados entre ", n1, "y ", n2, " es: ", suma)
    print("Es todo por ahora!")

#Ejercicio 3

'''
saludo: None -> None
Dado el nombre ingresado por el usuario, imprime en pantalla un saludo.
Ademas, dado dos numeros ingresados por el usuario, devuelve su producto en pantalla.
'''

def saludo():
    nombre = input("Cual es tu nombre? ")
    n1 = int(input("Ingrese un numero: "))
    n2 = int(input("Ingrese un segundo numero: "))
    producto = n1 * n2
    print(f"Hola {nombre}! El producto entre {n1} y {n2} es {producto}.")

#Ejercicio 4

#a

'''
b reprensenta la base (float), a representa la altura (float).
perimetro_rectangulo: float float -> float
Dada la base y altura,calcula el perimetro de un rectangulo.
'''

def perimetro_rectangulo(b,h):
    return 2*b+2*h

#b

'''
b reprensenta la base (float), a representa la altura (float).
area_rectangulo: float float -> float
Dada la base y altura, retorna el area de un rectangulo.
'''

def area_rectangulo(b,h):
    return b*h

#c

'''
x1 es el primer punto del eje x (float), x2 es el segundo punto del eje x (float).
calcular_base: float float -> float
Dado dos puntos x1 y x2 del eje x, retorna la distancia entre ellos para obtener la longitud del segmento.
'''

def calcular_base(x1,x2):
    return abs(x1 - x2)

'''
y1 es el primer punto del eje y (float), y2 es el segundo punto del eje y (float).
calcular_altura: float float -> float
Dado dos puntos y1 y y2 del eje y, retorna la distancia entre ellos para obtener la longitud del segmento.
'''

def calcular_altura(y1,y2):
    return abs(y1 - y2)

'''
x1 es el primer punto del eje x (float), x2 es el segundo punto del eje x (float). y1 es el primer punto del eje y (float), y2 es el segundo punto del eje y (float).
perimetro_area_xy: float float float float -> float
Dado los puntos x1, x2 del eje x, y los puntos y1, y2 del eje y, calcula el area y el perimetro del rectangulo.
'''

def perimetro_area_xy(x1,x2,y1,y2):

    base = calcular_base(x1,x2)
    altura = calcular_altura(y1,y2)
    return perimetro_rectangulo(base,altura), area_rectangulo(base,altura)

#d

'''
perimetro_circulo: float -> float
Dado el radio de un circulo, retorna el perimetro del circulo.
'''

def perimetro_circulo(r):
    PI = 3.141592
    diametro = r*2
    return diametro*PI

#e

'''
area_circulo: float -> float
Dado el radio de un circulo, retorna el area del circulo.
'''

def area_circulo(r):
    PI = 3.141592
    return PI*r*r

#f

'''
volumen_esfera: float -> float
Dado el radio de la esfera, retorna el volumen.
'''

def volumen_esfera(r):
    PI = 3.141592
    cubo = r**3
    return 4/3 * PI * cubo

#g

'''
raiz_cuadrada: float -> float
Dado un numero (positivo), retorna la raiz cuadrada.
'''

def raiz_cuadrada(n):
    return n**0.5

'''
calcular_hipotenusa: float float -> float
Dado dos catetos (float) retorna cual es la hipotenusa de un triangulo rectangulo.
'''

def calcular_hipotenusa(c1,c2):
    suma_catetos = c1**2 + c2**2
    raiz_catetos = raiz_cuadrada(suma_catetos)
    return raiz_catetos

#Ejercicio 6

'''
factorial: int -> int
Dado un numero entero, retorna el factorial del mismo.
'''

def factorial(n):
    acumulador = 1
    for i in range(1,n+1):
        acumulador *= i
    return acumulador

#Ejercicio 7

#a

'''
suma: float float -> float
Dados dos numeros, retorna la suma entre ellos.
'''
def test_suma():
    assert(suma(2,4) == 6)
    assert(suma(5,10) == 15)
    assert(suma(7,4) == 11)

def suma(n1,n2):
    return n1 + n2

'''
resta: float float -> float
Dados dos numeros, retorna la resta entre ellos.
'''

def test_resta():
    assert(resta(2,4) == -2)
    assert(resta(5,10) == -5)
    assert(resta(7,4) == 3)

def resta(n1,n2):
    return n1 - n2

'''
multiplicacion: float float -> float
Dados dos numeros, retorna el producti entre ellos.
'''

def test_multiplicacion():
    assert(multiplicacion(2,4) == 8)
    assert(multiplicacion(5,10) == 50)
    assert(multiplicacion(7,4) == 28)

def multiplicacion(n1,n2):
    return n1 * n2

'''
division: float float -> float
Dados dos numeros, retorna la division entre ellos.
'''

def test_division():
    assert(division(2,4) == 0.5)
    assert(division(10,5) == 2)
    assert(division(7,4) == 1.75)

def division(n1,n2):
    return n1 / n2

'''
calculos: float float -> float
Dados dos numeros, imprime en pantalla el resultado de las operaciones entre ellos.

operaciones(2,4) = Dado 2 y 4 el resultado de su suma es: 6, de su resta: -2, del producto entre ellos: 8, y de su division: 0.5
operaciones(10,5) = Dado 10 y 5 el resultado de su suma es: 15, de su resta: 5, del producto entre ellos: 50, y de su division: 2.0
operaciones(22,100) = Dado 22 y 100 el resultado de su suma es: 122, de su resta: -78, del producto entre ellos: 2200, y de su division: 0.22

'''

def operaciones(n1,n2):
    adicion = suma(n1,n2)
    diferencia = resta(n1,n2)
    producto = multiplicacion(n1,n2)
    cociente = division(n1,n2)
    print(f"Dado {n1} y {n2} el resultado de su suma es: {adicion}, de su resta: {diferencia}, del producto entre ellos: {producto}, y de su division: {cociente}")


#b
    
'''
tabla_multiplicar: float -> None
Dado un numero , devuelve su tabla de multiplicar
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

#Ejercicio 8

'''
palabra_mil_veces: string -> None
Dada una palabra, muestra en pantalla 1000 veces la palabra con un espacio entre cada una.
'''

def palabra_mil_veces(palabra):
    for i in range(1000):
        print(palabra, end = " ")

#Ejercicio 9
        
'''
palabra_n_veces: string int -> None
Dado una palabra y un numero entero, muestra en pantalla n veces la palabra con un espacio entre cada una.
'''
        
def palabra_n_veces(palabra, n):
    for i in range(n):
        print(palabra, end= " ")

#PARTE CURSADO
        
#Ejercicio 1,2,

def imprimir_n_pares(n):
    if n == 0:
        return 1
    else:
        print(n*2)
        return imprimir_n_pares(n-1)

#Ejercicio 3

def pares_n_m(n,m):
    if n == 0:
        return 0
    elif m % 2 == 0:
        print(m)
    else:
        print(m+1)

    pares_n_m(n-1, m+2)

#Ejercicio 4,5

def suma_n(n):
    if n == 0:
        return 0
    else:
        return n + suma_n(n-1)
    
#Ejercicio 6
    
def suma_n_m(n,m):
    if n == m:
        return 0
    else:
        return n + suma_n_m(n+1, m)
    
#Ejercicio 7,8

def nombre_n(nombre,n):
    return nombre*n
    