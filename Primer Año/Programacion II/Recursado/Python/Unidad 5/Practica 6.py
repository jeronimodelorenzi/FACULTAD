#Ejericio 1

#a

def primeros_dos(s):
    return s[0:2]

def primeros_dos2(s):
    string = ""
    for i in range(2):
        string += s[i]
    return string

#b

def ultimos_tres(s):
    return s[-1:-4:-1]

def ultimos_tres2(s):
    string = ""
    for i in range(-1,-4,-1):
        string += s[i]
    return string

#c

def entre_dos(s):
    return s[::2]

def entre_dos2(s):
    string = ""
    length = len(s)
    for i in range(0, length,2):
        string += s[i]
    return string

#d

def inversa(s):
    return s[::-1]

def inversa2(s):
    string = ""
    length = len(s)
    for i in range(-1,-length-1,-1):
        string += s[i]
    return string
#e

def sentido_inverso(s):
    return s + inversa(s)

#2

def contar(l,x):
    cont = 0
    for char in x:
        if char == l:
            cont += 1
    return cont

#3

def cont_vocales(x):
    
    cont_a = 0
    cont_e = 0
    cont_i = 0
    cont_o = 0
    cont_u = 0
    for char in x.lower():
        if char == "a":
            cont_a += 1
        elif char == "e":
            cont_e += 1
        elif char == "i":
            cont_i += 1
        elif char == "o":
            cont_o += 1
        elif char == "u":
            cont_u += 1
    print(f"La palabra {x} tiene: {cont_a} 'a', {cont_e} 'e', {cont_i} 'i', {cont_o} 'o' , {cont_u} 'u'")

#4
    
def mas_cinco(s):
    cont_letras = 0
    cont_palabras = 0
    for char in s:
        cont_letras += 1
        if char == " ":
            if cont_letras > 5:
                cont_palabras +=1
            cont_letras = 0
    if cont_letras > 5:
        cont_palabras += 1
    return cont_palabras

#5

#a

def primeras_letras(s):
    string = s[0]
    cont_letra = 0
    for char in s:
        if char == " ":
            string += s[cont_letra+1]
        cont_letra += 1
    return string

#b

def primeras_mayusculas(s):
    string = s[0].capitalize()
    cont_letra = 0
    for char in s:
        if char == " ":
            string += s[cont_letra + 1].capitalize()
        cont_letra += 1
    return string

#c

def palabras_letra(s,c):
    string_a = ""  
    string = ""  
    for char in s:
        if char != " ":  
            string += char
        else:
            if  string.startswith(c) or string.startswith(c):
                string_a += string + " "
            string = ""
    if  string.startswith(c) or string.startswith(c):
        string_a += string
    return string_a.strip()
            
        