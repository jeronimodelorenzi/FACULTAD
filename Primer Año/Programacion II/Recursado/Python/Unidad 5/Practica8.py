#Ejercicio 1

def posicionesMultiplos(l,n):
    lista = []
    for i in range(len(l)):
        if i % n == 0:
            lista.append(l[i])
    return lista

#Ejercicio 2

def suma_acumulada(l):
    lista = []
    suma = 0
    for i in l:
        suma += i
        lista.append(suma)
    return lista

#Ejercicio 3

def elimina(l):
    lista = []
    for i in range(1,len(l)-1):
        lista.append(l[i])
    return lista

#Ejercicio 4

def ordenada(l):
    cond = True
    for i in range(len(l)-1):
        if l[i] > l[i+1]:
            cond = False
    return cond

#Ejercicio 5

def duplicado(l):
    cond = False
    for i in range(len(l)):
        for j in range(i+1,len(l)):
            if l[i] == l[j]:
                cond = True
    return cond

#Ejercicio 6

def my_sort(l):
    lista = []
    for i in range(len(l)):
        for j in range(i,len(l)):
            if l[i] > l[j]:
                aux=l[i]
                l[i] = l[j]
                l[j] = aux
    return l

def eliminaDuplicado(l):
    lista_final = []
    if duplicado(l):
        lista = my_sort(l)
        for i in lista:
            if i not in lista_final:
                lista_final.append(i)
        return lista_final
    else:
        return l

def distintos(l):
    cont = 0
    lista = eliminaDuplicado(l)
    for i in lista:
        cont += 1
    return cont

def busquedaDicotomica(l,x):
    lista = my_sort(l)
    fin = len(l)
    inicio = 0
    encontrado = False
    while inicio <= fin and not encontrado:
        medio = (fin - inicio)//2
        if x == lista[medio]:
            encontrado = True
        if x < lista[medio]:
            fin = medio + 1
        if x > lista[medio]:
            inicio = medio + 1
    return encontrado