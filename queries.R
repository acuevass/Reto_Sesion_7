# RETO 1: RStudio Cloud -> Github
#################################

# Una vez hecha la conexión a la BDD, generar una búsqueda con dplyr que devuelva
# el porcentaje de personas que hablan español en todos los países

# Instalamos las librerías necesarias para realizar la conexión y lectura de la
# base de datos en RStudio.
install.packages("DBI")
install.packages("RMySQL")

library(DBI)
library(RMySQL)

# Lectura de la base de datos de Shiny (es un demo)
MiBD <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username ="guest",
  password ="guest")

# Lectura de las tablas de la BD
dbListTables(MiBD)
dbListFields(MiBD, 'CountryLanguage')

# Búsqueda de personas que hablan español.
DataDB_Sp <- dbGetQuery(MiBD, "select * from CountryLanguage where Language = 'Spanish'")

length(DataDB$Language)
length(DataDB_Sp$Language)

# 5. Realizar una gráfica con ggplot que represente este porcentaje de tal modo
# que en el eje de las Y aparezca el país y en X el porcentaje, y que diferencié
# entre aquellos que es su lengua oficial y los que no, con diferente color 
# (puedes utilizar geom_bin2d() ó geom_bar() y coord_flip(), si es necesario 
# para visualizar mejor tus gráficas)
install.packages("ggplot2")
library(ggplot2)

ggplot(DataDB_Sp, aes(x = Percentage, y = CountryCode, fill = IsOfficial)) +
  geom_bin2d() + 
  theme_dark()

ggplot(DataDB_Sp, aes(x = Percentage, y = CountryCode, fill = IsOfficial)) +
  geom_bin2d() + facet_wrap('IsOfficial') +
  theme_dark()

# Pruebas, no se ve bien
ggplot(DataDB_Sp, aes(Percentage, CountryCode)) +
  geom_area() +
  coord_flip()
  theme_light()
  
# 6. Una vez hecho esto hacer el commit y push para mandar tu archivo (queries.R),
# al repositorio de Github Reto_Sesion_7

  # Usar el Token que ya generé: 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

  install.packages("gitcreds")
  library(gitcreds)
  
  gitcreds_set() # Para ingresar el token
  
  gitcreds_get() # Sirve para verificar que se ingresó el token