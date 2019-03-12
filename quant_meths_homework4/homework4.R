############
# Preamble #
############

## ---- load_libraries_data ----
# Load packages
library(knitr)
library(broom)
library(car)
library(plyr)
library(boot)
library(coin)

# Load the dataset
adj <- read.csv("Lynott_Connell_2009.csv")

########################
# Models and functions #
########################

# Create linear regression model
senses.lm <- lm(BNCLogFrequency ~
                  VisualStrengthMean +
                  HapticStrengthMean +
                  AuditoryStrengthMean +
                  OlfactoryStrengthMean +
                  GustatoryStrengthMean,
                data = adj)

# Perform a one-way ANOVA test and get summary
senses.anova <- lm(BNCLogFrequency ~
                     DominantModality,
                   data = adj)
senses.anova.summary <- summary(senses.anova)

# Create a function for getting regression coefficients
bootcoef <- function(formula,
                     data,
                     indices)
                {
                d <- data[indices,]
                model <- lm(formula,
                            data = d)
                return(coef(model))
                }

# Create a non-parametric regression model with bootstrapping
senses.boot <- boot(formula = BNCLogFrequency ~
                      VisualStrengthMean +
                      HapticStrengthMean +
                      AuditoryStrengthMean +
                      OlfactoryStrengthMean +
                      GustatoryStrengthMean,
                    data = adj,
                    statistic = bootcoef,
                    R = 2000)

# Get the confidence intervals for the bootstrapped model
senses.boot.ci1 <- boot.ci(senses.boot,
                           type = "bca",
                           index = 1)
senses.boot.ci2 <- boot.ci(senses.boot,
                           type = "bca",
                           index = 2)
senses.boot.ci3 <- boot.ci(senses.boot,
                           type = "bca",
                           index = 3)
senses.boot.ci4 <- boot.ci(senses.boot,
                           type = "bca",
                           index = 4)
senses.boot.ci5 <- boot.ci(senses.boot,
                           type = "bca",
                           index = 5)
senses.boot.ci6 <- boot.ci(senses.boot,
                           type = "bca",
                           index = 6)

# Perform the non-parametric approximative K-sample permutation test
senses.anova.ksamp <- oneway_test(BNCLogFrequency ~
                                    DominantModality,
                                  data = adj,
                                  distribution = approximate(B = 9999))

####################
# Assumption tests #
####################

# Non-constant variance score test for the multiple regression model
senses.lm.ncv <- ncvTest(senses.lm)
senses.lm.ncv.visual <- ncvTest(senses.lm,
                                ~ VisualStrengthMean)

# Multicollinearity test (VIF) for the multiple regression model
senses.lm.vif <- vif(senses.lm)

# Autocorrelation test (Durbin-Watson) for the multiple regression model
senses.lm.dw <- durbinWatsonTest(senses.lm)

# Normality test (Shapiro-Wilk) for the multiple regression model
senses.lm.sw <- shapiro.test(senses.lm$residuals)

# Levene's test for homogeneity of variance for the ANOVA
senses.anova.lev <- leveneTest(senses.anova)

##########
# Tables #
##########

## ---- linear_model_summary ----
# Put the summary of senses.lm into a printable table
kable(tidy(senses.lm),
      format = "latex")

## ---- linear_model_vif_scores ----
# Results of multiollinearity test (VIF) for the multiple regression model
kable(senses.lm.vif,
      col.names = "VIF")

## ---- anova_normality ----
# Normality test (Shapiro-Wilk) for the ANOVA
kable(aggregate(BNCLogFrequency ~
                  DominantModality,
                data = adj,
                function(x)
                  shapiro.test(x)$p.value),
      col.names = c("Dominant Modality",
                    "P-value"))

##########
# Graphs #
##########

## ---- bnc_freq_boxplots ----
# Box plots showing the distribution of the frequency of words by which sense they were classified under according to their ratings.
plot(BNCLogFrequency ~
       DominantModality,
     data = adj,
     xlab = "Dominant Modality",
     ylab = "Log of BNC Word Frequency")

## ---- bnc_freq_visual_crplot ----
# A component-residual plot for visual ratings.
crPlot(senses.lm,
       var = "VisualStrengthMean",
       xlab = "Visual Strength Mean Rating",
       ylab = "Component-Residual (Word Frequency)")

## ---- bnc_freq_qqplot ----
# A Q-Q plot for the multiple regression model
plot(senses.lm,
     which = 2)