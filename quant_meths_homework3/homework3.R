#########################
# Preamble/Data sorting #
#########################

## ---- load_libraries_data ----
# Load both the required libraries and data.
library(languageR)
library(ggplot2)
library(plyr)
library(car)

# Load the dataset
data(ratings)

###########################
# Weights and familiarity #
###########################

# Create a subset of ratings that is just the animals
ratings.animals <- data.frame(meanWeightRating = ratings[ratings$Class == "animal",]$meanWeightRating,
                              meanFamiliarity = ratings[ratings$Class == "animal",]$meanFamiliarity)

# Create a subset of ratings that is just the plants
ratings.plants <- data.frame(meanWeightRating = ratings[ratings$Class == "plant",]$meanWeightRating,
                             meanFamiliarity = ratings[ratings$Class == "plant",]$meanFamiliarity)

#####################################
# Graphs of weights and familiarity #
#####################################

## ---- weights_boxplots ----
# Create side by side boxplots comparing the weight ratings for plants vs animals
ggplot(ratings,
       aes(y = meanWeightRating,
           x = Class)) +
  labs(x = "Object class",
       y = "Mean weight ratings from 1 to 7") +
  geom_boxplot()

## ---- weights_histogram_animals ----
# Create a histogram for the weight ratings for animals
ggplot(ratings.animals,
       aes(x = meanWeightRating)) +
  labs(x = "Mean weight ratings from 1 to 7",
       y = "Frequency") +
  geom_histogram(bins = 10)

## ---- weights_histogram_plants ----
# Create a histogram for the weight ratings for plants
ggplot(ratings.plants,
       aes(x = meanWeightRating)) +
  labs(x = "Mean weight ratings from 1 to 7",
       y = "Frequency") +
  geom_histogram(bins = 10)

## ---- familiarity_boxplots ----
# Create side by side boxplots comparing the familiarity ratings for plants vs animals
ggplot(ratings,
       aes(y = meanFamiliarity,
           x = Class)) +
  labs(x = "Object class",
       y = "Mean familiarity ratings from 1 to 7") +
  geom_boxplot()

####################################
# Tests of weights and familiarity #
####################################

## ---- weights_shapiro_animals ----
# Perform a Shapiro-Wilk test for normality for the weight ratings for animals.
ratings.animals.weights.shapiro <- shapiro.test(ratings.animals$meanWeightRating)

## ---- weights_shapiro_plants ----
# Perform a Shapiro-Wilk test for normality for the weight ratings for plants.
ratings.plants.weights.shapiro <- shapiro.test(ratings.plants$meanWeightRating)

## ---- weights_wilcox ----
# Perform a non-parametric Wilcoxon rank sum test between the weight ratings for animals and plants.
ratings.weights.wilcox <- wilcox.test(ratings.plants$meanWeightRating,
                                      ratings.animals$meanWeightRating,
                                      alternative = "greater")

## ---- famil_shapiro_animals ----
# Perform a Shapiro-Wilk test for normality for the familiarity ratings for animals.
ratings.animals.famil.shapiro <- shapiro.test(ratings.animals$meanFamiliarity)

## ---- famil_shapiro_plants ----
# Perform a Shapiro-Wilk test for normality for the familiarity ratings for plants.
ratings.plants.famil.shapiro <- shapiro.test(ratings.plants$meanFamiliarity)

## ---- famil_ttest ----
# Perform a t-test for the difference in means between the familiarity ratings for animals and plants.
ratings.famil.ttest <- t.test(ratings.plants$meanFamiliarity,
                              ratings.animals$meanFamiliarity,
                              alternative = "two.sided")

#########################################
# Frequency and familiarity correlation #
#########################################

## ---- freq_famil_scatterplot ----
# Create a scatterplot for the relationship between frequency and familiarity ratings
ggplot(ratings,
       aes(x = Frequency,
           y = meanFamiliarity)) +
  labs(y = "Mean Familiarity Rating") +
  geom_point()

## ---- freq_famil_regression ----
# Get the intercept and slope for the least squares line for the relationship between frequency and familiarity
freq.famil.regression <- lm(meanFamiliarity ~ Frequency,
                            data = ratings)

## ---- freq_famil_variance ----
# Test whether the variane of the residuals is constant or not
freq.famil.variance <- ncvTest(freq.famil.regression)

## ---- freq_famil_autocor ----
# Test whether the residuals are autocorrelated
freq.famil.autocor <- durbinWatsonTest(freq.famil.regression)

## ---- freq_famil_r ----
# Get the correlation coefficient for the relationship between frequency and familiarity and test whether it is statistially significant.
freq.famil.r <- cor.test(ratings$Frequency,
                         ratings$meanFamiliarity,
                         alternative = "two.sided",
                         method = "pearson")

## ---- freq_famil_scatterplot_line ----
# Recreate the scatterplot for the relationship between frequency and familiarity ratings but add the regression line
ggplot(ratings,
       aes(x = Frequency,
           y = meanFamiliarity)) +
  labs(y = "Mean Familiarity Rating") +
  geom_point() +
  stat_smooth(method = lm)
