import csv
import streamlit as st
import matplotlib.pyplot as plt
import random as rdm

#LEER ARCHIVO ESPACIOS CULTURALES (CSV)


def obtener_info_esp_cult(nombreArchivo: str) -> list:
    """
    - Diseño De datos: \n
        # Utilizamos un String para representar el nombre del Archivo que queremos leer, el cual contiene
           la información con los Espacios Culturales de Buenos Aires.

        nombrearchivo: String

    ---

    - Signatura Y Declaración De Propósito: \n
        obtener_info_esp_cult: String -> List

        # Dado el nombre del Archivo, la función retorna una Lista de Diccionarios en donde cada
            Diccionario contiene la información de un Espacio Cultural.
    """

    with open(nombreArchivo, encoding="utf-8") as file:
        infoEspaciosCulturales = list(csv.DictReader(file))

    return infoEspaciosCulturales


#FUNCIONES TOP BARRIOS


def cantidad_esp_cult_por_barrio(infoEspaciosCulturales: list) -> dict:
    """
    - Diseño De Datos: \n
        # Representamos la informacion de los Espacios Culturales con una Lista de Diccionarios,
            en donde cada Diccionario contiene la información de un Espacio Cutural.

        infoEspaciosCulturales: List -> List[n] = Dict,     n: Int Válido

    ---

    - Signatura Y Declaración De Propósito: \n
        cantidad_esp_cult_por_barrio: List -> Dict

        # La funcion toma una Lista con Diccionarios con la información de los Espacios Culturales \n
            y retorna un Diccionario cuyas claves son los nombres de los Barrios con Espacios Culturales \n
            y los valores son la cantidad de Espacios Culturales que hay en ese Barrio.

    ---

    - Ejemplos: \n
        cantidad_esp_cult_por_barrio([
                                      {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                                      {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                      {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}, 
                                      {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                                      {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                                      ]) = {"SAN NICOLAS": 3, "PALERMO": 2}

        cantidad_esp_cult_por_barrio([
                                      {"FUNCION_PRINCIPAL": "CALESITA", "BARRIO": "PALERMO"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "BARRIO": "PALERMO"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "BARRIO": "PALERMO"}
                                      ]) = {"PALERMO": 3}

        cantidad_esp_cult_por_barrio([
                                      {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                      {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "FLORES"}, 
                                      {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAAVEDRA"}
                                      ]) = {"CABALLITO": 1, "FLORES": 1, "SAAVEDRA": 1}
    """

    infoEspaciosPorBarrio = {}

    for espacioCultural in infoEspaciosCulturales:
        if espacioCultural["BARRIO"] != "NA":
            if espacioCultural["BARRIO"] not in infoEspaciosPorBarrio:
                infoEspaciosPorBarrio[espacioCultural["BARRIO"]] = 1

            else:
                infoEspaciosPorBarrio[espacioCultural["BARRIO"]] += 1

    return infoEspaciosPorBarrio


def generar_top10(infoEspaciosPorBarrios: dict) -> list:
    """
    - Diseño De Datos: \n
        # Representamos la informacion de los Espacios Culturales que hay por Barrio con \n
            un Diccionario, en donde las claves de los Diccionarios son los nombres de los Barrios \n
            y los valores son la cantidad de Espacios Culturales que estos tienen.

        infoEspaciosPorBarrios: Dict

    ---

    - Signatura Y Declaración De Propósito: \n
        generar_top10: Dict -> List

        # La función toma un Diccionarios con la información de la cantidad de Espacios \n
            Culturales por Barrio y devuelve una Lista de Tuplas con los 10 Barrios con más Espacios \n
            Culturales. Cada Tupla consta de 2 Componentes, siendo el primer Componente el nombre \n
            del Barrio y el segundo Componente la cantidad de Espacios Culturales que hay en ese Barrio. \n
            La Lista del Top está ordenada, siendo el primer elemento el Barrio con más cantidad de \n
            Espacios Culturales, y el último elemento el Barrio con menor cantidad de estos.

    ---

    Ejemplos:
        generar_top10({"SAN NICOLAS": 3, 
                       "PALERMO": 2, 
                       "VILLA URQUIZA": 7, 
                       "RECOLETA": 5, 
                       "MONSERRAT": 2, 
                       "CABALLITO": 1, 
                       "BELGRANO": 6, 
                       "BALVANERA": 7, 
                       "RETIRO": 4, 
                       "LINIERS": 1, 
                       "ALMAGRO": 5}) = [('VILLA URQUIZA', 7), 
                                         ('BALVANERA', 7), 
                                         ('BELGRANO', 6), 
                                         ('RECOLETA', 5), 
                                         ('ALMAGRO', 5), 
                                         ('RETIRO', 4), 
                                         ('SAN NICOLAS', 3), 
                                         ('PALERMO', 2), 
                                         ('MONSERRAT', 2), 
                                         ('CABALLITO', 1)]
    """

    listaBarriosCantidad = []

    for barrio, cantidad in infoEspaciosPorBarrios.items():
        listaBarriosCantidad.append((barrio, cantidad))

    listaBarriosCantidad.sort(key=lambda cantidad: cantidad[1], reverse=True)

    topBarrios = listaBarriosCantidad[:10]

    return topBarrios


