def ej():
    n = int(input("Cantidad de viajes "))
    m = int(input("Cantidad de oficinas "))
    cantTrabajadores = []
    cantAlfajores = []
    
    for i in range(n):
        A_n = int(input(f"Cantidad de alfajores en el viaje {i+1} "))
        cantAlfajores.append(A_n)
    
    for i in range(m):
        E_m = int(input(f"Cantidad de trabajadores en la oficina {i+1} "))
        cantTrabajadores.append(E_m)
    
    for i in range(n):
        alfajores = cantAlfajores[i]
        for j in range(m):
            personas = cantTrabajadores[j]
            if alfajores >= personas:
                alfajores = alfajores - (personas * (alfajores//personas))
        print(alfajores, end=' ')

def ej2():
    n = int(input("cantidad de lineas "))
    tablero = []
    fichas = 0
    for i in range(n):
        tab = input("tablero ").split()
        tablero.append(tab)

    
    for fila in tablero:
        cont_igual = 0
        for casilla in fila:
            if casilla == 'N':
                cont_igual += 1
                if cont_igual % 2 == 0:
                    fichas += 1
                    cont_igual = 0
            else:
                cont_igual = 0

    print(tablero)
    print(fichas)

