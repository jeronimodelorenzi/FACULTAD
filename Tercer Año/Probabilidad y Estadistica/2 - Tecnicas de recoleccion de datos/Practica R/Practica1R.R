# a) La muestra consiste en 59 sujetos de estudio.
#    Se encuentran 4 variables: signo, sexo, edad, num de visitas.
#    -Signo: cuantitativa discreta, medida en escala de razón.
#    -Sexo: cualitativa medida en escala nominal.
#    -Edad: cuantitativa discreta, medida en escala de razón.
#    -Num de visitas: cuantitativa discreta, medida en escala de razón.
# Las columnas estan separadas por un \t.

# Leemos anorexia.data
anorexia <- read.table("anorexia.data", header= TRUE, sep="\t",
                       col.names = c("Signo", "Sexo", "Edad", "Num de visitas"),
                       colClasses = c("factor","factor","numeric","numeric"))

# Mostramos la tabla
anorexia

# Una forma de mostrar elementos de una variable
anorexia$Sexo

# Otra forma
attach(anorexia)

# Llamando a la variabel "Sexo" obtenemos todos los valores de la columna.
Sexo

# Clases de las variables
cat("Signo:",class(Signo))
cat("Sexo:",class(Sexo))
cat("Edad:",class(Edad))
cat("Núm de visitas:",class(Núm.de.visitas))

# Contamos cantidad de hombres y mujeres.
summary(Sexo)

# Calculamos la edad máxima y mínima y el promedio de edades.
edadMaxima <- max(Edad)
cat("La edad máxima es", edadMaxima, "años")
edadMinima <- min(Edad)
cat("La edad mínima es", edadMinima, "años")
promEdades <- mean(Edad)
cat("El promedio de edad es", promEdades)

# Creamos tabla de frecuencias de numero de visitas
frecNumVisitas <- table(Núm.de.visitas)
frecRelNumVisitas <- round(frecNumVisitas/sum(frecNumVisitas),4)
frecAbsAcumNumVisitas <- cumsum(frecNumVisitas)
frecRelAcumNumVisitas <- round(frecAbsAcumNumVisitas/sum(frecNumVisitas),4)
tablaNumVisitas <- cbind(frecNumVisitas,frecRelNumVisitas,frecAbsAcumNumVisitas,frecRelAcumNumVisitas)

# Creamos tabla de frecuencias de edad
intervalos <- seq(11,35, by=3)
intervalosEdad <- cut(Edad, breaks = intervalos, right = FALSE)
frecAbsEdad <- table(intervalosEdad)
frecRelEdad <- round(frecAbsEdad/sum(frecAbsEdad),4)
frecAbsAcumEdad <- cumsum(frecAbsEdad)
frecRelAcumEdad <- cumsum(frecRelEdad)
tablaEdad <- cbind(frecAbsEdad,frecRelEdad,frecAbsAcumEdad,frecRelAcumEdad)

# Creamos tabla de variables cruzadas
tablaBi <- table(Signo,Sexo)
sumFil <- apply(tablaBi, 1, sum)
tablaBiTot1 <- cbind(tablaBi,sumFil)
sumCol <- apply(tablaBiTot1, 2, sum)
tablaBiTot <-rbind(tablaBiTot1,sumCol)
