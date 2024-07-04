#Ejercicio 1

'''
posicionesMultiplo : List(Any) Natural -> List(Any)
Dada una lista y un numero natural ingresados como parametros,
retorna una lista con los elementos que estan en la posicion multiplo del numero.
'''

def posicionesMultiplo(l:list, n:int)->list:
    lista = []
    for i in range(len(l)):
        if i % n == 0:
            lista.append(l[i])
    return lista

#Ejercicio 2

'''
sumaAcumulada : List(Number) -> List(Number)
Dada una lista de numeros, retorna la suma acumulada.
La suma acumulada se refiere a una lista donde el primer numero es 
el mismo, el segundo es la suma del segundo con el primero y asi sucesivamente.
'''

def sumaAcumulada (l:list)->list:
    lista = []
    cont = 0
    for i in l:
        cont += i
        lista.append(cont)
    return lista

#Ejercicio 3

'''
elimina : List(Any) -> List(Any)
Dada una lista, la funcion retorna otra lista sin el primer y ultimo elemento.
'''

def elimina (l:list)->list:
    if len(l)>2:
        l[0:1] = []
        l[len(l)-1:] = []
    return l


#Ejercicio 4

'''
ordenada : List(Any) -> Boolean
Dada una lista, retorna si esta ordenada.
'''

def ordenada(l:list)->bool:
    ordenada = False
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]:
            ordenada = False
        else:
            ordenada = True
    return ordenada

#Ejercicio 5

'''
duplicado : List(Any) -> Boolean
Dada una lista, retorna si un elemento esta duplicado.
'''

def duplicado(l:list)->bool:
    duplicado = False
    for i in range(len(l)):
        for j in range(i + 1, len(l)):
            if l[i] == l[j]:
                duplicado = True
    return duplicado

#Ejercicio 6

'''
eliminaDuplicado : List(Any) -> List(Any)
Dada una lista, si tiene objetos repetidos (verificando con la funcion duplicado), elimina las repeticiones.
'''

def eliminaDuplicado(l:list)->list:
    new_l = []
    if duplicado(l) == True:
        l.sort() #.sort() ordena la lista
        i = 0
        while i < len(l) :
            if l[i] not in new_l:
                new_l.append(l[i])
            i += 1    
    return new_l

#Ejercicio 7

'''
contarElementos List(Any) -> Number
Dada una lista, retorna la cantidad de elementos distintos que contiene.
Utiliza la funcion eliminaDuplicado.
'''

def contarElementos(l):
    cont = 0
    for i in l:
        eliminaDuplicado(l)
        cont += 1
    return cont

#Ejercicio 8

'''
busquedaDicotomica : String, List(Str) -> Boolean
Dada una palabra y una lista de palabras, devuelve si la palabra se encuentra en la lista, usando la busqueda dicotomica.
La busqueda dicotomica consiste en buscar una palabra comenzando por el centro, y comprobando si esta arriba o abajo del medio.
'''

def busquedaDicotomica(palabra:str, l:list = ["Arbol", "Casa", "Drama", "Esperanto", "Francia", "Grasa", "Haber", "Isla", "Jero", "Kaka", "Lapadula", "Bahia"])->bool:
    if not ordenada(l): 
        l.sort()
    
    inicio = 0
    fin = len(l) - 1
    encontrado = False
    
    while inicio <= fin and not encontrado:
        medio = (inicio + fin) // 2
        if l[medio] == palabra:
            encontrado = True
            print(f"La palabra {palabra} está en el diccionario")
        elif l[medio] < palabra:
            inicio = medio + 1
        else:
            fin = medio - 1
    
    print(f"La palabra {palabra} no está en el diccionario")
    return encontrado

#Ejercicio 9

'''
mostrarChar : String -> None
Dado un string, imprime en pantalla el string empezando de la ultima letra a la primera.
'''

def mostrarChar(n:str):
    for i in n[::-1]:
        print(i)

#Ejercicio 10

'''
contar : String String(len=1) -> Number
Dado un string y un caracter, retorna cuantas veces aparece el caracter en el string.
'''

def contar(s:str,x:str)->int:
    cont = 0
    for letra in range(len(s)):
        if x == s[letra]:
            cont +=1
    return cont

#Ejercicio 11

'''
contarVocales : String -> None
Dada un string, muestra en pantalla cuantas veces aparecen las vocales.
'''

