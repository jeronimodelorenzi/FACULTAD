# Se describe la soluci�n de los �ltimos ejercicios (9 y 10) de la pr�ctica que 
# suelen resultar m�s problem�ticos. Recuerden que igual deben hacer los 
# ejercicios que restan. En esta tarea, les ayudar� el apunte de Representaci�n
# Gr�fica en R, la parte 1 de la pr�ctica y la b�squeda de documentaci�n de las 
# funciones de R. Cualquier consulta la podemos ver

# Lectura de la base de datos
anorexia <- read.table(file="anorexia.data", header= TRUE, 
                       sep="\t", col.names = c("Signo", "Sexo", "Edad", "Num de visitas"),
                       colClasses = c("factor","factor","numeric","numeric"))

# Gr�fico de histograma para EDAD
title_hist = strsplit(c("Edad (en a�os) de personas que se presentaron en la; Asociaci�n de Lucha contra la Bulimina y Anorexia; en octubre de 2012"), split = ";")
fuente = "Registros de la Aociaci�n de Lucha contra la Bulimia y Anorexia"
breaks_edad <- seq(11,35,3)
hist(anorexia$Edad, border = "black", col = "lightblue", xaxt = 'n', ylim = c(0,30), breaks = breaks_edad, xlab = "Edad (en a�os)", ylab = "Cantidad de personas", main = title_hist, sub = fuente, cex.sub = 0.7)
axis(side = 1, at = breaks_edad) # definimos el eje x por separado. Por eso ponemos xaxt='n'

# Creamos las tablas necesarias
intervalos_edad <- cut(anorexia$Edad, breaks = breaks_edad, right = FALSE)
frec_abs_edad <- table(intervalos_edad) 
frec_rel_edad <- round(frec_abs_edad / sum(frec_abs_edad),4)
frec_rel_ac_edad <- cumsum(frec_rel_edad) 

# Pol�gono de frecuencia para Edad:
plot(frec_rel_edad, type = "l", xaxt="n", main = title_hist, ylab = "Frecuencia relativa", xlab = "Edad (en a�os)", sub = fuente, cex.sub = 0.7)
axis(side = 1, at = 1:9, labels = breaks_edad)
grid()

# Pol�gono acumulativo
plot(frec_rel_ac_edad, type = "l", xaxt="n", main = title_hist, ylab = "Frecuencia acumulada", xlab = "Edad (en a�os)", sub = fuente, cex.sub = 0.7)
axis(side = 1, at = 1:9, labels = breaks_edad)
grid()


# Boxplot para Edad
boxplot(anorexia$Edad, horizontal = TRUE, col = "pink", main = title_hist, xlab = "Edad (en a�os)", sub = fuente, cex.sub = 0.7, ylim = c(10,35))

# Boxplot bivariado Edad y Sexo
boxplot(anorexia$Edad~anorexia$Sexo, col = "pink", main = title_hist, ylab = "Edad (en a�os)", xlab = "Sexo", sub = fuente, cex.sub = 0.7, ylim = c(10,35), boxwex = 0.5)
