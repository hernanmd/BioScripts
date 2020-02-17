install.packages("PMCMRplus")
library(PMCMRplus)

setwd("d:\\Hernan\\Proyectos\\Por-Usuario\\Gaby\\")

grupo_control_RLCC <- scan("joined_2019-12-20_20-15-51.txt")
grupo_caso_RLCC <- c(3650, 730, 2555, 365, 2190, 1460, 1825, 730, 2920, 4380, 2920, 1095, 1095, 1095, 730, 2920, 365, 1825, 3285, 4015, 1095, 365, 2920, 730, 2555, 1095, 2920, 1460, 2190, 1460, 4380, 2190, 2920, 2190, 730, 1825, 2920, 730, 3285, 2555, 2555, 1095, 3650, 730, 365, 1825, 2555, 1825, 2920, 2190, 2190, 3650, 4015, 3285, 730, 2920, 365, 1460, 365, 4380, 2190, 2920, 1460, 2555, 1460, 1460, 730, 1460, 2555, 1460, 1825, 730)

ts <- length(grupo_caso_RLCC) + length(grupo_control_RLCC)

dfRLCC <- data.frame(
  grupo = rep(c("CASO_LR", "CONTROL_LR"),
              c(length(grupo_caso_RLCC), length(grupo_control_RLCC))),
  valores = c(grupo_caso_RLCC, grupo_control_RLCC),
  cordenada_y = rep(0, ts))


lrKruskalWallis <- kruskalTest(
  valores ~ grupo, 
  dfRLCC, 
  dist = c("KruskalWallis"))
lrKruskalWallis
