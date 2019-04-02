############
# Preamble #
############

## ---- load_libraries_data ----
# Load packages
library(knitr)
library(plyr)
library(ggplot2)
library(lme4)
library(visreg)
library(broom)

# Load the dataset
pin_pen <- read.csv("pin_pen.csv")

# Convert speaker to a factor instead of numeric
pin_pen$speaker <- as.factor(pin_pen$speaker)

# Change the reference level of the vowel column so that IH is the reference level
pin_pen$vowel <- relevel(pin_pen$vowel,
                         ref = "IH")

##########
# Models #
##########
  
# Build the initial model to predict F1 with only speaker as a random intercept
pin_pen_lme0 <- lmer(F1 ~
                       1 +
                       (1|speaker),
                     data = pin_pen,
                     REML = FALSE)

# Define the order for adding factors
factors <- c("vowel",
             "birth_year",
             "land_region",
             "state",
             "social_status",
             "education",
             "ethnicity",
             "sex")

# Add factors one by one
pin_pen_lme1 <- update(pin_pen_lme0,
                       paste(".~. + ", factors[1]))
pin_pen_lme2 <- update(pin_pen_lme1,
                       paste(".~. + ", factors[2]))
pin_pen_lme3 <- update(pin_pen_lme2,
                       paste(".~. + ", factors[3]))
pin_pen_lme4 <- update(pin_pen_lme3,
                       paste(".~. + ", factors[4]))
pin_pen_lme5 <- update(pin_pen_lme4,
                       paste(".~. + ", factors[5]))
pin_pen_lme6 <- update(pin_pen_lme5,
                       paste(".~. + ", factors[6]))
pin_pen_lme7 <- update(pin_pen_lme6,
                       paste(".~. + ", factors[7]))
pin_pen_lme8 <- update(pin_pen_lme7,
                       paste(".~. + ", factors[8]))

# Test whether the model improved or not with each additional factor
pin_pen_lme_anova <- anova(pin_pen_lme0,
                           pin_pen_lme1,
                           pin_pen_lme2,
                           pin_pen_lme3,
                           pin_pen_lme4,
                           pin_pen_lme5,
                           pin_pen_lme6,
                           pin_pen_lme7,
                           pin_pen_lme8)

# Redo them without the ones that weren't significant
pin_pen_lme_final <- lmer(F1 ~ 1 +
                            (1|speaker) +
                            (1|word) +
                            vowel +
                            state +
                            social_status +
                            education +
                            ethnicity,
                          data = pin_pen,
                          REML = FALSE)

# Create another, simpler model to interpret with EH as the reference vowel to predict
# speaker 412's F1
fit_EHref <- lmer(F1 ~
                    relevel(vowel,
                            ref = "IH") +
                    social_status +
                    (1|speaker),
                  data = pin_pen,
                  REML = FALSE)

# Get the interept for speaker 412
fit_intercept_412 <- coef(fit_EHref)$speaker["412", 1]

# Get the social classes of speaker 412
fit_class_412 <- head(pin_pen[pin_pen$speaker == "412",
                              "social_status"],
                      1) # It's Upper Middle (i.e., 5.55)

# Use the preceding values to calculate 412's predicted F1
F1_predicted_412 <- fit_intercept_412 + 5.55

# Create the same model with IH as a reference vowel to predict speaker 662's
# F1
fit_IHref <- lmer(F1 ~
                    relevel(vowel,
                            ref = "EH") +
                    social_status +
                    (1|speaker),
                  data = pin_pen,
                  REML = FALSE)

# Get the interept for speaker 662
fit_intercept_662 <- coef(fit_IHref)$speaker["662", 1]

# Get the social classes of speaker 662
fit_class_662 <- head(pin_pen[pin_pen$speaker == "662",
                              "social_status"],
                      1) # It's Lower Middle (i.e., 21.327)

# Use the preceding values to calculate 662's predicted F1
F1_predicted_662 <- fit_intercept_662 + 21.327

##########
# Graphs #
##########

## ---- pin_pen_vowel_plot ----
# Build a scatterplot showing the distribution of each vowel
ggplot(pin_pen,
       aes(x = F2,
           y = F1,
           color = vowel)) +
  scale_x_reverse() +
  scale_y_reverse() +
  geom_point()

##########
# Tables #
##########

## ---- pin_pen_lme_anova_result ----
# Create a simpler data frame for the printable table
pin_pen_lme_anova_df <- data.frame("Terms" = c("(Intercept)", factors),
                                   "AIC" = round(pin_pen_lme_anova$AIC),
                                   "BIC" = round(pin_pen_lme_anova$BIC),
                                   "P.value.less.than" = round_any(pin_pen_lme_anova$`Pr(>Chisq)`,
                                                                   0.001,
                                                                   ceiling))

# Use the data frame to actually create a printable table  
kable(pin_pen_lme_anova_df,
      format = "latex")
