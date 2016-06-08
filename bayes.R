
## For dataset information:
## https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/trees.html

n <- nrow(trees)

ols <- lm(Height ~ Girth, data = trees)
summary(ols)

err <- residuals(ols)
sd(err)

library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

## I don't know much about cherry trees, but if the girth is measured
## "at 4 ft 6 in above the ground", 6ft = 72in seems like a plausible
## guess for the population average (the intercept). 5 seems
## reasonable for the std dev of the constant. we use a N(0,1) dist
## for the coefficient
indata <- list(n     = n,
               sigma = 5,
               tau   = c(5, 1),
               mu    = c(72, 0),
               x     = trees$Girth,
               y     = trees$Height)

bayes <- stan(file = 'slr.stan',
              data = indata,
              iter = 1000, chains = 4)


