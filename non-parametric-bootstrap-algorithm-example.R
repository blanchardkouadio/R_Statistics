# We select a sample from the population. In this example, we select a sample
# from a known population that follows the normal curve and with mean = 60 and sd = 8
set.seed(4791)
my_sample <- rnorm(50, mean = 60, sd = 8)

# We sample multiple times with replacement from the selected sample
n_samples <- 10000
n <- 50

my_means <- 1:10000

for (i in 1:n_samples){
  bootstrap_sample <- sample(my_sample, n, replace = TRUE)
  my_means[i] <- mean(bootstrap_sample)
}

# We have an empirical distribution of the statistic (here the means)
# Let's look at it
hist(my_means)

# Unlike when we used the normal distribution for parametric bootstrapping,
# we did not know that this distribution would turn out to be normal, except via the CLT.
# Let's calculate our best point estimate of the population mean.
sample_mean <- mean(my_means)

# Let's calculate the bootstrap estimate of the standard error.
stand_err <- sd(my_means)

# Let's determine the confidence interval. 
# First we need to sort the means
my_means <- sort(my_means)

# For a 95% interval, we need to cut off 2.5% off of each end. 
# We used 10,000 samples.
cut_off <- 0.025*n_samples
confid_int_limits <- c(my_means[cut_off + 1], my_means[n_samples - cut_off])