def mostrar_tabla_top10(topBarrios: list) -> plt.figure:
    """
    - Diseño De Datos: \n
        # Representamos el Top de Barrios con más Espacios Culturales con una Lista de Tuplas, \n
            en donde cada Tupla es de la forma: (Nombre Barrio, Cant. Esp. Cult.). Siendo \n
            Nombre Barrio un String y Cant. Esp. Cult una Int.

        topBarios: List

    ---

    - Signatura Y Declaración De Propósito: \n
        mostrar_tabla_top10: List -> plt.Figure

        # La función toma el Top 10 de Barrios con más Espacios Culturales y retorna una tabla
            con el ranking.
    """

    fig, axes = plt.subplots()

    fig.set_size_inches(6, 0.01)

    tabla = plt.table(topBarrios,
                      rowLabels=[" " + str(i) + " " for i in range(1, 11)],
                      colWidths=[0.3, 0.4],
                      cellLoc="center",
                      rowLoc="center",
                      colLabels=["BARRIO", "ESPACIOS CULTURALES"],
                      loc="top").scale(1, 1.5)

    plt.box(False)  # Elimina la caja que rodea la Figura.
    ax = plt.gca()  # Obtiene los Ejes de la Figura.
    ax.get_xaxis().set_visible(False)  # Elimina el Eje X de la Figura.
    ax.get_yaxis().set_visible(False)  # Elimina el Eje Y de la Figura.

    return fig


#FUNCIONES COMUNAS


def cantidad_esp_cult_por_comuna(infoEspaciosCulturales: list) -> dict:
    """
    - Diseño De Datos: \n
        # Representamos la informacion de los Espacios Culturales con una Lista de Diccionarios,
            en donde cada Diccionario contiene la información de un Espacio Cutural.

        infoEspaciosCulturales: List -> List[n] = Dict,     n: Int Válido

    ---

    - Signatura Y Declaración De Proposito: \n
        cantidad_esp_cult_por_comuna: List -> Dict

        # La funcion toma la informacion de los Espacios Culturales y devuelve un Diccionario \n
            con la información de cuántos Espacios Culturales hay por Comuna en Buenos Aires. \n
            Las Claves de los Diccionarios son los nombres de las Comunas y los valores son la \n
            cantidad de Espacios Culturales que estos tienen. \n
            Además, el Diccionario se encuentra ordenado por los Valores de las Claves, siendo \n
            la primera Clave la que tiene más Espacios Culturales y la última llave la que menos \n
            Espacios Culturales tiene.

    ---

    - Ejemplos: \n
        cantidad_esp_cult_por_comuna([
                                      {"FUNCION_PRINCIPAL": "BAR", "COMUNA": "COMUNA 1"}, 
                                      {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO", "COMUNA": "COMUNA 2"}, 
                                      {"FUNCION_PRINCIPAL": "BAR", "COMUNA": "COMUNA 2"}, 
                                      {"FUNCION_PRINCIPAL": "ANFITEATRO", "COMUNA": "COMUNA 4"}, 
                                      {"FUNCION_PRINCIPAL": "BIBLIOTECA", "COMUNA": "COMUNA 3"}
                                      ]) = {"COMUNA 2": 2, "COMUNA 1": 1, "COMUNA 4": 1, "COMUNA 3": 1}

        cantidad_esp_cult_por_comuna([
                                      {"FUNCION_PRINCIPAL": "CALESITA", "COMUNA": "COMUNA 4"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "COMUNA": "COMUNA 4"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "COMUNA": "COMUNA 4", "BARRIO": "PALERMO"}
                                      ]) = {"COMUNA 4": 3}

        cantidad_esp_cult_por_comuna([
                                      {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "COMUNA": "COMUNA 10"}, 
                                      {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "COMUNA": "COMUNA 14"}, 
                                      {"FUNCION_PRINCIPAL": "MUSEO", "COMUNA": "COMUNA 12"}
                                      ]) = {"COMUNA 10": 1, "COMUNA 14": 1, "COMUNA 12": 1}
    """

    infoEspaciosPorComuna = {}

    for espacioCultural in infoEspaciosCulturales:
        if espacioCultural["COMUNA"] != "COMUNA NA":

            if espacioCultural["COMUNA"] not in infoEspaciosPorComuna:
                infoEspaciosPorComuna[espacioCultural["COMUNA"]] = 1

            else:
                infoEspaciosPorComuna[espacioCultural["COMUNA"]] += 1

    infoEspaciosPorComuna = dict(
        sorted(infoEspaciosPorComuna.items(), key=lambda x: x[1],
               reverse=True))

    return infoEspaciosPorComuna