def contarVocales (s:str):
    vocales = "aeiouAEIOU"
    contA = 0
    contE = 0
    contI = 0
    contO = 0
    contU = 0
    conta = 0
    conte = 0
    conti = 0
    conto = 0
    contu = 0
    for letra in range(len(s)):
        for vocal in range(len(vocales)):
            if s[letra] == vocales[vocal]:
                if s[letra] == "a":
                    conta += 1
                if s[letra] == "e":
                    conte += 1
                if s[letra] == "i":
                    conti += 1
                if s[letra] == "o":
                    conto += 1
                if s[letra] == "e":
                    contu += 1
                if s[letra] == "A":
                    contA += 1
                if s[letra] == "E":
                    contE += 1
                if s[letra] == "I":
                    contI += 1
                if s[letra] == "O":
                    contO += 1
                if s[letra] == "U":
                    contU += 1
    print(f"""En la palabra '{s}' tenemos la cantidad de :
                                                           A = {contA} 
                                                           E = {contE}
                                                           I = {contI}
                                                           O = {contO}
                                                           U = {contU}
                                                           a = {conta}
                                                           e = {conte}
                                                           i = {conti}
                                                           o = {conto}
                                                           u = {contu}""")

#Ejercicio 12

"""def masCinco (s):
    cont = 0
    palabras = s.split() #.split() convierte las palabras de la cadena en una lista
    for i in range(len(palabras)):
        if len(palabras[i]) > 5:
            cont +=1
    print(cont)"""

'''
masCinco : String -> Number
Dado un string que contenga palabras separadas por espacios, retorna las palabras de mas de cinco letras.
'''

def masCinco (s:str)->int:
    cont_letras = 0
    cont_palabras = 0
    for i in s:
        cont_letras += 1
        if i == " ":
            if cont_letras > 5:
                cont_palabras += 1
            cont_letras = 0
    if cont_letras > 5:
        cont_palabras += 1
    return cont_palabras

#Ejercicio 13

'''
barajaFrancesa : None -> List(Tupla)
La funcion retorna una lista de las cartas de la baraja francesa representadas en tuplas.
'''

def barajaFrancesa ()->list:
    palos = ["D","C","T","P"]
    numeros = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
    list_tupla = []
    for i in numeros:
        for j in palos:
            list_tupla.append((i,j))
    return list_tupla

from random import randrange

'''
poker : None -> None
La funcion toma 5 cartas aleatorias (mediante randrange) de la baraja francesa e imprime en pantalla si se forma Poker "(Numero, Palo)".
'''

def poker ():
    baraja = barajaFrancesa()
    largo = len(baraja)
    mano = []
    es_poker = False


    while len(mano) < 5:
        a = randrange(largo)

        if not(baraja[a] in mano):
            mano.append(baraja[a])

    print(mano)

    cont_cartas = 0
    i = 0

    while i < len(mano) and not es_poker:
        j = i + 1
        while j < len(mano):
            if mano[i][0] == mano[j][0]:
                cont_cartas += 1
                if cont_cartas == 4:
                    es_poker = True
            j += 1
        i += 1

    return es_poker

#Preguntar!!!

#Ejercicio 14

'''
tiempo : None -> list(Tupla)
La funcion retorna una lista del horario de un dia completo representado con tuplas.
'''

def tiempo ()->list:
    horas = list(range(24))
    minutos = list(range(60))
    segundos = list(range(60))
    list_tiempo = []
    for i in horas:
        for j in minutos:
            for k in segundos:
                list_tiempo.append((i, j, k))

    return list_tiempo

'''
sumaTiempo : None -> Tupla
La funcion toma dos horarios aleatorios (mediante randrange) y retorna su suma.
'''

def sumaTiempo ()->list:
    tiempos = tiempo()
    largo = len(tiempos)
    horarios = []
    
    while len(horarios) < 2:
        a = randrange(largo)

        if not(tiempos[a] in horarios):
            horarios.append(tiempos[a])

    print(horarios)

    suma_hora = horarios[0][0] + horarios[1][0]
    suma_minuto = horarios[0][1] + horarios[1][1]
    suma_segundo = horarios[0][2] + horarios[1][2]

    if suma_segundo > 60:
        suma_segundo -= 60
        suma_minuto += 1

    if suma_minuto > 60:
        suma_minuto -= 60
        suma_hora += 1

    if suma_hora > 24:
        suma_hora -= 24

    resultado = suma_hora, suma_minuto, suma_segundo
    
    return resultado
    
#Ejercicio 15

'''
esDigito : String -> Bool
Dado un string retorna si la cadena es de digitos.
'''

def esDigito (s:str)->bool:
    digitos = "0123456789"
    for caracter in s:
        if not(caracter in digitos):
            return False
    return True

'''
diaSiguienteE : None -> String
La funcion le pide al usuario que ingrese año(Int), mes(Int) y dia(Int). Dado los datos que ingreso el usuario, calcula el dia siguiente.
'''

