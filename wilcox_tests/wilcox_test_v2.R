install.packages("coin")
require(coin)

setwd("IGEVET/gaby")
sanos_lr <- scan("joined_2019-12-20_20-15-54.txt")
sanos_rlcc <- scan("joined_2019-12-20_20-15-51.txt")

datos <- data.frame(
            grupo = rep(c("SANOS_LR", "SANOS_RLCC"),
                        c(12245, 12437)),
            valores = c(sanos_lr, sanos_rlcc))

wilcox_test(
    valores ~ grupo, data = datos, 
    distribution = "exact", 
    conf.int = 0.95)