def generar_listas_comunas_y_cantidad(infoEspaciosPorComuna: dict) -> tuple:
    """
    - Diseño De Datos: \n
        # Representamos la informacion de los Espacios Culturales que hay por Comuna con \n
            un Diccionario, en donde las claves de los Diccionarios son los nombres de las Comunas \n
            y los valores son la cantidad de Espacios Culturales que estas tienen.

        infoEspaciosPorComuna: Dict

    ---

    - Signatura Y Declaración De Propósito: \n
        generar_: Dict -> Tupla

        # La función toma un Diccionarios con la información de la cantidad de Espacios \n
            Culturales por Comuna y devuelve una Tupla de 2 Campos, donde el 1er Campo es una lista \n
            con el nombre de las Comunas y el 2do Campo es una Lista con la cantidad de Espacios \n
            Culturales que hay en la respectiva Comuna que ocupa la misma posición de la Lista en \n
            el 1er Campo, es decir, la cantidad de Espacios Cuturales que hay en la posición i \n
            de la Lista del 2do Campo corresponde a la Comuna que se encuentra en la posicion i \n 
            de la Lista del 1er Campo.

    ---

    - Ejemplos: \n
        generar_listas_comunas_y_cantidad({"COMUNA 11": 10, 
                                           "COMUNA 8": 6, 
                                           "COMUNA 2": 6, 
                                           "COMUNA 9": 3, 
                                           "COMUNA 1": 2}) = (["COMUNA 11", 
                                                               "COMUNA 8", 
                                                               "COMUNA 2", 
                                                               "COMUNA 9", 
                                                               "COMUNA 1"], 
                                                               [10, 6, 6, 3, 2])
    """

    listaComunas = []
    listaCantidadEspCultPorComuna = []

    for comuna, cantidad in infoEspaciosPorComuna.items():
        listaComunas.append(comuna)
        listaCantidadEspCultPorComuna.append(cantidad)

    return listaComunas, listaCantidadEspCultPorComuna


def generar_grafico_de_barras(
        listaComunas: list, listaCantidadEspCultPorComuna: list) -> plt.figure:
    """
    - Diseño De Datos: \n
        # Representamos la información de las Comunas y la cantidad de Espacios Culturales que \n
            estas tienen con 2 Listas. Una de ellas tiene el nombre de las Comunas y la otra tiene \n
            la cantidad de Espacios Culturales que hay en cada Comuna. Además, la cantidad que figura \n
            en una posición de la Lista de cantidad de Espacios Culturales corresponde a la Comuna que \n
            se encuentra en esa misma posicion pero en la Lista de los nombres de las Comunas.

        listaComunas: List

        listaCantidadEspCultPorComuna: List

    ---

    - Signatura Y Declaración De Propósito: \n
        generar_grafico_de_barras: List List -> plt.Figure

        # Dadas dos Listas con las propiedad enunciadas en el Diseño De Datos, la función retorna un \n
            gráfico de barras horizontal, donde en el Eje Vertical se encuentran los nombres de las \n
            Comunas y en el Eje Horizontal se encuentran las cantidades de Espacios Culturales.
    """

    fig, ax = plt.subplots(figsize=(10, 4))

    ax.barh(listaComunas, listaCantidadEspCultPorComuna)

    ax.set_xlabel('Cantidad')
    ax.set_ylabel('Comunas')

    return fig


#FUNCIONES TIPO DE ESPACIO CULTURAL


