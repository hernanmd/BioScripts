install.packages("PredictABEL")
# brew cask install gfortran
# For R version 3.5.0
sessionInfo()
devtools::install_version("latticeExtra", version="0.6-28", dependencies = T)
devtools::install_version("caTools", version="1.16", dependencies = T)
install.packages("Hmisc",dependencies = T)
install.packages("car")
library(latticeExtra)
library(PredictABEL)
library(car)

setwd('/Users/mvs/IGEVET/gaby')
setwd('d:\\Hernan\\Proyectos\\Por-Usuario\\Gaby\\')

# Input CSV files generated from
inputDataLR <- read.csv('REPORT_PredictAbel_mOR-LR.csv',header = T, sep = '\t')
inputDataRLCC <- read.csv('REPORT_PredictAbel_mOR-RLCC.csv',header = T, sep = '\t')

# CONDITION 
cOutcome <- 2

# specify column numbers of non-genetic predictors
# Column 3 = AGE
cNonGenPred <- c(3)

# specify column numbers of non-genetic predictors that are categorical
# Column 4 = SEX
# Column 5 = BREED
cNonGenPredCat <- c(4,6:8)

# specify column numbers of genetic predictors
cGenPred <- c(0)
# specify column numbers of genetic predictors that are categorical
cGenPredCat <- c(0)



?fitLogRegModel 
# fit logistic regression model
riskmodelLR <- fitLogRegModel(
  data = inputDataLR, 
  cOutcome = cOutcome,
  cNonGenPreds = cNonGenPred,
  cNonGenPredsCat = cNonGenPredCat,
  cGenPreds = cGenPred, 
  cGenPredsCat = cGenPredCat)

summary(riskmodelLR)

# obtain multivariate OR(95% CI) for all predictors of the fitted model
ORmultivariate(
  riskModel = riskmodelLR, 
  filename = "multiOR_LR.csv")



# fit logistic regression model
riskmodelRLCC <- fitLogRegModel(
  data = inputDataRLCC, 
  cOutcome = cOutcome,
  cNonGenPreds = cNonGenPred,
  cNonGenPredsCat = cNonGenPredCat,
  cGenPreds = cGenPred, 
  cGenPredsCat = cGenPredCat)

# obtain multivariate OR(95% CI) for all predictors of the fitted model
ORmultivariate(
  riskModel = riskmodelRLCC, 
  filename = "multiOR_RLCC.csv")
