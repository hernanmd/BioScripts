install.packages("coin")
require(coin)
library(ggplot2)
# https://www.rdocumentation.org/packages/rstatix/versions/0.3.1/topics/wilcox_test
# https://www.chegg.com/homework-help/questions-and-answers/installpackages-coin-needs-done-oncelibrary-coin-calculate-pairwise-differenceswmwdif-q32099973
# http://dwoll.de/rexrepos/posts/npWilcoxon.html
# https://books.google.com.ar/books?id=EzylDAAAQBAJ&pg=PA170&lpg=PA170&dq=%22wilcox_test%22&source=bl&ots=laA4q-rKL4&sig=ACfU3U0SM75S8R_HRaoRVppZUUicJONGmg&hl=es&sa=X&ved=2ahUKEwiz-PHhgNXmAhUQJ7kGHQtIDM0Q6AEwCHoECAoQAQ#v=onepage&q=%22wilcox_test%22&f=false


getwd()
setwd("d:\\Hernan\\Proyectos\\Por-Usuario\\Gaby\\")

grupo_control_LR <- scan("joined_2019-12-20_20-15-54.txt")
grupo_caso_LR <- c(3650, 730, 2555, 365, 2190, 1460, 1825, 730, 2920, 4380, 2920, 1095, 1095, 1095, 730, 2920, 365, 1825, 3285, 4015, 1095, 365, 2920, 730, 2555, 1095, 2920, 1460, 2190, 1460, 4380, 2190, 2920, 2190, 730, 1825, 2920, 730, 3285, 2555, 2555, 1095, 3650, 730, 365, 1825, 2555, 1825, 2920, 2190, 2190, 3650, 4015, 3285, 730, 2920, 365, 1460, 365, 4380, 2190, 2920, 1460, 2555, 1460, 1460, 730, 1460, 2555, 1460, 1825, 730)

ts <- length(grupo_caso_LR) + length(grupo_control_LR)

datos <- data.frame(
  grupo = rep(c("CASO_RLCC", "CONTROL_RLCC"),
              c(length(grupo_caso_RLCC), length(grupo_control_RLCC))),
  valores = c(grupo_caso_RLCC, grupo_control_RLCC),
  cordenada_y = rep(0, ts))

r_exact <- wilcox_test(
  valores ~ grupo, 
  data = datos, 
  distribution = "exact", 
  conf.int = 0.95)

r_approx <- wilcox_test(
  valores ~ grupo, 
  data = datos, 
  distribution = "approximate", 
  conf.int = 0.95)

class(r_exact)

ggplot(
  data = datos, 
    aes(x = valores, y = cordenada_y)) +
    geom_point(aes(colour = grupo), size = 3) +
    ylab("") + 
    xlab("rango") +
    theme_bw() +
    theme(axis.text.y = element_blank()) + 
    ggtitle("Muestras procedentes de la misma poblacion")

sanos_lr <- scan("joined_2019-12-20_20-15-54.txt")
