tablero = [ 
            "-", "-", "-",
            "-", "-", "-",
            "-", "-", "-"
           ]

def mostrarTablero ():
    print(tablero[0], "|", tablero[1], "|", tablero[2] , "     1 | 2 | 3")
    print(tablero[3], "|", tablero[4], "|", tablero[5] , "     4 | 5 | 6")
    print(tablero[6], "|", tablero[7], "|", tablero[8] , "     7 | 8 | 9")

def turno (jugador, ficha):

    continuar = False

    while continuar == False:
        posicion = int(input(f"{jugador} ingrese una posicion del 1 al 9: ")) - 1
        if tablero[posicion] == "-":
            continuar = True
        else: 
            print("Posicion ocupada, elija otra")

    tablero[posicion] = ficha

    mostrarTablero()

def comprobarGanador ():

    #Vertical
    if tablero[0] == tablero[1] == tablero [2] != "-":
        return tablero[0]
    if tablero[3] == tablero[4] == tablero [5] != "-":
        return tablero[3]
    if tablero[6] == tablero[7] == tablero [8] != "-":
        return tablero[6]

    #Horizontal
    if tablero[0] == tablero[3] == tablero [6] != "-":
        return tablero[0]
    if tablero[1] == tablero[4] == tablero [7] != "-":
        return tablero[1]
    if tablero[2] == tablero[5] == tablero [8] != "-":
        return tablero[2]
    
    #Oblicua

    if tablero[0] == tablero[4] == tablero [8] != "-":
        return tablero[0]
    if tablero[2] == tablero[4] == tablero [6] != "-":
        return tablero[2]
    
    return None

def comienzoJuego():

    mostrarTablero()

    jugador1 = input("Ingrese nombre del primer jugador: ")
    jugador2 = input("Ingrese nombre del segundo jugador: ")

    jugadores = [jugador1, jugador2]  
    fichas = ["X", "O"]  

    ganador = None
    
    i = 0

    while ganador == None and i < 9:  
        jugador = jugadores[i % 2]  
        ficha = fichas[i % 2] 

        turno(jugador, ficha)
        ganador = comprobarGanador()
        
        if ganador:
            print(f"Ganador {jugador}")

        i += 1

    if ganador == None:
        print("Empate")

comienzoJuego()   