def generar_lista_funciones_principales(infoEspaciosCulturales: list) -> list:
    """
    - Diseño De Datos: \n
        # Representamos la informacion de los Espacios Culturales con una Lista de Diccionarios,
            en donde cada Diccionario contiene la información de un Espacio Cutural.

        infoEspaciosCulturales: List -> List[n] = Dict,     n: Int Válido

    ---

    - Signatura Y Declaración De Propósito: \n
        generar_lista_funciones_principales: List -> List

        # La funcion toma una Lista con Diccionarios con la información de los Espacios Culturales \n
            y retorna una Lista con las Funciones Principales de los Espacios Culturales.

    ---

    - Ejemplos: \n
        generar_lista_funciones_principales([
                                      {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                                      {"FUNCION_PRINCIPAL": "TEATRO"}, 
                                      {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO", "COMUNA": "COMUNA 1"}, 
                                      {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                                      {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                                      ]) = ["BAR", "TEATRO", "ANFITEATRO", "BIBLIOTECA"]

        generar_lista_funciones_principales([
                                      {"FUNCION_PRINCIPAL": "CALESITA"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "COMUNA": "COMUNA 13"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "BARRIO": "SAN NICOLAS"}
                                      ]) = ["CALESITA", "LIBRERIA"]

        generar_lista_funciones_principales([
                                      {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                      {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "FLORES"}, 
                                      {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAAVEDRA"}
                                      ]) = ["ESPACIO DE FORMACION", "GALERIA DE ARTE", "MUSEO"]
    """

    listaFuncionesPrincipales = []

    for espacioCultural in infoEspaciosCulturales:
        if espacioCultural[
                "FUNCION_PRINCIPAL"] not in listaFuncionesPrincipales:
            listaFuncionesPrincipales.append(
                espacioCultural["FUNCION_PRINCIPAL"])

    return listaFuncionesPrincipales


#FUNCIONES MAPA


def obtener_latitud_longitud(infoEspaciosCulturales: list) -> dict:
    """
    - Diseño De Datos: \n
        # Representamos la informacion de los Espacios Culturales con una Lista de Diccionarios,
            en donde cada Diccionario contiene la información de un Espacio Cutural.

        infoEspaciosCulturales: List -> List[n] = Dict,     n: Int Válido

    ---

    - Signatura Y Declaración De Propósito: \n
        obtener_longitud_latitud: List -> Dict

        # La funcion toma una Lista con Diccionarios con la información de los Espacios Culturales \n
            y retorna un Diccionario con dos Claves. La 1ra Clave tiene como valor las Latitudes de \n
            todos los Espacios Culturales, y la 2da Clave tiene como valor sus respectivas Longitudes.

    ---

    - Ejemplos: \n
        obtener_latitud_longitud([
                                   {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS", "LATITUD": "1.1", "LONGITUD": "2.3"}, 
                                   {"FUNCION_PRINCIPAL": "TEATRO", "LATITUD": "1.7", "LONGITUD": "3.2"}, 
                                   {"FUNCION_PRINCIPAL": "BAR", "LATITUD": "1.1", "LONGITUD": "4.43"}, 
                                   {"FUNCION_PRINCIPAL": "ANFITEATRO", "LATITUD": "1.0", "LONGITUD": "5.0"}, 
                                   {"FUNCION_PRINCIPAL": "BIBLIOTECA", "LATITUD": "0.0", "LONGITUD": "0.0"}
                                   ]) = {"LAT": [1.1, 1.7, 1.1, 1.0, 0.0], 
                                         "LON": [2.3, 3.2, 4.43, 5.0, 0.0]}

        obtener_latitud_longitud([
                                   {"FUNCION_PRINCIPAL": "CALESITA", "LATITUD": "1.0", "LONGITUD": "1.0"}, 
                                   {"FUNCION_PRINCIPAL": "LIBRERIA", "BARRIO": "PALERMO", "LATITUD": "2.0", "LONGITUD": "2.0"}, 
                                   {"FUNCION_PRINCIPAL": "LIBRERIA", "LATITUD": "3.0", "LONGITUD": "3.0"}
                                   ]) = {"LAT": [1.0, 2.0, 3.0], 
                                         "LON": [1.0, 2.0, 3.0]}

        obtener_latitud_longitud([
                                   {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "LATITUD": "1.1", "LONGITUD": "2.2"}, 
                                   {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "LATITUD": "3.3", "LONGITUD": "4.4"}
                                   ]) = {"LAT": [1.1, 3.3], 
                                         "LON": [2.2, 4.4]}
    """

    dictLatitudLongitud = {"LAT": [], "LON": []}

    for espacioCultural in infoEspaciosCulturales:
        if espacioCultural["LATITUD"] not in [
                'NA', ''
        ] and espacioCultural["LONGITUD"] not in ['NA']:
            dictLatitudLongitud["LAT"].append(float(
                espacioCultural["LATITUD"]))
            dictLatitudLongitud["LON"].append(
                float(espacioCultural["LONGITUD"]))

    return dictLatitudLongitud


