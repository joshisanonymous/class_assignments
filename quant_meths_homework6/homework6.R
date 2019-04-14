############
# Preamble #
############

## ---- load_libraries_data ----
# Load packages
library(ggplot2)
library(rms)
library(plyr)

# Load the dataset
ff <- read.csv("fourthFloor.csv",
               header = TRUE)

##########
# Models #
##########

# Create a logistic regression model with all factors considered
ff.lrm <- lrm(r ~
                word +
                store +
                emphasis,
              data = ff)

# Create the same logistic regression model with glm() so as to have acces
# to the step() function for deciding which factors to keep
ff.glm <- glm(r ~
                word +
                store +
                emphasis,
              data = ff,
              family = binomial)

# Use the step-down process to decide if any factors should be removed
ff.glm.bw <- step(ff.glm,
                  direction = "backward",
                  trace = FALSE)

# Build alternative models that include interactions to test whether these
# improve the model or not
ff.glm.int1 <- glm(r ~
                     word*emphasis +
                     store,
                   data = ff,
                   family = binomial)

ff.glm.int2 <- glm(r ~
                     word*store +
                     emphasis,
                   data = ff,
                   family = binomial)

ff.glm.int3 <- glm(r ~
                     word +
                     store*emphasis,
                   data = ff,
                   family = binomial)

# Perform ANOVAs to see if the interactions improved the model
ff.glm.int1.anova <- anova(ff.glm,
                           ff.glm.int1,
                           test = "Chisq")

ff.glm.int2.anova <- anova(ff.glm,
                           ff.glm.int2,
                           test = "Chisq")

ff.glm.int3.anova <- anova(ff.glm,
                           ff.glm.int3,
                           test = "Chisq")

# Check for multicollinearity between explanatory variables
ff.lrm.vif <- vif(ff.lrm)

# Add two arguments to the original lrm() model to prepare to test for overfitting
ff.lrm.plus <- lrm(r ~
                     word +
                     store +
                     emphasis,
                   data = ff,
                   x = TRUE,
                   y = TRUE)

# Use bootstrapping to test the modified model for overfitting
ff.lrm.plus.val <- validate(ff.lrm.plus,
                            B = 200)