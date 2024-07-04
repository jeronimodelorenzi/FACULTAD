'''
nota: int ([1,10])
calificar_nota: int -> str
Dada una nota representada por un numero natural entre el 1 y el 10 , retorna la condición de la nota.
Si esta entre [1,4) es insuficente, [4,6) es no aprobada, [6,8) es aprobada, [8,10) es muy buena, 10 es excelente.
calificar_nota(2) = 'Insuficiente'
calificar_nota(6) = 'Aprobado'
calificar_nota(10) = 'Excelente'
'''

def calificar_nota(nota):
    if nota >=1 and nota < 4:
        condicion = "Insuficiente"
    elif nota < 6:
        condicion =  "No Aprobado"
    elif nota < 8:
        condicion =  "Aprobado"
    elif nota < 10:
        condicion =  "Muy Bueno"
    else:
        condicion =  "Excelente"
    return condicion

def test_calificar_nota():
    assert(calificar_nota(2) == 'Insuficiente')
    assert(calificar_nota(6) == 'Aprobado')
    assert(calificar_nota(10) == 'Excelente')

'''
alumnos: int
parciales: int
notas_promedio: int int -> None
Dada la cantidad de alumnos y de parciales, calcula el promedio del alumno y devuelve en pantalla
la condicion del alumno.
'''

def notas_promedio(alumnos,parciales):
    for alumno in range(alumnos):
        suma_nota = 0
        for calificacion in range(parciales):
            nota = float(input(f"Ingrese la nota {calificacion+1} del alumno {alumno+1}: "))
            suma_nota += nota
        promedio = suma_nota / parciales
        condicion = calificar_nota(promedio)
        print(f"La condición del alumno {alumno+1} es: {condicion}")

def main():
    alumnos = int(input("Ingrese la cantidad de alumnos a evaluar: "))
    parciales = int(input("Ingrese la cantidad de parciales que tomó:"))
    notas_promedio(alumnos,parciales)

if __name__ == '__main__':
    main()

