#Ejercicio 1 a

'''
cantApariciones : List(Any) Any -> Int
Dada una lista de elementos desordenada y un elemento, devuelve cuantas veces aparece dicho elemento en la lista.
'''

def cantApariciones (l:list,e:any) -> int:
    cantidad_apariciones = 0
    i = 0
    if l == []:
        print("La lista esta vacia")
    elif e not in l:
        print(f"El elemento {e} no esta en la lista")
    while i < len(l):
        if l[i] == e:
            cantidad_apariciones += 1
        i += 1
    #print (f"La cantidad de apariciones de {e} es igual a {cantidad_apariciones}.")
    return cantidad_apariciones

#Ejercicio 1 b

'''
posicionElemento : Lista(Any) Any -> Int
Dada una lista de elementos desordenada y un elemento, devuelve la primera coincidencia del elemento
y su posicion.
'''

def posicionElemento (l:list,e:any) -> int:
    posicion = 0
    condicion = False
    if l == []:
        print("La lista esta vacia")
    elif e not in l:
        print(f"El elemento {e} no esta en la lista")
    while posicion < len(l) and not condicion:
        if l[posicion] == e:
            condicion = True
        posicion += 1
    #print(f"La primer posicion del elemento {e} es {posicion - 1}.")
    return posicion - 1

#Ejercicio 1 c

'''
listaPosiciones : Lista(Any) Any -> List(Int)
Dada una lista desordenada y un elemento, devuelve una lista con las posiciones de los elementos.
'''

def listaPosiciones (l:list,e:any) -> int:
    posicion = 0
    lista_posiciones = []
    if l == []:
        print("La lista esta vacia")
    elif e not in l:
        print(f"El elemento {e} no esta en la lista")
    while posicion < len(l):
        if l[posicion] == e:
            lista_posiciones.append(posicion)
        posicion += 1
    return lista_posiciones

#Ejercicio 2 a

'''
max : List(Int) -> Int
Dada una lista desordenada de numeros, devuelve el maximo de la lista.
'''

def max (l:list) -> int:
    i = 0
    if l == []:
        print("La lista esta vacia")
    max = l[0]
    while i < len(l):
        if l[i] > max:
            max = l[i]
        i += 1
    return max

#Ejercicio 2 b

'''
maxTupla : List(Int) -> Tuple(Int)
Dada una lista desordenada de numeros, devuelve una tupla con el maximo y su posicion.
Utiliza la funcion max y posicionElemento.
'''

def maxTupla (l:list) -> tuple:
    maximo = max(l)
    posicion = posicionElemento(l,maximo)
    return maximo,posicion

#Ejercicio 3

'''
busquedaDicotomica : List(Any) Any -> Int
Dada una lista ordenada de elementos y un elemento, si un elemento esta en la lista devuelve su posicion mediante
busqueda dicotomica, si no esta lo agrega en la posicion correcta.
'''

def busquedaDicotomica (l:list, e:any) -> int:
    l.sort()
    inicio = 0
    fin = len(l) - 1
    encontrado = False

    while inicio <= fin and not encontrado:
        medio = (inicio + fin) // 2
        if l[medio] == e:
            encontrado = True
        elif l[medio] < e:
            inicio = medio + 1
        else:
            fin = medio - 1

    if encontrado:
        return medio
    else:
        l.insert(inicio, e)  
        return inicio  

#Ejercicio 4

'''
tuplasDict -> List(Tuple) -> Dict
Dada una lista de tuplas, devuelve un diccionario donde la clave es el primer valor de la tupla
y los valores una lista con los segundos.
'''

def tuplasDict (l:list) -> dict:
    dic = {}
    for i in l:
        if i[0] not in dic:
            dic[i[0]] = [i[1]]
        else:
            dic[i[0]].append(i[1])
    return dic

#Ejercicio 5 a

'''
aparicionesDict : String -> Dict
Dado un string, devuelve un diccionario con la cantidad de apariciones de cada palabra de la cadena.
'''

def aparicionesDict (s:str) -> dict:
    string = s.lower()
    lista_palabras = string.split()
    dic = {}
    for i in lista_palabras:
        if i not in dic:
            dic[i] = 1
        else:
            dic[i] += 1
    return dic

#Ejercicio 5 b

'''
caractDict : String -> Dict
Dado un string, devuelve un diccionario con la cantidad de apariciones de cada caracter de la cadena.
'''

def caracDict (s:str) -> dict:
    string = s.lower()
    dic = {}
    for i in string:
        if i not in dic:
            dic[i] = 1
        else:
            dic[i] += 1
    return dic

#Ejercicio 5 c

'''
dadosDict : Int -> Dict
Dada un numero que corresponde a las tiradas de dos dados, devuelve un diccionario cuyas claves 
son los resultados de la suma de los dados y los valores la cantidad de veces que se observa ese resultado.
'''

from random import *

def dadosDict (tiradas:int) -> dict:
    dic = {}
    while tiradas != 0:
        dado1 = randint(1,6)
        dado2 = randint(1,6)
        suma_dados = dado1 + dado2
        if suma_dados not in dic:
            dic[suma_dados] = 1
        else:
            dic[suma_dados] += 1
        tiradas -= 1
    return dic
 
