install.packages("lubridate")

library(stats)
library("lubridate")
library(ggplot2)

d <- days(356)
time_length(d,unit="months")

getwd()
setwd("IGEVET/gaby")
sanos_lr <- scan("joined_2019-12-20_20-15-54.txt")
sanos_rlcc <- scan("joined_2019-12-20_20-15-51.txt")

pval_sanos_lr <- wilcox.test(sanos_lr, alternative = "two.sided")
pval_sanos_rlcc <- wilcox.test(sanos_rlcc, alternative = "two.sided")

pval_sanos_lr
pval_sanos_rlcc



