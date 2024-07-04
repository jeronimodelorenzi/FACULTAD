#Ejercicio 6

#a

def es_par(n):
    condicion = False
    if n % 2 == 0:
        condicion = True
    return condicion

#b

def es_multiplo_3(n):
    condicion = False
    if n % 3 == 0:
        condicion = True
    return condicion

#c

def es_multiplo_f(n,f):
    condicion = False
    if n % f == 0:
        condicion = True
    return condicion


#Ejercicio 7

def my_abs(n):
    if n >= 0:
        va = n
    else:
        va = -n
    return va

#Ejercicio 8

def resolvente_real(a,b,c):
    discriminante = b**2 - 4*a*c
    if a == 0:
        print("No se puede")
    elif discriminante < 0:
        print("No se puede")
    elif discriminante == 0:
        unica_raiz = b / (2*a)
        print(f"La unica raiz es {unica_raiz}")
    else:
        primera_raiz = (-b + discriminante**0.5)/(2*a)
        segunda_raiz = (-b - discriminante**0.5)/(2*a)
        print(f"La primera raiz del polinomo {a}x^2+{b}x+{c}=0 es {primera_raiz} y la segunda {segunda_raiz}")

#Ejericicio 9

#a

def es_bisiesto(año):
    condicion = False
    if (año % 4 == 0 and año % 100 != 0) or (año % 400 == 0 and año % 100 != 0):
        condicion = True
    return condicion

#b

def dias_mes(m):
    if m ==2:
        dias = 28
    elif m == 1 or m == 3 or m == 5 or m == 7 or m == 8 or m == 10 or m == 12:
        dias = 31
    else:
        dias = 30
    return dias

#c

def n_mes(m):
    if m == 1:
        dia = 'Enero'
    elif m == 2:
        dia = 'Febrero'
    elif m == 3:
        dia = 'Marzo'   
    elif m == 4:
        dia = 'Abril'
    elif m == 5:
        dia = 'Mayo'
    elif m == 6:
        dia = 'Junio' 
    elif m == 7:
        dia = 'Julio'
    elif m == 8:
        dia = 'Agosto'
    elif m == 9:
        dia = 'Septiembre'
    elif m == 10:
        dia = 'Octubre'
    elif m == 11:
        dia = 'Noviembre'
    elif m == 12:
        dia = 'Diciembre'
    return dia

#d

def fecha_palabra(d,m,a):
    mes = n_mes(m)
    return f"{d} de {mes} de {a}"

#Ejercicio 10

#a

def intervalo_segundos(h,m,s):
    if s > 59:
        m += 1
        s -= 59
    if m > 59:
        h += 1
        m -= 59
    minutos_a_segundos = m * 60
    horas_a_segundos = h * 3600 
    total = horas_a_segundos + minutos_a_segundos + s
    return total

#b

def intervalo(s):
    hora = s//3600
    resto_hora = s % 3600
    minuto = resto_hora//60
    segundo = minuto%60
    print(hora, minuto, segundo)

#Ejercicio 11
    
def suma_intervalo():
    primer_horas = int(input("Ingrese las horas del primer intervalo: "))
    primer_minutos = int(input("Ingrese los minutos del primer intervalo: "))
    primer_segundos = int(input("Ingrese los segundos del primer intervalo: "))
    segundo_horas = int(input("Ingrese las horas del segundo intervalo: "))
    segundo_minutos = int(input("Ingrese los minutos del segundo intervalo: "))
    segundo_segundos = int(input("Ingrese los segundos del segundo intervalo: "))

    

    primer_intervalo_segundos = intervalo_segundos(primer_horas,primer_minutos,primer_segundos)
    segundo_intervalo_segundos = intervalo_segundos(segundo_horas,segundo_minutos,segundo_segundos)
    suma_inter = primer_intervalo_segundos + segundo_intervalo_segundos

    nuevo_intervalo = intervalo(suma_inter)
    return nuevo_intervalo
    

#Ejercicio 12

def observar_clima(grados):
    if grados < 0:
        etiqueta = 'Helado'
    elif grados >= 0 and grados < 15:
        etiqueta = 'Frio'
    elif grados >= 15 and grados < 25:
        etiqueta = 'Agradable'
    else:
        etiqueta = 'Caluroso'
    return etiqueta

#a

def obsevar_clima2(grados):
    if grados < 0:
        etiqueta = 'Helado'
    elif grados >= 0 and grados < 15:
        etiqueta = 'Frio'
    elif grados >= 15 and grados < 25:
        etiqueta = 'Agradable'
    elif grados >= 25 and grados <32:
        etiqueta = 'Caluroso'
    else:
        etiqueta = 'Muy caluroso'
    return etiqueta

#b