def filtrar_por_barrio(infoEspaciosCulturales: list,
                       barrioSeleccionado: str) -> list:
    """
    - Diseño De Datos: \n
        # La información de los Espacios Culturales la representamos con una Lista de Diccionarios, \n
            en donde cada Diccionario contiene los datos de un Espacio Cultural. El Barrio Seleccionado \n
            es representado con una cadena de caracteres (String) que es igual al nombre del mismo.

        infoEspaciosCulturales: List

        barrioSeleccionado: String

    ---

    - Signatura Y Declaración De Propósito: \n
        filtrar_por_barrio: List String -> List

        # Dada la información de los Espacios Culturales y el nombre de un Barrio, se creará una Lista de \n
            Diccionarios, en donde cada Diccionario contiene los datos de un Espacio Cultural que \n
            pertenezca al Barrio Seleccionado. \n
            Si el Barrio Seleccionado es "NINGUNO", se retornará toda la información de los Espacios \n
            Culturales, sin filtrar por el Barrio.

    ---

    - Ejemplos: \n
        filtrar_por_barrio([
                            {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                            {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                            {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO", "COMUNA": "COMUNA 1"}, 
                            {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                            {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                            ], 
                            "SAN NICOLAS") = [{"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                                              {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                                              {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}]

        filtrar_por_barrio([
                            {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                            {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                            {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}, 
                            {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                            {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                            ], 
                            "PALERMO") = [{"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                              {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}]

        filtrar_por_barrio([
                            {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                            {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "FLORES"}, 
                            {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAAVEDRA"}
                            ], 
                            "NINGUNO") = [{"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                          {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "FLORES"}, 
                                          {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAAVEDRA"}]
    """

    if barrioSeleccionado != "NINGUNO":
        espaciosFiltradosPorBarrio = []

        for espacioCultural in infoEspaciosCulturales:
            if espacioCultural["BARRIO"] == barrioSeleccionado:
                espaciosFiltradosPorBarrio.append(espacioCultural)

    else:
        espaciosFiltradosPorBarrio = infoEspaciosCulturales

    return espaciosFiltradosPorBarrio


def filtrar_por_funcion_principal(espaciosFiltradosPorBarrio: list,
                                  funcPrincSeleccionada: str) -> list:
    """
    - Diseño De Datos: \n
        # La información de los Espacios Culturales filtrados por Barrio la representamos con una Lista \n
            de Diccionarios, en donde cada Diccionario contiene los datos de un Espacio Cultural. \n
            La Función Principal Seleccionada es representada con un String que es igual al nombre \n
            de la misma.

        espaciosFiltradosPorBarrio: List

        funcPrincSeleccionada: String

    ---

    - Signatura Y Declaración De Propósito: \n
        filtrar_por_funcion_principal: List String -> List

        # Dada la información de los Espacios Culturales en un determinado Barrio y una Función \n
            Principal, se creará una Lista de Diccionarios, en donde cada Diccionario contiene los datos \n
            de un Espacio Cultural cuya Función Principal sea igual a la Función Principal Seleccionada. \n
            Si la Funcion Principal Seleccionada es "NINGUNA", se retornará toda la información de los 
            Espacios Culturales que haya en ese Barrio, sin filtrar por la Función Principal.

    ---

    - Ejemplos: \n
        filtrar_por_funcion_principal([
                                        {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                                        {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                                        {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                                        ], 
                                        "BAR") = [{"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}]

        filtrar_por_funcion_principal([
                                        {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                        {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}, 
                                        {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "PALERMO"}, 
                                        {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}, 
                                        {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                        {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}
                                        ], 
                                        "TEATRO") = [{"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                                     {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                                     {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}]

        filtrar_por_funcion_principal([
                                        {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                        {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "CABALLITO"}, 
                                        {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "CABALLITO"}
                                        ], 
                                        "NINGUNA") = [{"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                                      {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "CABALLITO"}, 
                                                      {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "CABALLITO"}]
    """

    if funcPrincSeleccionada != "NINGUNA":
        espaciosFiltradosPorFuncPrinc = []

        for espacioCultural in espaciosFiltradosPorBarrio:
            if espacioCultural["FUNCION_PRINCIPAL"] == funcPrincSeleccionada:
                espaciosFiltradosPorFuncPrinc.append(espacioCultural)

    else:
        espaciosFiltradosPorFuncPrinc = espaciosFiltradosPorBarrio

    return espaciosFiltradosPorFuncPrinc


