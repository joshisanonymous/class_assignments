# This script performs statistical analyses of the T-V 
# data output by cleaning.R. It also generates graphs
# and tables.
#
# This script is evaluated by nccfr_tv.Rnw.
#
# N.b. Some R code is in nccfr_tv.Rnw itself.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

## ---- load_libraries_data ----
# Read in data
tv <- read.csv("nccfr_tv_cleaned.csv")

# Load packages
library(rms)
library(plyr)
library(knitr)

################
#   Analyses   #
################

# Create an initial model with all the factors included
tv.lrm <- lrm(TV ~
                GENDER +
                REGION +
                AGE,
              data = tv)

# Use the anova function to extract coefficient P-values
tv.lrm.anova <- anova(tv.lrm)

# Create a glm version so as to use stepwise factor selection
tv.glm <- glm(TV ~
                GENDER +
                REGION +
                AGE,
              data = tv,
              family = binomial)

# Use step-down selection
tv.glm.bw <- step(tv.glm,
                  direction = "backward",
                  trace = FALSE)

# Add x and y to the lrm model to test for overfitting
tv.lrm.plus <- lrm(TV ~
                     GENDER,
                   data = tv,
                   x = TRUE,
                   y = TRUE)

# Test for overfitting
tv.lrm.plus.val <- validate(tv.lrm.plus,
                            B = 200)

# Create models with interactions to test
# for interactions
tv.glm.int1 <- glm(TV ~
                     GENDER*REGION +
                     AGE,
                   data = tv,
                   family = binomial)
tv.glm.int2 <- glm(TV ~
                     GENDER*AGE +
                     REGION,
                   data = tv,
                   family = binomial)
tv.glm.int3 <- glm(TV ~
                     REGION*AGE +
                     GENDER,
                   data = tv,
                   family = binomial)

# Use ANOVAs to test if the interaction models differ
# from the non-interaction model in any significant way
tv.glm.int.test1 <- anova(tv.glm,
                          tv.glm.int1,
                          test = "Chisq")
tv.glm.int.test2 <- anova(tv.glm,
                          tv.glm.int2,
                          test = "Chisq")
tv.glm.int.test3 <- anova(tv.glm,
                          tv.glm.int3,
                          test = "Chisq")

# Create the final model, which includes only GENDER
tv.lrm.final <- lrm(TV ~
                      GENDER,
                    data = tv)

# Perform an ANOVA test to see if the final model and
# the model that includes all facotrs are different to
# a statistically significant degree (doesn't work yet)

# Create glm version of the final model
tv.glm.final <- glm(TV ~
                      GENDER,
                    data = tv,
                    family = binomial)

# Perform actual ANOVA
tv.glm.anova <- anova(tv.glm,
                      tv.glm.final,
                      test = "Chisq")

# Calculte the probability of either a man or a woman
# producing vous given the final model
tv.lrm.final.male <- (exp(tv.lrm.final$coefficients["Intercept"] +
                            tv.lrm.final$coefficients["GENDER=Male"])) /
                     (1 + exp(tv.lrm.final$coefficients["Intercept"] +
                                tv.lrm.final$coefficients["GENDER=Male"]))

tv.lrm.final.female <- (exp(tv.lrm.final$coefficients["Intercept"])) /
                       (1 + exp(tv.lrm.final$coefficients["Intercept"]))

##############
#   Graphs   #
##############

## ---- tv_overall ----
# Barplot of overall distribution of (T-V)
ggplot(tv,
       aes(x = TV)) +
  theme_bw() +
  xlab("(T-V)") +
  ylab("Frequency") +
  geom_bar()

## ---- tv_factors ----
# Set of barplots of the distribution of (T-V) by
# gender and region
ggplot(tv,
       aes(x = TV)) +
  facet_grid(GENDER ~
               REGION) +
  theme_bw() +
  xlab("(T-V)") +
  ylab("Frequency") +
  geom_bar()

## ---- tv_age ----
# Barplot with the proportion of vous vs tu by age
ggplot(tv,
       aes(x = AGE,
           fill = TV)) +
  ylab("Proportion") +
  xlab("Age") +
  labs(fill = "(T-V)") +
  geom_bar(position = "fill")