def diaSiguienteE ()->str:

    print("\nDias (1 al 31), meses (1 al 12) y año representados con numeros ")
    
    año = input("\nIngrese un año: ")
    while not(esDigito(año)):
        año = input("\nIngrese un año de la forma correcta: ")
    año = int(año)

    mes = int(input("\nIngrese un mes: "))
    while mes > 12 or mes < 1:
        mes = int(input("\nIngrese un mes correcto: "))

    if mes == 2:
        if año % 4 == 0:
            max_dias = 29
        else:
            max_dias = 28
    elif mes in [4,6,9,11]:
        max_dias = 30
    else:
        max_dias = 31

    dia = int(input(f"\nIngrese un dia hasta {max_dias}: "))
    while dia > max_dias or dia < 1:
        dia = int(input(f"\nIngrese un dia correcto hasta {max_dias}: "))

    fecha = (dia, mes, año)

    dia_siguiente = dia + 1
    mes_siguiente = mes
    año_siguiente = año

    if dia_siguiente > max_dias:
        dia_siguiente = 1
        mes_siguiente += 1

        if mes_siguiente > 12 :
            mes_siguiente = 1
            año_siguiente += 1
    
    fecha_post = (dia_siguiente, mes_siguiente, año_siguiente)
    return f"La fecha es {fecha} y su dia siguiente es {fecha_post}"

#Ejercicio 16

'''
diaSiguienteT : None -> String
La funcion le pide al usuario que ingrese año(Int), mes(String) y dia(Int). Dado los datos que ingreso el usuario, calcula el dia siguiente.
'''

def diaSiguienteT ()->str:

    print("\nDias (1 al 31), meses (por sus nombres) y años (XXXX) con numeros  ")
    meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

    año = input("\nIngrese un año: ")
    while not(esDigito(año)):
        año = input("\nIngrese un año de la forma correcta: ")
    año = int(año)

    mes = input("\nIngrese un mes: ")
    for mes in meses:   
        if mes == "Febrero":
            if año % 4 == 0:
                max_dias = 29
            else:
                max_dias = 28
        elif mes in ["Abril","Junio","Septiembre","Noviembre"]:
            max_dias = 30
        else:
            max_dias = 31

    dia = int(input(f"\nIngrese un dia hasta {max_dias}: "))
    while dia > max_dias or dia < 1:
        dia = int(input(f"\nIngrese un dia correcto hasta {max_dias}: "))

    fecha = (dia, mes, año)

    dia_siguiente = dia + 1
    mes_siguiente = mes
    año_siguiente = año

    for i in range(len(meses)):
        if dia_siguiente > max_dias:
            dia_siguiente = 1
            if i == len(meses) - 1:
                mes_siguiente = meses[0]
                año_siguiente += 1
            else:
                mes_siguiente = meses[i]
                año_siguiente += 1
    
    fecha_post = (dia_siguiente, mes_siguiente, año_siguiente)
    return f"La fecha es {fecha} y su dia siguiente es {fecha_post}"

#Ejercicio 17

'''
fichas : None -> List(Tupla)
La funcion retorna una lista de las piezas del domino representadas con tuplas.
'''

def fichas()->list:
    list_fichas = []

    for i in range(7):
        for j in range(7):
            list_fichas.append((i,j))
    
    return list_fichas

'''
domino : None -> String
La funcion toma dos fichas del domino aleatorias (mediante randrange) y retorna si encajan.
'''

def domino ()->str:
    ficha = fichas()
    largo = len(ficha)
    list_tupla_fichas = []
    
    while len(list_tupla_fichas) < 2:
        a = randrange(largo)
        if not(ficha[a] in list_tupla_fichas):
            list_tupla_fichas.append(ficha[a])
    print(list_tupla_fichas)

    encajan = False
    for i in range(len(list_tupla_fichas)):
        for j in range(len(list_tupla_fichas)):
            if list_tupla_fichas[0][i] == list_tupla_fichas[1][j]:
                encajan = True
        
    if encajan:
        return "Encajan"
    else:
        return "No encajan"
    
def dominoBien (ficha1, ficha2):
    encajan = False
    for i in range(len(ficha1)):
        for j in range(len(ficha2)):
            if ficha1[i] == ficha2[j]:
                encajan = True
    return encajan


def dominoString(ficha_s):

    fichas = ficha_s.split()

    ficha1 = fichas[0].split("-")
    ficha2 = fichas[1].split("-")

    if "[" in ficha1[0]:
        ficha1[0] = ficha1[0].split("[")[1]
    if "]" in ficha2[1]:
        ficha2[1] = ficha2[1].split("]")[0]  

    return dominoBien(ficha1, ficha2)
