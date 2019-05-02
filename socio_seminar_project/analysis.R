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

# Calculate the probability of the ils variant with regular
# verbs and when the referent is not mentioned in the T-unit
tp.glmer.final.ils.prob <- (exp(tp.glmer.final.coefs["(Intercept)", "Estimate"] +
                                  tp.glmer.final.coefs["VERB.TYPERegular Verb", "Estimate"] +
                                  tp.glmer.final.coefs["REF.DISTANCENot in the T-unit", "Estimate"])) /
  (1 + exp(tp.glmer.final.coefs["(Intercept)", "Estimate"] +
             tp.glmer.final.coefs["VERB.TYPERegular Verb", "Estimate"] +
             tp.glmer.final.coefs["REF.DISTANCENot in the T-unit", "Estimate"]))

################
#    Graphs    #
################

## ---- map ----
la.parishes <- subset((map_data("county")),
                      region == "louisiana")
la.parishes.brown <- subset(la.parishes,
                            subregion == "avoyelles" | subregion == "assumption")
la.parishes.brown.centroids <- aggregate(cbind(long,
                                               lat) ~
                                           subregion,
                                         FUN = mean,
                                         data = la.parishes.brown)
la.parishes.brown.centroids$subregion <- c("Assumption",
                                           "Avoyelles")
la.cities.rottet <- data.frame("lat" = 29.5958,
                               "long" = -90.7195,
                               "city" = "Houma")
la.cities.mcneill <- data.frame("lat" = c(30.4583,
                                          30.0996,
                                          29.9511),
                                "long" = c(-91.1403,
                                           -91.9901,
                                           -90.0715),
                                "city" = c("Baton Rouge",
                                           "Youngsville",
                                           "New Orleans"))
la.colors <- data.frame("researcher" = c("Brown",
                                         "Rottet",
                                         "Current"),
                        "color" = c("#E69F00",
                                    "#56B4E9",
                                    "#009E73"))

ggplot() +
  geom_polygon(aes(x = long,
                   y = lat,
                   group = group),
               fill = "grey",
               color = "white",
               data = la.parishes) +
  geom_polygon(aes(x = long,
                   y = lat,
                   group = group),
               fill = la.colors[la.colors$researcher == "Brown", "color"],
               color = NA,
               data = la.parishes.brown) +
  geom_point(aes(x = long,
                 y = lat),
             size = 3.5,
             color = la.colors[la.colors$researcher == "Rottet", "color"],
             data = la.cities.rottet) +
  geom_point(aes(x = long,
                 y = lat),
             size = 3.5,
             color = la.colors[la.colors$researcher == "Current", "color"],
             data = la.cities.mcneill) +
  geom_text(aes(x = long - 0.6,
                y = lat - 0.175,
                label = subregion),
            size = 3,
            data = la.parishes.brown.centroids) +
  geom_text(aes(x = long + 0.3,
                y = lat - 0.2,
                label = city),
            size = 3,
            data = la.cities.rottet) +
  geom_text(aes(x = long + 0.3,
                y = lat + 0.2,
                label = city),
            size = 3,
            data = la.cities.mcneill) +
  theme_bw() +
  theme(axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        legend.position = "right") +
  scale_color_manual(values = la.colors$color,
                     labels = la.colors$researcher,
                     breaks = c(TRUE, TRUE, TRUE)) +
  coord_fixed(1.2)

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