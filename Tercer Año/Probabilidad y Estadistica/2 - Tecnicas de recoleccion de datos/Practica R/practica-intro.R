# Cargar tabla
anorexia = read.table("/home/alumno/Desktop/PyE/anorexia.data", sep='\t')

# Extraer variables de la tabla.
retornarVariables = function(frame){
  cantVariables = length(frame)
  listaVariables = c()
  for (i in 1:cantVariables) {
    listaVariables = c(listaVariables, anorexia[1,i])
  }
  
  return(listaVariables)
}

listaVariables = retornarVariables(anorexia)
listaVariables
names(anorexia) = listaVariables

anorexia[,1]
