# We select a sample from a population with unknown parameters. 
# But in this example we assume mean = 60 and sd = 8
set.seed(4791) # To ensure that the numbers we are going to generate after that will be based on the numbers generated here.
my_sample <- rnorm(50, mean = 60, sd = 8)


# We calculate the estimators of the mean and the sd from our sample
my_sample_mean <- mean(my_sample)
my_sample_sd <- sd(my_sample)


# We draw 10,000 bootstrap samples from a normal distribution with these parameters.
# At every draw, we calculate the mean and the sd
n_samples <- 10000
n <- 50

my_means <- 1:10000

for (i in 1:n_samples){
  bootstrap_sample <- rnorm(n, mean = my_sample_mean, sd = my_sample_sd)  
  my_means[i] <- mean(bootstrap_sample)
}

# We got an empirical sampling distributions of means. Let's look at it.
hist(my_means)

# We calculate our best point estimate of the population mean.
fin_sample_mean <- mean(my_means)

# Our interest here is the sd of our means, which will be the bootstrap estimate of the SE.
stand_err <- sd(my_means)

# To find the confidence interval, we could use this and the 97.5 percentile of the normal distribution
# (which you know to be 1.96) and create a confidence interval. Better yet, we could use a percentile of 
# a t-distribution to help us create this interval. After all, remember that we estimated the standard deviation,
# so that should lead us to the t_distribution. What is typically done, however, is neither of these. 
# Instead, we cut off the tails of our sampling distribution to find the confidence interval.
# We can proceed like this whether the distribution is normal or not.
# First we need to sort the means.

my_means <- sort(my_means)

# For a 95% interval, we need to cut off 2.5% off of each end. How many values is that?
cut_off <- 0.025 * n_samples

# We want to cut off 250 from each end. That means I want to retain the 251st value
# in my ordered listed of means all the way to the 9750th value. Let's look at the two ends of the retained list.
confid_int_limits <- c(my_means[cut_off + 1], my_means[n_samples - cut_off])


