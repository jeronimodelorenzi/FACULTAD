def head (n):
    archivo = open("Archivo.txt", "r")
    lineas = archivo.readlines()
    for x in lineas:
        print(lineas[:n])
    archivo.close()

