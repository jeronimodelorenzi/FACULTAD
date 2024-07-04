# EJERCICIO 21




"""
Dada una nota de parcial, determina la condicion del alumno
criterio_aprobacion: float -> str
"""
def criterio_aprobacion(nota: float) -> str:
    """
    Desde la version 3.5 Python permite el anotado de tipos para funciones y variables.
    Recordar que Python es un lenguaje no tipado, es decir, los tipos se calculan en run-time infiriendolos.
    Lo que nosotros escribamos como Type-hints o Type-annotations no van a ser garantias aplicadas por Python.
    Sirven para documentar y hacer el codigo mas legible. Es llevar parte de la receta a nivel código.
    """
    condicion: str = ""
    if nota < 1 and nota > 10:
        condicion = "Nota invalida. Fuera de rango."
    elif 1 <= nota < 4:
        condicion = "Insuficiente"
    elif 4 <= nota < 6:
        condicion = "No Aprobado"
    elif 6 <= nota < 8:
        condicion = "Aprobado"
    elif 8 <= nota < 10:
        condicion = "Muy Bueno"
    else:
        condicion = "Excelente"
    
    return condicion

def test_criterio_aprobacion():
    assert criterio_aprobacion(0) == "Nota invalida. Fuera de rango."
    assert criterio_aprobacion(10) == "Excelente"
    assert criterio_aprobacion(3.99) == "Insuficiente"
    assert criterio_aprobacion(4.75) == "No aprobado"
    assert criterio_aprobacion(7.3333333333333) == "Aprobado"
    assert criterio_aprobacion(9.648273469012843) == "Muy bueno"

def main1():
    """
    Cuando realizamos un ciclo definido y la variable de iteración no aporta a la resolucion del problema
    o no agrega información relevante Python permite ignorar variables utilizando '_'. Es decir, al no darle nombre
    luego no podemos hacer referencia a dicha variable. A veces conviene para no definir variables que no se van a utilizar
    y "contaminar" de nombres innecesarios nuestro código.
    """
    for _ in range(23):
        nota: float = float(input("Ingrese la nota del parcial: "))
        print(f"Condicion: {criterio_aprobacion(nota)}")

if __name__ == "__main__":
    main1()


# Ejercicio 22

# Apartado a)
"""
Ahora nuestro programa debe clasificar 10 notas en vez de 23. Ademas por cada alumno, la nota se obtendra a partir del
promedio de otras 3 notas de parciales anteriores.
¿Debemos modificar mucho nuestro programa anterior para cumplir con los nuevos requerimientos? ¿Hay logica que podemos
abstraer en funciones? 
"""

def main2():
    for _ in range(10):
        nota1: float = float(input("Ingrese la nota del parcial 1: "))
        nota2: float = float(input("Ingrese la nota del parcial 2: "))
        nota3: float = float(input("Ingrese la nota del parcial 3: "))
        nota = (nota1 + nota2 + nota3)/3
        print(f"Condicion: {criterio_aprobacion(nota)}")

"""
Una primera aproximación podria ser la siguiente. ¿Se puede mejorar? ¿Qué tanto cambio cuando habia que calificar 23 notas individuales?
"""

# Apartado b)
"""
Ahora se nos piden mas modificaciones. ¿Qué pasa cuando varia la cantidad de parciales que afectan al promedio? ¿Hay algo del código escrito
que podría convertirse en una función?
Empecemos por identificar las 3 partes que componen cada iteración del ciclo.
1. Toma de datos (se ingresan los parciales)
2. Se calcula el promedio
3. Se informa la condicion del alumno.
Veamos como se transforma esto en código
"""

def ingreso_parciales(cantidad:int) -> float:
    suma_parciales: float = 0
    for i in range(1, cantidad + 1):
        parcial: float = float(input(f"Ingrese la nota del parcial {i}: "))
        suma_parciales += parcial
    promedio: float = suma_parciales / cantidad
    return promedio

"""
Por el momento vamos a condensar las partes 1. y 2. en una unica función. Por ahora no tenemos manera de almacenar todos los
parciales y luego calcular su suma, lo veremos en una Unidad de la materia más adelante.
Tener en cuenta que asumimos que la cantidad de parciales es siempre mayor a 1. Si es cero el programa se rompería.
Para pensar: es esta función testeable? Podemos escribir distintos casos de prueba variando la cantidad de notas?
"""

def main3():
    cantidad_parciales = int(input("Cuantos notas hubo en el cuatrimestre? "))
    if (cantidad_parciales >= 1):
        for _ in range(10):
            nota = ingreso_parciales(cantidad_parciales)
            print(f"Condicion: {criterio_aprobacion(nota)}")
    else:
        print("La cantidad de notas por cuatrimestre debe ser mayor a 1")

"""
Debemos solicitar al usuario cuántas notas por alumno van a ser ingresadas.
Agregamos la validación de la cantidad ingresada. Con esto esta garantizando lo que asumimos en la funcion ingreso_parciales.
¿Lo podríamos haber hecho dentro la función? ¿Que debería retornar en caso de una cantidad invalida? ¿Cuál sería su signatura?
El paso 3. no requiere ser abstraida a una función. Es un print informando la condición final.
Preferible mantener el print simple (la salida del programa) en la función main.
"""

# Apartado c)
"""
Por último, se nos pide tener en cuenta que la cantidad de alumnos también puede variar. ¿Implica hacer otra función?
"""

def calificar_alumnos(cantidad_alumnos: int, cantidad_parciales: int) -> None:
    for _ in range(cantidad_alumnos):
        nota = ingreso_parciales(cantidad_parciales)
        print(f"Condicion: {criterio_aprobacion(nota)}")

def main4():
    cantidad_alumnos = int(input("Cuantos alumnos hay que clasificar? "))
    # Hace falta verificar si la cantidad de alumnos es mayor a 0?
    cantidad_parciales = int(input("Cuantos notas hubo en el cuatrimestre? "))
    if (cantidad_parciales >= 1):
        calificar_alumnos(cantidad_alumnos, cantidad_parciales)
    else:
        print("La cantidad de notas por cuatrimestre debe ser mayor a 1")

"""
Posible solución. Nuevamente abstraemos el argumento de cantidad de alumnos y hacemos una función.
Esta función solo hace el for, que dentro llama a ingreso_parciales donde se cargan las notas del cuatrimestre.
La función main pide al usuario las cantidades de alumnos y parciales y simplemente llama a calificar_alumnos.
Otra opción podría haber sido
"""

def main5():
    cantidad_alumnos = int(input("Cuantos alumnos hay que clasificar? "))
    cantidad_parciales = int(input("Cuantos notas hubo en el cuatrimestre? "))
    if (cantidad_parciales >= 1):
        for _ in range(cantidad_alumnos):
            nota = ingreso_parciales(cantidad_parciales)
            print(f"Condicion: {criterio_aprobacion(nota)}")
    else:
        print("La cantidad de notas por cuatrimestre debe ser mayor a 1")