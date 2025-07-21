# Instalamos el paquete markovchain y DiagrammeR
if (!require(markovchain)) {
  install.packages("markovchain")
}
# https://rich-iannone.github.io/DiagrammeR/articles/graphviz-mermaid.html
if(!require(DiagrammeR)) {
  install.packages("DiagrammeR")
}

# Cargamos la librería markovchain y DigrammeR:
library(markovchain)
library(DiagrammeR)

# ------------------------------------ #
# La movilidad social se puede modelar mediante cadenas de Markov. Entonces definimos
# conjunto de estados: 
#S = {desfavorecido(D), medio bajo(MB), intermedio(I), medio alto(MA), acomodado(A)}.
# ------------------------------------ #

# Definimos la matriz de transición de la cadena de Markov:
matrizTransicion <- matrix(c(0.8, 0.15, 0.04, 0.01, 0, 
                              0.15, 0.8, 0.05, 0, 0,
                              0.04, 0.12, 0.8, 0.04, 0,
                              0.01, 0.04, 0.13, 0.8, 0.02,
                              0, 0, 0, 0.2, 0.8), nrow = 5, byrow = TRUE)

# Creamos la cadena de Markov:
cadenaDeMarkov<- new("markovchain", name = "movilidadSocial", 
                    states = c("D", "MB", "I", "MA", "A"), transitionMatrix = matrizTransicion)

# Mostramos la matriz de transición de la cadena de Markov:
print(cadenaDeMarkov)

# Creamos el grafo de transición de la cadena de Markov:
grViz("
digraph movilidadSocial {
  graph [layout = dot, rankdir = TB, fontsize = 50, nodesep=1.5, ranksep=0.5]

  node [shape = circle,
        fixedsize = true,
        width = 0.8,
        fontsize = 30]

  // Nodos
  D; MB; I; MA; A

  // Aristas con etiquetas de probabilidad
  D  -> D  [label = '0.80', fontsize = 25]
  D  -> MB [label = '0.15', fontsize = 25]
  D  -> I  [label = '0.04', fontsize = 25]
  D  -> MA [label = '0.01', fontsize = 25]

  MB -> D  [label = '0.15', fontsize = 25]
  MB -> MB [label = '0.80', fontsize = 25]
  MB -> I  [label = '0.05', fontsize = 25]

  I  -> D  [label = '0.04', fontsize = 25]
  I  -> MB [label = '0.12', fontsize = 25]
  I  -> I  [label = '0.80', fontsize = 25]
  I  -> MA [label = '0.04', fontsize = 25]

  MA -> D  [label = '0.01', fontsize = 25]
  MA -> MB [label = '0.04', fontsize = 25]
  MA -> I  [label = '0.13', fontsize = 25]
  MA -> MA [label = '0.80', fontsize = 25]
  MA -> A  [label = '0.02', fontsize = 25]

  A  -> MA [label = '0.20', fontsize = 25]
  A  -> A  [label = '0.80', fontsize = 25]
}
")

# ------------------------------------ #
# Datos de la cadena de Markov
# ------------------------------------ #

# Ver si es irreducible:
is.irreducible(cadenaDeMarkov)
# Podemos ver que la cadena es irreducible, es decir, todos los estados están comunicados.

# Ver período de la cadena:
period(cadenaDeMarkov)
# La cadena es aperiódica debido a que todos los estados tiene período igual a 1. 
# Por ejemplo, delta(A) = mcd{1,2,3,...} = 1

# Ver estados transitorios:
transientStates(cadenaDeMarkov)
# No hay estados transitorios debido a que resulta casi seguro que se vuelve a él.

# Ver los estados absorbentes:
absorbingStates(cadenaDeMarkov)
# No hay estados absorbentes, es decir, nunca nos quedamos en un estado para siempre.

# ------------------------------------ #
# Tenemos la siguiente distribución inicial de la cadena de Markov,
# pi^0 = (0.05 0.15 0.69 0.1 0.01) y queremos encontrar cuál es la composición de la
# población argentina esperada para dentro de 10 años.
# Entonces planteamos lo siguiente:
# sabemos que pi^(1) = pi^(1) * matrizTransicion, en general, pi^(n+1) = pi^(n) * matrizTransicion.
# Con lo cual como queremos buscar pi^(2) = pi^(1) * matrizTransicion (debido a que cada "paso" 
# equivale a 5 años). Entonces:
# ------------------------------------ #

# Creamos distribución inicial:
distInicial <- c(0.05, 0.15, 0.69, 0.1, 0.01)
names(distInicial) <- c("D", "MB", "I", "MA", "A")

# Calculamos la composición de la población argentina en 5 años:
distCincoAños <- distInicial * cadenaDeMarkov
distCincoAños <- c(distCincoAños)
names(distCincoAños) <- c("D", "MB", "I", "MA", "A")

# Calculamos la composición de la población argentina en 10 años:
distDiezAños <- distCincoAños * cadenaDeMarkov
distDiezAños <- c(distDiezAños)
names(distDiezAños) <- c("D", "MB", "I", "MA", "A")

# Para comprobar, también podemos calcularla de la siguiente forma:
 matrizTransicion2 <- cadenaDeMarkov^2
 distDiezAños2 <- distInicial * matrizTransicion2
 round(distDiezAños2, 4)
 # Debido a que podemos pi^(n+1) = pi^(0) * matrizTransicion^(n+1) o equivalente
 # pi^(n) = pi^(0) * matrizTransicion^(n)

# Por lo tanto la composición de la población argentina esperada para dentro de 10 años es
round(distDiezAños, 4)

# ------------------------------------ #
# Ahora queremos buscar la composición de la población argentina esperada a largo plazo,
# entonces debemos buscar su distribución estacionaria. Sabemos que va a existir una única
# distribución estacionaria ya que tenemos las dos condiciones suficientes que garantizan esto,
# tenemos que la cadena de Markov es irreducible y es aperiódica.
# Con lo cual buscamos pi = (pi_0, pi_1, pi_2, pi_3, pi_4) tal que pi = pi * T y
# pi_0 + pi_1 + pi_2 + pi_3 + pi_4 = 1.
# ------------------------------------ #

# Obtenemos la distribución estacionaria de la cadena de Markov:
distEstacionaria <-steadyStates(cadenaDeMarkov)
round(distEstacionaria, 4)

# ------------------------------------ #
# Por último queremos ver cual es la probabilidad de que un núcleo familiar que se encuentra
# en el estrato intermedio alcanza el estrato acomodado al cabo de 20 años.
# El equivalente a 20 años son 4 pasos ya que cada paso son 5 años. Entonces para poder
# calcular dicha probabilidad debemos obtener la matriz de probabilidad de transición 
# 4 veces multiplicada por si misma, de esa forma buscamos fila "intermedio" columna "acomodado"
# y de ahí sacamos su probabilidad.
# ------------------------------------ #

matrizTransicion4 <- cadenaDeMarkov^4
transitionProbability(matrizTransicion4,"I","A")

# Esto se traduce a realizar el siguiente calculo:
# 1) calcular la matriz de transición elevada a la cuarta.
# 2) multiplicar un vector inicial con las probabilidades iniciales en cada estado
# (en nuestro caso el vector tiene solo un 1 en la columna I) con la matriz de transición
# obtenida previamente.
# 3) obtener el valor en la posición del estado que buscamos (nuestro caso la columna A).