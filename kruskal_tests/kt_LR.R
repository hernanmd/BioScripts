install.packages("PMCMRplus")
library(PMCMRplus)

setwd("d:\\Hernan\\Proyectos\\Por-Usuario\\Gaby\\")

grupo_control_LR <- scan("joined_2019-12-20_20-15-54.txt")
grupo_caso_LR <- c(2190, 365, 365, 3650, 365, 90, 365, 2190, 730, 2555, 365, 365, 730, 730, 1095, 365, 180, 1095, 730, 365, 5110, 2190, 365, 730, 3650, 1460, 365, 365, 1095, 730, 4380, 2190, 365, 365, 365, 365, 365, 5840, 730, 730, 3650, 180, 365, 1460, 365, 1825, 365, 2920, 5110, 2920, 60)

ts <- length(grupo_caso_LR) + length(grupo_control_LR)

dfLR <- data.frame(
  grupo = rep(c("CASO_LR", "CONTROL_LR"),
              c(length(grupo_caso_LR), length(grupo_control_LR))),
  valores = c(grupo_caso_LR, grupo_control_LR),
  cordenada_y = rep(0, ts))


lrKruskalWallis <- kruskalTest(
  valores ~ grupo, 
  dfLR, 
  dist = c("KruskalWallis"))
lrKruskalWallis
