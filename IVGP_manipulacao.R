library(tidyverse)

# definindo caminho para diretorio
setwd("C:\\Users\\pedro\\Documents\\git\\IVGP")

# lendo arquivo IVGP
IVGP <- read.csv(".\\arquivos\\IVGP.csv", sep = ";")

# substituindo "," por "." para os decimais das colunas
IVGP <- IVGP|>
  map(~ gsub(",", ".", .x)) |>
  as.data.frame()

# alterando nome das colunas
colnames(IVGP)[colnames(IVGP) == "mes_..."] <- "mes_(%)"
colnames(IVGP)[colnames(IVGP) == "ano_..."] <- "ano_(%)"
colnames(IVGP)[colnames(IVGP) == "X6_meses_..."] <- "em_6_meses_(%)"
colnames(IVGP)[colnames(IVGP) == "X12_meses_..."] <- "em_12_meses_(%)"

# alterando tipo das colunas
IVGP$`mes_(%)` <- as.double(IVGP$`mes_(%)`)
IVGP$`ano_(%)` <- as.double(IVGP$`ano_(%)`)
IVGP$`em_6_meses_(%)` <- as.double(IVGP$`em_6_meses_(%)`)
IVGP$`em_12_meses_(%)` <- as.double(IVGP$`em_12_meses_(%)`)
IVGP$`numero_indice` <- as.double(IVGP$`numero_indice`)

# alterando a coluna "data" para POSIXct
IVGP$data <- as.POSIXct(IVGP$data, format = "%d/%m/%Y")

# fazendo backup
backup_IVGP <- IVGP

# variacao MoM para os valores mensais de IVGP 
IVGP$`MoM_IVGP_mes(%)` <- (IVGP$`mes_(%)` - lead(IVGP$`mes_(%)`))/lead(IVGP$`mes_(%)`)

# variacao YoY para os valores anuais de IVGp
IVGP$`YoY_IVPG_ano(%)` <- (IVGP$`ano_(%)` - lead(IVGP$`ano_(%)`, n = 12)) / lead(IVGP$`ano_(%)`, n = 12)






















