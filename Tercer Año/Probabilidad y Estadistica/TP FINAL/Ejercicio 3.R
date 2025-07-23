# Instalamos el paquete ggplot2
if (!require(ggplot2)) {
  install.packages("ggplot2")
}

# Cargamos las liberías ggplot2
library(ggplot2)

# a

# Definimos los parámetros que vamos a utilizar para calcular la trayectoria.
lambda <- 18
t <- 0.5

# Generamos una variable aleatoria de Poisson que representa el número de llegdas.
n <- rpois(1, lambda * t) 

# Generamos los tiempos de llegada de las variables aleatorias T_i.
T_i <- rexp(n, rate = lambda)
tiempos <- cumsum(T_i)

# Función que simula el proceso que genera la trayectoria de llegadas.
simular_proceso <- function(tiempos, tFinal) {
  tiemposX_t <- c(0, tiempos[tiempos <= tFinal], tFinal)
  valoresX_t <- 0:(length(tiemposX_t) - 2)
  valoresX_t <- c(valoresX_t, valoresX_t[length(valoresX_t)])
  
  return(list(tiempo = tiemposX_t, X_t = valoresX_t))
}

# Función que visualiza la simulación generada previamente.
visualizar_proceso <- function(tiempo, X_t) {
  plot(tiempo, X_t, type = "n", xlab = "Tiempo (meses)", ylab = "Número de llegadas (familias)",
       main = "Trayectoria de un proceso de Poisson")
  
  lines(tiempo, X_t, type = "s", col = "blue")
  points(tiempo, X_t, pch = 19, col = "red")
  
  legend("topleft", legend = c("Proceso X_t", "Saltos"), 
         col = c("blue", "red"), lty = c(1, NA), pch = c(NA, 19))
}

# Ejecutamos.
resultado <- simular_proceso(tiempos, t)
visualizar_proceso(resultado$tiempo, resultado$X_t)

# --------------------------------- #
# b

# Definimos los parámetros que vamos a utilizar para calcular la trayectoria.
lambda2 <- 18
t2 <- 15

# Generamos una variable aleatoria de Poisson que representa el número de llegadas.
n2 <- rpois(1, lambda2 * t2) 

# Generamos los tiempos de llegada de las variables aleatorias T_i.
T_i2 <- rexp(n2, rate = lambda2)
tiempos2 <- cumsum(T_i2)

# Tomamos los tiempos que están dentro del intervalo
tiempos2 <- tiempos2[tiempos2 <= t2]
T_i2 <- T_i2[1:length(tiempos2)]  # variable T

# Histograma
dfT <- data.frame(tiempos = T_i2)

ggplot(dfT, aes(x = tiempos)) +
  geom_histogram(binwidth = 0.01, fill = "lightgray", color = "black", boundary = 0) +
  labs(x = "Tiempos entre llegadas (años)",
       y = "Frecuencia",
       title = "Histograma de tiempos entre llegadas de núcleos familiares") +
  theme_minimal()

# Medidas
summary(T_i2)
sd(T_i2)
var(T_i2)  