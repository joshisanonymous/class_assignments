# This script performs statistical analyses of the T-V 
# data output by cleaning.R. It also generates graphs
# and tables.
#
# This script is evaluated by nccfr_tv.Rnw.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

## ---- load_libraries_data ----
# Read in data
tv <- read.csv("nccfr_tv_cleaned.csv")

# Load packages
library(rms)
library(plyr)

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

tv.lrm.plus.val <- validate(tv.lrm.plus,
                            B = 200)

tv.lrm.final <- lrm(TV ~
                      GENDER,
                    data = tv)

################
#    Graphs    #
################

## ---- final_model ----
ggplot(tv,
       aes(x = GENDER)) +
  geom_bar()
