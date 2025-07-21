# Instalamos el paquete tidyverse y ggplot2
if (!require(tidyverse)) {
  install.packages("tidyverse")
}

if (!require(ggplot2)) {
  install.packages("ggplot2")
}

# Cargamos las liberías tidyverse y ggplot2
library(tidyverse)
library(ggplot2)

# Definimos los parámetros que vamos a utilizar para calcular las probabilidades
nViviendas <- 350
pCertificado <- 0.37
nSim <- 10000

# Función que simula un recuento de éxitos en 350 procesos Bernoulli.
N_350 <- function() {
  sum(rbinom(n = nViviendas, size = 1, p = pCertificado))
}

# Simulamos nSim veces
res <- replicate(nSim, N_350())

# Medidas resumen

media <- mean(res)
desvEstand <- sd(res)

# Graficamos
dfRes <- data.frame(certificados = res)

ggplot(dfRes, aes(x = certificados)) +
  geom_histogram(binwidth = 5, fill = "lightgray", color = "black") +
  labs(x = "Cantidad de viviendas con certificado Re.Na.Ba.P",
       y = "Frecuencia",
       title = "Distribución simulada de certificados en 350 viviendas") +
  geom_vline(xintercept = media, col = "red", linetype = "dashed") +
  theme_minimal()

