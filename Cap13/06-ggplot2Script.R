# Este código contém comandos para filtrar e plotar os dados de aluguel de bikes,
# dados que estao em nosso dataset
# Este codigo foi criado para executar tanto no Azure quanto no RStudio.
# Para executar no Azure, alter o valor da variável Azure para TRUE. Se o valor for FALSE, o codigo sera executado no RStudio

# Variável que controla a execução do script
Azure <- FALSE

if(Azure){
  source("src/Tools.R")
  Bikes <- maml.mapInputPort(1)
  Bikes$dteay <- set.asPOSIXct(Bikes)
}else{
  source("Tools.R")
  Bikes <- read.csv("datasets/bikes.csv", sep = ",", header = T, stringsAsFactors = F)
  Bikes$dteday <- char.toPOSIXct(Bikes)
}

require(dplyr)
Bikes <- Bikes %>% filter(hr == 9)

# ggplot2
require(ggplot2)
ggplot(Bikes, aes(x = dteday, y = cnt)) + 
  geom_line() +
  ylab("Numero de Bikes") +
  xlab("Linha do Tempo") +
  ggtitle("Demanda por Bikes as 09:00") +
  theme(text = element_text(size = 20))