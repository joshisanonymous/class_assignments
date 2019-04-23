# This script performs statistical analyses of the 3rd
# person plural subject pronouns from four interviews
# with Louisiana French speakers. The data come from the
# output bof cleaning.R. This script also generates
# any graphs and tables that are needed.
#
# This script is evaluated by third_person.Rnw.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

## ---- load_libraries_data ----
# Read in data
tp <- read.csv("third_person_cleaned.csv")

# Load packages
library(plyr)
library(ggplot2)
library(rms)
library(lme4)

################
#   Analyses   #
################

# Initial model with all factors included
tp.glmer <- glmer(PRONOUN ~
                    (1|SPEAKER) +
                    VERB.TYPE +
                    ANIMACY +
                    SPECIFICITY +
                    REF.DISTANCE,
                  data = tp,
                  family = binomial)

# Create object just for model coefs to make extracting
# values easier
tp.glmer.coefs <- summary(tp.glmer)$coef

# Removed non-significant factors (i.e., specificity)
tp.glmer.final <- glmer(PRONOUN ~
                          (1|SPEAKER) +
                          VERB.TYPE +
                          REF.DISTANCE,
                        data = tp,
                        family = binomial)

# Create object just for the final model coefs to make
# extracting values easier
tp.glmer.final.coefs <- summary(tp.glmer.final)$coef

################
#    Graphs    #
################

## ---- dist_overall ----
ggplot(tp,
       aes(x = PRONOUN)) +
  theme_bw(8) +
  labs(x = "3rd Person Plural Subject Pronoun",
       y = "Frequency") +
  geom_bar()

## ---- dist_by_speaker ----
ggplot(tp,
       aes(x = PRONOUN)) +
  facet_wrap(. ~ SPEAKER,
             nrow = 2,
             ncol = 2) +
  theme_bw(8) +
  labs(x = "3rd Person Plural Subject Pronoun",
       y = "Frequency") +
  geom_bar()

## ---- dist_by_verb_and_dist ----
ggplot(tp,
       aes(x = PRONOUN)) +
  facet_grid(REF.DISTANCE ~ VERB.TYPE) +
  theme_bw(8) +
  labs(x = "3rd Person Plural Subject Pronoun",
       y = "Frequency") +
  geom_bar()