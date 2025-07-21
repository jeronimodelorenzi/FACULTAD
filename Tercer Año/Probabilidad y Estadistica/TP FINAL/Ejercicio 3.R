# Definimos los parámetros que vamos a utilizar para calcular la trayectoria

lambda <- 18
t <- 0.5

# Definimos los tiempos y las variables aleatorias T_i

tiempos <- c()
tAcumulado <- 0

while (tAcumulado < t) {
  T_i <- rexp(n = 1, rate = lambda)
  if (tAcumulado + T_i > t) break
  tAcumulado <- tAcumulado + T_i
  tiempos <- c(tiempos, tAcumulado)
}

  