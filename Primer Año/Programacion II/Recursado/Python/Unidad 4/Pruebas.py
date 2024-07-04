def puntaje_alien(color):
    if color == 'amarillo':
        puntos = 5
    elif color == 'verde':
        puntos = 10
    elif color == 'rojo':
        puntos = 15
    else:
        puntos = 0
    return puntos

def solo_if(color):
    puntos = 0
    if color == 'amarillo':
        puntos = 5
    if color == 'verde':
        puntos = 10
    if color == 'rojo':
        puntos = 15
    return puntos