def mostrar_mapa(infoEspaciosCulturales: list, barrioSeleccionado: str,
                 funcPrincSeleccionada: str) -> None:
    """
    - Diseño De Datos: \n
        # Representamos la información de los Espacios Culturales con una Lista de Diccionarios, \n
            en donde cada Diccionario contiene los datos de un Espacio Cultural. El Barrio Seleccionado y \n
            la Función Principal Seleccionada son representados con una cadena de caracteres (String) que \n
            es igual a sus respectivos nombres.

        infoEspaciosCulturales: List

        barrioSeleccionado: String

        funcPrincSeleccionada: String

    ---

    - Signatura Y Declaración De Propósito: \n
        mostrar_mapa: List String String -> None

        # Dada la información de los Espacios Culturales, el nombre de un Barrio y una Función Principal, \n
            se mostrará en un mapa los Espacios Culturales en ese Barrio y que cumplan esa Función \n
            Principal. En caso de no haber ningunocon dichas características, se mostrará un mensaje \n
            de advrtencia.
    """

    espaciosFiltradosPorBarrio = filtrar_por_barrio(infoEspaciosCulturales,
                                                    barrioSeleccionado)
    espaciosFiltradosPorFuncPrinc = filtrar_por_funcion_principal(
        espaciosFiltradosPorBarrio, funcPrincSeleccionada)

    if espaciosFiltradosPorFuncPrinc == []:
        st.warning(
            "No hay Espacios Culturales de ese tipo disponibles en esta área.",
            icon="⚠️")

    else:
        coordenadas = obtener_latitud_longitud(espaciosFiltradosPorFuncPrinc)
        st.map(coordenadas, size=3)


#FUNCION TABLA MAPA


def contar_todos_los_esp_cult_en_barrio(infoEspaciosCulturales,
                                        barrioSeleccionado):
    """
    - Diseño De Datos: \n
        # La información de los Espacios Culturales la representamos con una Lista de Diccionarios, \n
            en donde cada Diccionario contiene los datos de un Espacio Cultural. El Barrio Seleccionado \n
            es representado con una cadena de caracteres (String) que es igual al nombre del mismo.

        infoEspaciosCulturales: List

        barrioSeleccionado: String

    ---

    - Signatura Y Declaración De Propósito: \n
        contar_todos_los_esp_cult_en_barrio: List String -> List

        # Dada la información de los Espacios Culturales y el nombre de un Barrio, se creará una Lista de \n
            Tuplas con 2 Campos, en donde el 1er Campo es la Función Principal de algún Espacio Cultural \n
            que haya en el Barrio, mientras que el 2do Campo es la cantidad de ese tipo de Espacio Cultural \n
            que hay en total en el Barrio. \n
            La Lista se encuentra ordenada de mayor a menor en función de la cantidad total de \n
            establecimientos que tenga cada Espacio Cultural.

    ---

    - Ejemplos: \n
        contar_todos_los_esp_cult_en_barrio([
                                              {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                                              {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                              {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO", "COMUNA": "COMUNA 1"}, 
                                              {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                                              {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                                              ], 
                                              "SAN NICOLAS") = [("BAR", 1), ("ANFITEATRO", 1), ("BIBLIOTECA", 1)]

        contar_todos_los_esp_cult_en_barrio([
                                              {"FUNCION_PRINCIPAL": "CALESITA", "BARRIO": "FLORES"}, 
                                              {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}, 
                                              {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                              {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAN NICOLAS"}, 
                                              {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}
                                              ], 
                                              "PALERMO") = [("TEATRO", 2), ("BAR", 1)]

        contar_todos_los_esp_cult_en_barrio([
                                              {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                              {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "FLORES"}, 
                                              {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAAVEDRA"}
                                              ], 
                                              "CABALLITO") = [("ESPACIO DE FORMACION", 1)]
    """

    espaciosEnBarrio = {}

    for espacioCultural in infoEspaciosCulturales:
        if espacioCultural["BARRIO"] == barrioSeleccionado:
            if espacioCultural["FUNCION_PRINCIPAL"] in espaciosEnBarrio:
                espaciosEnBarrio[espacioCultural["FUNCION_PRINCIPAL"]] += 1

            else:
                espaciosEnBarrio[espacioCultural["FUNCION_PRINCIPAL"]] = 1

    resultadoOrdenado = sorted(espaciosEnBarrio.items(),
                               key=lambda x: x[1],
                               reverse=True)

    return resultadoOrdenado


def mostrar_tabla_espacios_por_barrio(espaciosEnBarrio: list) -> plt.figure:
    """
    - Diseño De Datos: \n
        # Representamos los Espacios Culturales de cada tipo que hay en un determinado Barrio con una \n
            Lista de Tuplas con 2 Campos cada una, en donde el 1er Campo es la Función Principal de algún \n
            Espacio Cultural que haya en el Barrio, mientras que el 2do Campo es la cantidad de ese tipo \n
            de Espacio Cultural que hay en total en el Barrio. 

            espaciosEnBarrio: List

    ---

    - Signatura Y Declaración De Propósito: \n
        mostrar_tabla_espacios_por_barrio: List -> plt.Figure

        # La función toma como argumento una Lista de Tuplas con la información de la cantidad de \n
            Espacios Culturales totales de cada tipo que hay en un Barrio dado. Luego, muestra una \n
            tabla con esa información.
    """

    fig, axes = plt.subplots()

    fig.set_size_inches(6, 0.01)

    tabla = plt.table(espaciosEnBarrio,
                      cellLoc="center",
                      colWidths=[0.6, 0.2],
                      rowLoc="center",
                      colLabels=["ESPACIOS CULTURALES", "CANTIDAD"],
                      loc="best").scale(1.3, 2.3)

    plt.box(False)  # Elimina la caja que rodea la Figura.
    ax = plt.gca()  # Obtiene los Ejes de la Figura.
    ax.get_xaxis().set_visible(False)  # Elimina el Eje X de la Figura.
    ax.get_yaxis().set_visible(False)  # Elimina el Eje Y de la Figura.

    return fig


