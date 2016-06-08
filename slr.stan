
data {
  int n;                 // number of observations

  real<lower=0> sigma;   // error std dev

  real<lower=0> tau[2];  // regression parameter prior std dev
  real mu[2];            // regression parameter prior mean

  real x[n];
  real y[n];
}
parameters {
  real b0;
  real b1;
}
transformed parameters {
  real theta[n];

  for (i in 1:n)
    theta[i] <- b0 + b1 * x[i];
}
model {
  b0 ~ normal(mu[1], tau[1]);
  b1 ~ normal(mu[2], tau[2]);

  y ~ normal(theta, sigma);
}