def obsevar_clima3(grados):
    if grados < 0:
        etiqueta = 'Helado'
    elif grados >= 0 and grados < 10:
        etiqueta = 'Fresco'
    elif grados >= 10 and grados < 15:
        etiqueta = 'Frio'
    elif grados >= 15 and grados < 25:
        etiqueta = 'Agradable'
    elif grados >= 25 and grados <32:
        etiqueta = 'Caluroso'
    else:
        etiqueta = 'Muy caluroso'
    return etiqueta

def obsevar_clima4(grados):
    if grados < 0:
        etiqueta = 'Helado'
    elif grados >= 0 and grados < 10:
        etiqueta = 'Fresco'
    elif grados >= 10 and grados < 15:
        etiqueta = 'Frio'
    elif grados >= 15 and grados < 25:
        etiqueta = 'Agradable'
        print("Usar protector")
    elif grados >= 25 and grados <32:
        etiqueta = 'Caluroso'
        print("Usar protector")
    else:
        etiqueta = 'Muy caluroso'
        print("Usar protector")
    return etiqueta

#Ejercicio 14

def dia_dia(n):
    calculo = (n - 1) % 7
    if calculo == 0:
        dia = 'Lunes'
    elif calculo == 1:
        dia = 'Martes'
    elif calculo == 2:
        dia = 'Miercoles'
    elif calculo == 3:
        dia = 'Jueves'
    elif calculo == 4:
        dia = 'Viernes'
    elif calculo == 5:
        dia = 'Sabado'
    else:
        dia = 'Domingo'
    return dia

#Ejercicio 15

def signo_astrologia(d,m):
    if m == 1:
        if d <=20:
            signo = 'Capricornio'
        else:
            signo = 'Acuario'
    elif m == 2:
        if d <= 19:
            signo = 'Acuario'
        else:
            signo = 'Piscis'
    elif m == 3:
        if d<= 20:
            signo = 'Piscis'
        else:
            signo = 'Aries'
    elif m == 4:
        if d<= 20:
            signo = 'Aries'
        else:
            signo = 'Tauro'
    elif m == 5:
        if d<= 20:
            signo = 'Tauro'
        else:
            signo = 'Geminis'
    elif m == 6:
        if d <= 21:
            signo = 'Geminis'
        else:
            signo = 'Cancer'
    elif m == 7:
        if d <= 22:
            signo = 'Cancer'
        else:
            signo = 'Leo'
    elif m == 8:
        if d <= 23:
            signo = 'Leo'
        else:
            signo = 'Virgo'
    elif m == 9:
        if d <= 23:
            signo = 'Virgo'
        else:
            signo = 'Libra'
    elif m == 10:
        if d <= 23:
            signo = 'Libra'
        else:
            signo = 'Escorpio'
    elif m == 11:
        if d <= 22:
            signo = 'Escorpio'
        else:
            signo = 'Sagitario'
    else:
        if d <= 21:
            signo = 'Sagitario'
        else:
            signo = 'Capricornio'
    return signo 

#Ejercicio 16

#Ejericico 17

#Ejercicio 18

def pares_25():
    for i in range(50):
        if i % 2 == 0:
            print(i)

#Ejercicio 19

def pares_100():
    for i in range(200):
        if i % 2 == 0:
            print(i)

            
def pares_n(n):
    for i in range(n*2):
        if i % 2 == 0:
            print(i)

#Ejercicio 20
            
def pares_n_m(n,m):
    for i in range(m,n*2+m):
        if i % 2 == 0:
            print(i)

def pares_rec(n,m):
    if n == 0:
        return
    else:
        if m % 2 == 0:
            print(n*2+m)
            return pares_rec(n-1,m)
        else:
            return pares_rec(n,m-1)



#Ejercicio 21

def calificar_nota(nota):
    if nota >=1 and nota < 4:
        condicion = "Insuficiente"
    elif nota >=4 and nota < 6:
        condicion =  "No Aprobado"
    elif nota >=6 and nota < 8:
        condicion =  "Aprobado"
    elif nota >=8 and nota < 10:
        condicion =  "Muy Bueno"
    else:
        condicion =  "Excelente"
    return condicion

def notas():
    for alumno in range(23):
        nota = int(input(f"Ingrese la nota del alumno {alumno+1}: "))
        condicion = calificar_nota(nota)
        print(f"Alumno {alumno+1}: {condicion}")

#Ejercicio 22

def notas_promedio():
    for alumno in range(10):
        suma_nota = 0
        for calificacion in range(3):
            nota = int(input(f"Ingrese la nota {calificacion+1} del alumno {alumno+1}: "))
            suma_nota += nota
        promedio = suma_nota /3
        condicion = calificar_nota(promedio)
        print(f"La calificacion del alumno {alumno+1} es {condicion}")