#FUNCION REDES SOCIALES


def obtener_redes_sociales(infoEspaciosCulturales: list) -> tuple:
    """
    - Diseño De Datos: \n
        # Representamos la informacion de los Espacios Culturales con una Lista de Diccionarios,
            en donde cada Diccionario contiene la información de un Espacio Cutural.

        infoEspaciosCulturales: List -> List[n] = Dict,     n: Int Válido

    ---

    - Signatura Y Declaración De Propósito: \n
        obtener_redes:sociales: List -> Tuple

        # Dada la información de los Espacios Culturales, la función crea un Diccionario cuyas Claves son \n
            los nombres de los Establecimientos y los Valores son Listas con las Redes Sociales de los \n
            Espacios Culturales, y también crea una Lista cuyos elementos son solo los nombres de los \n
            Establecimientos. Finalmente, retorna una Tupla con 2 Componentes, el Diccionario y la Lista \n
            creados, respectivamente. \n
            Solamente los Espacios Culturales con todas las posibles Redes Sociales son considerados.

    ---

    - Ejemplos: \n
        obtener_redes_sociales([{
        "ESTABLECIMIENTO": "BAR 1",
        "FACEBOOK": "https://www.facebook.com/BAR1/",
        "TWITTER": "@BAR1",
        "INSTAGRAM": "@EL_BAR_1"
    }, {
        "ESTABLECIMIENTO": "BAR 2",
        "FACEBOOK": "https://www.facebook.com/BAR2/",
        "TWITTER": "",
        "INSTAGRAM": "@EL_BAR_2"
    }, {
        "ESTABLECIMIENTO": "TEATRO 1",
        "FACEBOOK": "",
        "TWITTER": "",
        "INSTAGRAM": ""
    }, {
        "ESTABLECIMIENTO": "BIBLIOTECA 1",
        "FACEBOOK": "",
        "TWITTER": "@BIBLIOTECA1",
        "INSTAGRAM": "@LA_BIBLIOTECA_1"
    }, {
        "ESTABLECIMIENTO": "TEATRO 2",
        "FACEBOOK": "https://www.facebook.com/TEATRO2/",
        "TWITTER": "@TEATRO2",
        "INSTAGRAM": "@EL_TEATRO_2"
    }]) = ({
        'BAR 1': ['https://www.facebook.com/BAR1/', '@BAR1', '@EL_BAR_1'],
        'TEATRO 2':
        ['https://www.facebook.com/TEATRO2/', '@TEATRO2', '@EL_TEATRO_2']
    }, ['BAR 1', 'TEATRO 2'])
    """

    redesSociales = {}
    establecimientos = []

    for espacioCultural in infoEspaciosCulturales:
        if espacioCultural["FACEBOOK"] != '' and espacioCultural[
                "TWITTER"] != '' and espacioCultural["INSTAGRAM"] != '':

            redesSociales[espacioCultural["ESTABLECIMIENTO"]] = [
                espacioCultural["FACEBOOK"], espacioCultural["TWITTER"],
                espacioCultural["INSTAGRAM"]
            ]
            establecimientos.append(espacioCultural["ESTABLECIMIENTO"])

    return redesSociales, establecimientos


def redes_sociales_aleatorias(redesSociales: dict,
                              establecimientos: list) -> dict:
    """
    - Diseño De Datos: \n
        # Representamos los Espacios Culturales con Redes Sociales con un Diccionario cuyas Claves son \n
            los nombres de los Establecimientos y los Valores son Listas con las Redes Sociales de los \n
            Espacios Culturales, y a los Establecimientos con una Lista cuyos elementos son solo los \n
            nombres de los respectivos Establecimientos.

        redesSociales: Dict

        establecimientos: List

    ---

    - Signatura Y Declaración De Propósito: \n
        redes_sociales_aleatorias: Dict List -> Dict

        # La función toma la información de los Espacios Culturales con todas las posibles Redes Sociales \n
            y el nombre de sus respectivos Establecimientos y genera un Diccionario con (a lo sumo) 5 \n
            Espacios Culturales aleatorios obtenidos de la información pasada como argumento.
    """

    dictRedesRandom = {}

    for _ in range(5):
        numeroRDM = rdm.randint(0, len(establecimientos) - 1)
        establecimientoRDM = establecimientos[numeroRDM]

        dictRedesRandom[establecimientoRDM] = redesSociales[establecimientoRDM]

    return dictRedesRandom


