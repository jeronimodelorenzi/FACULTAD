from main import *

#CANTIDAD_ESP_CULT_POR_BARRIO

def test_cantidad_esp_cult_por_barrio():
    assert(cantidad_esp_cult_por_barrio([
                                      {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                                      {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                      {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}, 
                                      {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                                      {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                                      ]) == {"SAN NICOLAS": 3, "PALERMO": 2})

    assert(cantidad_esp_cult_por_barrio([
                                      {"FUNCION_PRINCIPAL": "CALESITA", "BARRIO": "PALERMO"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "BARRIO": "PALERMO"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "BARRIO": "PALERMO"}
                                      ]) == {"PALERMO": 3})

    assert(cantidad_esp_cult_por_barrio([
                                      {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                      {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "FLORES"}, 
                                      {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAAVEDRA"}
                                      ]) == {"CABALLITO": 1, "FLORES": 1, "SAAVEDRA": 1})
    

#GENERAR_TOP10

def test_generar_top10():
    assert(generar_top10({"SAN NICOLAS": 3, 
                       "PALERMO": 2, 
                       "VILLA URQUIZA": 7, 
                       "RECOLETA": 5, 
                       "MONSERRAT": 2, 
                       "CABALLITO": 1, 
                       "BELGRANO": 6, 
                       "BALVANERA": 7, 
                       "RETIRO": 4, 
                       "LINIERS": 1, 
                       "ALMAGRO": 5}) == [('VILLA URQUIZA', 7), 
                                         ('BALVANERA', 7), 
                                         ('BELGRANO', 6), 
                                         ('RECOLETA', 5), 
                                         ('ALMAGRO', 5), 
                                         ('RETIRO', 4), 
                                         ('SAN NICOLAS', 3), 
                                         ('PALERMO', 2), 
                                         ('MONSERRAT', 2), 
                                         ('CABALLITO', 1)])

#CANTIDAD_ESP_CULT_POR_COMUNA

def test_cantidad_esp_cult_por_comuna():
    assert(cantidad_esp_cult_por_comuna([
                                      {"FUNCION_PRINCIPAL": "BAR", "COMUNA": "COMUNA 1"}, 
                                      {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO", "COMUNA": "COMUNA 2"}, 
                                      {"FUNCION_PRINCIPAL": "BAR", "COMUNA": "COMUNA 2"}, 
                                      {"FUNCION_PRINCIPAL": "ANFITEATRO", "COMUNA": "COMUNA 4"}, 
                                      {"FUNCION_PRINCIPAL": "BIBLIOTECA", "COMUNA": "COMUNA 3"}
                                      ]) == {"COMUNA 2": 2, "COMUNA 1": 1, "COMUNA 4": 1, "COMUNA 3": 1})

    assert(cantidad_esp_cult_por_comuna([
                                      {"FUNCION_PRINCIPAL": "CALESITA", "COMUNA": "COMUNA 4"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "COMUNA": "COMUNA 4"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "COMUNA": "COMUNA 4", "BARRIO": "PALERMO"}
                                      ]) == {"COMUNA 4": 3})

    assert(cantidad_esp_cult_por_comuna([
                                      {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "COMUNA": "COMUNA 10"}, 
                                      {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "COMUNA": "COMUNA 14"}, 
                                      {"FUNCION_PRINCIPAL": "MUSEO", "COMUNA": "COMUNA 12"}
                                      ]) == {"COMUNA 10": 1, "COMUNA 14": 1, "COMUNA 12": 1})

#GENERAR_LISTAS_COMUNAS_Y_CANTIDAD

def test_generar_listas_comunas_y_cantidad():
    assert(generar_listas_comunas_y_cantidad({"COMUNA 11": 10, 
                                           "COMUNA 8": 6, 
                                           "COMUNA 2": 6, 
                                           "COMUNA 9": 3, 
                                           "COMUNA 1": 2}) == (["COMUNA 11", 
                                                               "COMUNA 8", 
                                                               "COMUNA 2", 
                                                               "COMUNA 9", 
                                                               "COMUNA 1"], 
                                                               [10, 6, 6, 3, 2]))

#GENERAR_LISTA_FUNCIONES_PRINCIPALES

def test_generar_lista_funciones_principales():
    assert(generar_lista_funciones_principales([
                                      {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                                      {"FUNCION_PRINCIPAL": "TEATRO"}, 
                                      {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO", "COMUNA": "COMUNA 1"}, 
                                      {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                                      {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                                      ]) == ["BAR", "TEATRO", "ANFITEATRO", "BIBLIOTECA"])

    assert(generar_lista_funciones_principales([
                                      {"FUNCION_PRINCIPAL": "CALESITA"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "COMUNA": "COMUNA 13"}, 
                                      {"FUNCION_PRINCIPAL": "LIBRERIA", "BARRIO": "SAN NICOLAS"}
                                      ]) == ["CALESITA", "LIBRERIA"])

    assert(generar_lista_funciones_principales([
                                      {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                      {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "FLORES"}, 
                                      {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAAVEDRA"}
                                      ]) == ["ESPACIO DE FORMACION", "GALERIA DE ARTE", "MUSEO"])

#OBTENER_LATITUD_LONGITUD

def test_obtener_latitud_longitud():
    assert(obtener_latitud_longitud([
                                   {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS", "LATITUD": "1.1", "LONGITUD": "2.3"}, 
                                   {"FUNCION_PRINCIPAL": "TEATRO", "LATITUD": "1.7", "LONGITUD": "3.2"}, 
                                   {"FUNCION_PRINCIPAL": "BAR", "LATITUD": "1.1", "LONGITUD": "4.43"}, 
                                   {"FUNCION_PRINCIPAL": "ANFITEATRO", "LATITUD": "1.0", "LONGITUD": "5.0"}, 
                                   {"FUNCION_PRINCIPAL": "BIBLIOTECA", "LATITUD": "0.0", "LONGITUD": "0.0"}
                                   ]) == {"LAT": [1.1, 1.7, 1.1, 1.0, 0.0], 
                                         "LON": [2.3, 3.2, 4.43, 5.0, 0.0]})

    assert(obtener_latitud_longitud([
                                   {"FUNCION_PRINCIPAL": "CALESITA", "LATITUD": "1.0", "LONGITUD": "1.0"}, 
                                   {"FUNCION_PRINCIPAL": "LIBRERIA", "BARRIO": "PALERMO", "LATITUD": "2.0", "LONGITUD": "2.0"}, 
                                   {"FUNCION_PRINCIPAL": "LIBRERIA", "LATITUD": "3.0", "LONGITUD": "3.0"}
                                   ]) == {"LAT": [1.0, 2.0, 3.0], 
                                         "LON": [1.0, 2.0, 3.0]})

    assert(obtener_latitud_longitud([
                                   {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "LATITUD": "1.1", "LONGITUD": "2.2"}, 
                                   {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "LATITUD": "3.3", "LONGITUD": "4.4"}
                                   ]) == {"LAT": [1.1, 3.3], 
                                         "LON": [2.2, 4.4]})

#FILTRAR_POR_BARRIO

def test_filtrar_por_barrio():
    assert(filtrar_por_barrio([
                            {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                            {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                            {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO", "COMUNA": "COMUNA 1"}, 
                            {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                            {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                            ], 
                            "SAN NICOLAS") == [{"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                                              {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                                              {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}])

    assert(filtrar_por_barrio([
                            {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                            {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                            {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}, 
                            {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                            {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                            ], 
                            "PALERMO") == [{"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                              {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}])

    assert(filtrar_por_barrio([
                            {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                            {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "FLORES"}, 
                            {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAAVEDRA"}
                            ], 
                            "NINGUNO") == [{"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                          {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "FLORES"}, 
                                          {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAAVEDRA"}])

#FILTRAR_POR_FUNCION_PRINCIPAL

def test_filtrar_por_funcion_principal():
    assert(filtrar_por_funcion_principal([
                                        {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                                        {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                                        {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                                        ], 
                                        "BAR") == [{"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}])

    assert(filtrar_por_funcion_principal([
                                        {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                        {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}, 
                                        {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "PALERMO"}, 
                                        {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}, 
                                        {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                        {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}
                                        ], 
                                        "TEATRO") == [{"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                                     {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                                     {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}])

    assert(filtrar_por_funcion_principal([
                                        {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                        {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "CABALLITO"}, 
                                        {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "CABALLITO"}
                                        ], 
                                        "NINGUNA") == [{"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                                      {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "CABALLITO"}, 
                                                      {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "CABALLITO"}])

#CONTRAR_TODOS_LOS_ESP_CULT_EN_BARRIO

def test_contar_todos_los_esp_cult_en_barrio():
    assert(contar_todos_los_esp_cult_en_barrio([
                                              {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "SAN NICOLAS"}, 
                                              {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                              {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO", "COMUNA": "COMUNA 1"}, 
                                              {"FUNCION_PRINCIPAL": "ANFITEATRO", "BARRIO": "SAN NICOLAS"}, 
                                              {"FUNCION_PRINCIPAL": "BIBLIOTECA", "BARRIO": "SAN NICOLAS"}
                                              ], 
                                              "SAN NICOLAS") == [("BAR", 1), ("ANFITEATRO", 1), ("BIBLIOTECA", 1)])

    assert(contar_todos_los_esp_cult_en_barrio([
                                              {"FUNCION_PRINCIPAL": "CALESITA", "BARRIO": "FLORES"}, 
                                              {"FUNCION_PRINCIPAL": "BAR", "BARRIO": "PALERMO"}, 
                                              {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}, 
                                              {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAN NICOLAS"}, 
                                              {"FUNCION_PRINCIPAL": "TEATRO", "BARRIO": "PALERMO"}
                                              ], 
                                              "PALERMO") == [("TEATRO", 2), ("BAR", 1)])

    assert(contar_todos_los_esp_cult_en_barrio([
                                              {"FUNCION_PRINCIPAL": "ESPACIO DE FORMACION", "BARRIO": "CABALLITO"}, 
                                              {"FUNCION_PRINCIPAL": "GALERIA DE ARTE", "BARRIO": "FLORES"}, 
                                              {"FUNCION_PRINCIPAL": "MUSEO", "BARRIO": "SAAVEDRA"}
                                              ], 
                                              "CABALLITO") == [("ESPACIO DE FORMACION", 1)])

#OBTENER_REDES_SOCIALES

def test_obtener_redes_sociales():
    assert(obtener_redes_sociales([{"ESTABLECIMIENTO": "BAR 1", 
                                "FACEBOOK": "https://www.facebook.com/BAR1/", 
                                "TWITTER": "@BAR1", 
                                "INSTAGRAM": "@EL_BAR_1"}, 
                                {"ESTABLECIMIENTO": "BAR 2", 
                                "FACEBOOK": "https://www.facebook.com/BAR2/", 
                                "TWITTER": "", 
                                "INSTAGRAM": "@EL_BAR_2"}, 
                                {"ESTABLECIMIENTO": "TEATRO 1", 
                                "FACEBOOK": "", 
                                "TWITTER": "", 
                                "INSTAGRAM": ""}, 
                                {"ESTABLECIMIENTO": "BIBLIOTECA 1", 
                                "FACEBOOK": "", 
                                "TWITTER": "@BIBLIOTECA1", 
                                "INSTAGRAM": "@LA_BIBLIOTECA_1"}, 
                                {"ESTABLECIMIENTO": "TEATRO 2", 
                                "FACEBOOK": "https://www.facebook.com/TEATRO2/", 
                                "TWITTER": "@TEATRO2", 
                                "INSTAGRAM": "@EL_TEATRO_2"}]) == {"BAR 1": [
                                                                            "https://www.facebook.com/BAR1/", 
                                                                            "@BAR1", 
                                                                            "@EL_BAR_1"
                                                                            ], 
                                                                "TEATRO 2": [
                                                                            "https://www.facebook.com/TEATRO 2/", 
                                                                            "@TEATRO2", 
                                                                            "@EL_TEATRO_2"
                                                                            ]
                                                                }, ["BAR 1", "TEATRO 2"])