#Ejercicio 6

'''
palabraLargaDict : String -> Dict
Dado un string, devuelve un diccionario que las claves son los caracteres
y los valores son la palabra mas larga en la que se encuentra.
'''

def palabraLargaDict (s:str) -> dict:
    dic = {}
    for i in s.split():
        largo = len(i)
        palabra = i.lower()
        for j in palabra:
            if j not in dic or len(dic[j]) < largo:
                dic[j] = palabra
    return dic

#Ejercicio 7 a

'''
promedioDict: Dict{String : List(Int)} -> Int
Dado un diccionario cuyas claves son string equivalentes a nombres y valores listas de numeros equivalentes a notas,
la funcion devuelve el promedio del alumno ingresado por el usuario. 
'''

def promedioDict (dic:dict) -> int:
    nombre = input("De que estudiante desea saber su promedio?: ")
    notas = dic[nombre]
    contador = 0
    i = 0
    while i<len(notas):
        contador += notas[i]
        i += 1
    promedio = contador / i
    return promedio

#Ejercicio 7 b

'''
promedioDict: Dict{String : List(Int)} -> String
Dado un diccionario cuyas claves son string equivalentes a nombres y valores listas de numeros equivalentes a notas,
la funcion devuelve el nombre del promedio mas alto.
'''

def mayorPromedioDict (dic:dict) -> str:
    mayor_promedio = 0
    alumno = 0
    for nombre, notas in dic.items():
        contador = 0
        i = 0
        for nota in notas:
            contador += nota
            i += 1
        promedio = contador / i
        if promedio > mayor_promedio:
            mayor_promedio = promedio
            alumno = nombre
    return alumno
    
#Ejercicio 8

'''
sinonimosDict : String Dict{String : List(String)} -> String
Dado un string y un diccionario cuyas claves son string correspondientes a una palabra y
sus valores son una lista de string equivalentes a sinonimos de la palabra,
la funcion devuelve un nuevo string reemplazando las palabras por sus sinonimos. Si la palabra no
tiene sinonimos, deja la original
'''

def sinonimosDict (s:str, dic:dict) -> str:
    string = s.lower().split()
    nueva_frase = []
    for palabra in string:
        if palabra in dic:
            posicion = randrange(len(dic[palabra]))
            nueva_frase.append(dic[palabra][posicion])
        else:
            nueva_frase.append(palabra)
    return " ".join(nueva_frase).capitalize()

#Ejercicio 9

'''
carritoDict : Dict{String : Int} Dict{String : Int} -> Int
Dados un diccionario cuyas claves son string correspondientes a nombres de productos y los valores numeros que corresponden
a el precio del producto, y otro diccionario cuya clave es la mismo que el primero y sus valores son numeros referentes a la 
cantidad que hay en el carrito, la funcion devuelve el monto total de la compra realizada.

'''

def carritoDict (d1:dict, d2:dict) -> int:
    monto = 0
    for producto , precio in d1.items():
        if producto in d2:
            monto += precio * d2[producto]
    return monto

#Ejercicio 10

'''
listaConjunto : List(Any) -> Set
Dada una lista de elementos, devuelve un conjunto sin los elementos duplicados.
'''

def listaConjunto (l:list) -> set:
    conjunto = set()
    for i in l:
        conjunto.add(i)
    return conjunto

#Ejercicio 11

'''
cadenasConjunto : String String -> Set
Dado dos string, devuelve un conjunto con las palabras que estan en ambos string.
'''

def cadenasConjunto (s1:str,s2:str) -> set:
    string1 = s1.lower().split()
    string2 = s2.lower().split()
    conjunto1 = set()
    conjunto2 = set()
    for i in string1:
        conjunto1.add(i)
    for k in string2:
        conjunto2.add(k)
    conjunto_interseccion = conjunto1.intersection(conjunto2)
    return conjunto_interseccion

#Ejercicio 12

'''
diferenciaSimetrica : Set{Any} Set{Any} -> Set(Any)
Dado dos conjuntos, devuelve otro conjunto que contiene los elementos que no estan en ambos.
Representacion: (A-B) U (B-A)
'''

def diferenciaSimetrica (c1:set,c2:set) -> set: 
    a_b = c1.difference(c2)
    b_a = c2.difference(c1)
    union = a_b.union(b_a)
    return union

#Ejercicio 13

'''
maxConjunto : List(Natural) -> Set{Natural}
Dada una lista desordenada de numeros naturales, la funcion calcula el maximo de la lista
y devuelve un conjunto con los numeros menores al maximo que no esten en la lista.
'''

def maxConjunto (l:list) -> set:
    maximo = max(l)
    conjunto = set()
    for i in range(maximo):
        if i not in l:
            conjunto.add(i)
    return conjunto

#Ejercicio 14

'''
reunionConjunto : Dict{String : List(String)} -> Set{String}
'''

def reunionConjunto (d:dict) -> set:
    dias = set(d[list(d.keys())[0]])
    for persona in d:
        dias_persona = set(d[persona])
        dias = dias.intersection(dias_persona)
    if not dias:
        print("No pueden asistir ningun dia.")
    else:
        return dias 