def mostrar_tabla_redes_sociales(dictRedes: dict) -> None:
    """
    - Diseño De Datos: \n
        # Representamos los Espacios Culturales con Redes Sociales con un Diccionario cuyas Claves son \n
            los nombres de los Establecimientos y los Valores son Listas con las Redes Sociales de los \n
            Espacios Culturales

        dictRedes: dict

    ---

    - Signatura Y Declaración De Propósito: \n
        mostrar_tabla_redes_sociales: Dict -> None

        # La función toma la información de los Espacios Culturales con todas las posibles Redes Sociales \n
            y enseña una Tabla mostrando los nombres de dichos Establecimientos junto a sus Redes Sociales.
    """

    boton = st.button("COMENZAR!!", type="primary")

    if boton:
        st.table(dictRedes)


#MAIN


def main():

    nombreArchivo = 'espacios-culturales.csv'
    infoEspaciosCulturales = obtener_info_esp_cult(nombreArchivo)

    #CONFIGURACION PAGINA

    st.set_page_config(layout="wide")
    st.title("¡DISFRUTÁ DE UNAS :blue[_VACACIONES_] EN BS.AS :sunglasses:!")
    col1, col2, col3 = st.columns([1, 1, 0.6])

    #TABLA TOP 10

    infoEspaciosPorBarrio = cantidad_esp_cult_por_barrio(
        infoEspaciosCulturales)
    topBarrios = generar_top10(infoEspaciosPorBarrio)

    #COMUNAS

    infoEspaciosPorComuna = cantidad_esp_cult_por_comuna(
        infoEspaciosCulturales)
    listaComunas, listaCantidadEspCultPorComuna = generar_listas_comunas_y_cantidad(
        infoEspaciosPorComuna)

    #ESPACIOS CULTURALES

    funcionesPrincipales = generar_lista_funciones_principales(
        infoEspaciosCulturales)

    #REDES SOCIALES

    redesSociales, establecimientos = obtener_redes_sociales(
        infoEspaciosCulturales)
    dictRedes = redes_sociales_aleatorias(redesSociales, establecimientos)

    #COLUMNA 1

    with col1:

        #TITULO PAGINA

        st.title("ESPACIOS CULTURALES BUENOS AIRES")

        #FILTRO POR BARRIO

        barrioSeleccionado = st.selectbox(
            "Filtrar por Barrio",
            ["NINGUNO"] + [barrio for barrio in infoEspaciosPorBarrio])

        #FILTRO POR TIPO DE ESPACIO CULTURAL

        funcPrincSeleccionada = st.selectbox(
            "Filtrar por Espacio Cultural", ["NINGUNA"] + funcionesPrincipales)

        #TOP 10 BARRIOS

        st.subheader("Top 10 Barrios Con Más Espacios Culturales")
        fig = mostrar_tabla_top10(topBarrios)
        st.pyplot(fig)

        #COLUMNA 2

    with col2:

        #MAPA BS AS

        st.subheader("MAPA BUENOS AIRES")
        mostrar_mapa(infoEspaciosCulturales, barrioSeleccionado,
                     funcPrincSeleccionada)

        #GRAFICO DE TORTA ESPACIOS CULTURALES POR COMUNA

        st.subheader("DISTRIBUCCION DE ESPACIOS CULTURALES POR COMUNA")
        graficoDeBarras = generar_grafico_de_barras(
            listaComunas, listaCantidadEspCultPorComuna)
        st.pyplot(graficoDeBarras)

    with col3:

        #TABLA CANTIDAD DE ESPACIOS SEGUN EL FILTRO

        st.subheader("ESPACIOS POR BARRIO")
        if barrioSeleccionado != "NINGUNO":
            espaciosEnBarrio = contar_todos_los_esp_cult_en_barrio(
                infoEspaciosCulturales, barrioSeleccionado)
            fig = mostrar_tabla_espacios_por_barrio(espaciosEnBarrio)
            st.pyplot(fig)

        else:
            st.warning("Seleccione un barrio", icon="⚠️")

    st.subheader("DEJA TUS VACACIONES AL AZAR!!")
    mostrar_tabla_redes_sociales(dictRedes)


if __name__ == '__main__':
    main()