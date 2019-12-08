## ---- load_libraries_variables_functions ----
library(ggplot2)
library(adehabitatHR)

data_dir <- "./data/"

load_csv <- function(filename){
  read.csv(paste(data_dir, filename, sep = ""),
           fileEncoding = "UTF-8",
           encoding = "UTF-8")
}

convert_sampa_ipa <- function(vector){
  vector <- gsub("E", "ɛ", vector)
  vector <- gsub("A/", "ɑ", vector)
  vector <- gsub("9", "œ", vector)
  vector <- gsub("O/", "ɔ", vector)
  vector <- gsub("2", "ø", vector)
  vector <- gsub("@", "ə", vector)
  vector <- gsub("a~", "ɑ̃", vector)
  vector <- gsub("U~/", "ɛ̃", vector)
  vector <- gsub("O~", "ɔ̃", vector)
  return(as.factor(vector))
}

make_uppercase <- function(vector){
  vector <- gsub("coulson", "Coulson", vector)
  vector <- gsub("talbot", "Talbot", vector)
  vector <- gsub("fitz", "Fitz", vector)
  vector <- gsub("ward", "Ward", vector)
  vector <- gsub("josh", "Josh", vector)
  return(as.factor(vector))
}

mean_space <- function(df){
  ggplot(data = df) +
    aes(x = F2, y = F1, label = PHONEME) +
    scale_x_reverse(name = "F2 (Hz)") +
    scale_y_reverse(name = "F1 (Hz)") +
    coord_cartesian(xlim = c(500, 2750),
                    ylim = c(200, 900)) +
    theme_classic() +
    geom_label()
}

nasal_histograms <- function(df, col){
  ggplot(data = df) +
    aes(x = col, fill = PHONEME) +
    geom_histogram(alpha=0.2,
                   position="identity",
                   binwidth = 15) +
    theme_classic() +
    facet_wrap(~ SPEAKER,
               ncol = 2) +
    labs(x = "Hz", y = "Count")
}

get_vowel_means <- function(df){
  df_schwa <- df[df$PHONEME == "@",]
    mean_schwa <- data.frame("PHONEME" = "@",
                             "F1" = mean(df_schwa$F1),
                             "F2" = mean(df_schwa$F2),
                             "F3" = mean(df_schwa$F3),
                             "SPEAKER" = df_schwa$SPEAKER[1])
  df_highmidfrontround <- df[df$PHONEME == "2",]
    mean_highmidfrontround <- data.frame("PHONEME" = "2",
                                         "F1" = mean(df_highmidfrontround$F1),
                                         "F2" = mean(df_highmidfrontround$F2),
                                         "F3" = mean(df_highmidfrontround$F3),
                                         "SPEAKER" = df_highmidfrontround$SPEAKER[1])
  df_lowmidfrontround <- df[df$PHONEME == "9",]
    mean_lowmidfrontround <- data.frame("PHONEME" = "9",
                                        "F1" = mean(df_lowmidfrontround$F1),
                                        "F2" = mean(df_lowmidfrontround$F2),
                                        "F3" = mean(df_lowmidfrontround$F3),
                                        "SPEAKER" = df_lowmidfrontround$SPEAKER[1])
  df_lowback <- df[df$PHONEME == "A/",]
    mean_lowback <- data.frame("PHONEME" = "A/",
                               "F1" = mean(df_lowback$F1),
                               "F2" = mean(df_lowback$F2),
                               "F3" = mean(df_lowback$F3),
                               "SPEAKER" = df_lowback$SPEAKER[1])
  df_lowbacknasal <- df[df$PHONEME == "a~",]
    mean_lowbacknasal <- data.frame("PHONEME" = "a~",
                                    "F1" = mean(df_lowbacknasal$F1),
                                    "F2" = mean(df_lowbacknasal$F2),
                                    "F3" = mean(df_lowbacknasal$F3),
                                    "SPEAKER" = df_lowbacknasal$SPEAKER[1])
  df_highmidfront <- df[df$PHONEME == "e",]
    mean_highmidfront <- data.frame("PHONEME" = "e",
                                    "F1" = mean(df_highmidfront$F1),
                                    "F2" = mean(df_highmidfront$F2),
                                    "F3" = mean(df_highmidfront$F3),
                                    "SPEAKER" = df_highmidfront$SPEAKER[1])
  df_lowmidfront <- df[df$PHONEME == "E",]
    mean_lowmidfront <- data.frame("PHONEME" = "E",
                                   "F1" = mean(df_lowmidfront$F1),
                                   "F2" = mean(df_lowmidfront$F2),
                                   "F3" = mean(df_lowmidfront$F3),
                                   "SPEAKER" = df_lowmidfront$SPEAKER[1])
  df_highfront <- df[df$PHONEME == "i",]
    mean_highfront <- data.frame("PHONEME" = "i",
                                 "F1" = mean(df_highfront$F1),
                                 "F2" = mean(df_highfront$F2),
                                 "F3" = mean(df_highfront$F3),
                                 "SPEAKER" = df_highfront$SPEAKER[1])
  df_lowmidbackround <- df[df$PHONEME == "O/",]
    mean_lowmidbackround <- data.frame("PHONEME" = "O/",
                                       "F1" = mean(df_lowmidbackround$F1),
                                       "F2" = mean(df_lowmidbackround$F2),
                                       "F3" = mean(df_lowmidbackround$F3),
                                       "SPEAKER" = df_lowmidbackround$SPEAKER[1])
  df_lowmidbacknasal <- df[df$PHONEME == "O~",]
    mean_lowmidbacknasal <- data.frame("PHONEME" = "O~",
                                       "F1" = mean(df_lowmidbacknasal$F1),
                                       "F2" = mean(df_lowmidbacknasal$F2),
                                       "F3" = mean(df_lowmidbacknasal$F3),
                                       "SPEAKER" = df_lowmidbacknasal$SPEAKER[1])
  df_highbackround <- df[df$PHONEME == "u",]
    mean_highbackround <- data.frame("PHONEME" = "u",
                                     "F1" = mean(df_highbackround$F1),
                                     "F2" = mean(df_highbackround$F2),
                                     "F3" = mean(df_highbackround$F3),
                                     "SPEAKER" = df_highbackround$SPEAKER[1])
  df_frontnasal <- df[df$PHONEME == "U~/",]
    mean_frontnasal <- data.frame("PHONEME" = "U~/",
                                  "F1" = mean(df_frontnasal$F1),
                                  "F2" = mean(df_frontnasal$F2),
                                  "F3" = mean(df_frontnasal$F3),
                                  "SPEAKER" = df_frontnasal$SPEAKER[1])
  df_highfrontround <- df[df$PHONEME == "y",]
    mean_highfrontround <- data.frame("PHONEME" = "y",
                                     "F1" = mean(df_highfrontround$F1),
                                     "F2" = mean(df_highfrontround$F2),
                                     "F3" = mean(df_highfrontround$F3),
                                     "SPEAKER" = df_highfrontround$SPEAKER[1])
  df_means <- rbind(mean_schwa,
                    mean_highmidfrontround,
                    mean_lowmidfrontround,
                    mean_lowback,
                    mean_lowbacknasal,
                    mean_highmidfront,
                    mean_lowmidfront,
                    mean_highfront,
                    mean_lowmidbackround,
                    mean_lowmidbacknasal,
                    mean_highbackround,
                    mean_frontnasal,
                    mean_highfrontround)
  return(df_means)
}

get_affinity <- function(df){
  nasal_spatdf <- SpatialPointsDataFrame(cbind(df$F1, df$F2),
                                         data.frame(df$PHONEME))
  kerneloverlap(nasal_spatdf, method = "BA")[1, 2]
}

## ---- load_data ----
coulson <- load_csv("formants_coulson.csv")
talbot <- load_csv("formants_talbot.csv")
fitz <- load_csv("formants_fitz.csv")
ward <- load_csv("formants_ward.csv")
josh_coulson <- load_csv("formants_coulsonJosh.csv")
josh_talbot <- load_csv("formants_fitzJosh.csv")
josh_fitz <- load_csv("formants_fitzJosh.csv")
josh_ward <- load_csv("formants_wardJosh.csv")

josh <- rbind(josh_coulson,
              josh_talbot,
              josh_fitz,
              josh_ward)

rm(josh_coulson,
   josh_talbot,
   josh_fitz,
   josh_ward)

all <- rbind(coulson,
             talbot,
             fitz,
             ward,
             josh)

coulson_nasals <- coulson[coulson$PHONEME == "a~" | coulson$PHONEME == "O~",]
talbot_nasals <- talbot[talbot$PHONEME == "a~" | talbot$PHONEME == "O~",]
fitz_nasals <- fitz[fitz$PHONEME == "a~" | fitz$PHONEME == "O~",]
ward_nasals <- ward[ward$PHONEME == "a~" | ward$PHONEME == "O~",]
josh_nasals <- josh[josh$PHONEME == "a~" | josh$PHONEME == "O~",]
all_nasals <- all[all$PHONEME == "a~" | all$PHONEME == "O~",]

coulson_means <- get_vowel_means(coulson)
talbot_means <- get_vowel_means(talbot)
fitz_means <- get_vowel_means(fitz)
ward_means <- get_vowel_means(ward)
josh_means <- get_vowel_means(josh)
all_means <- rbind(coulson_means,
                   talbot_means,
                   fitz_means,
                   ward_means,
                   josh_means)

## ---- clean_data ----
coulson$PHONEME <- convert_sampa_ipa(coulson$PHONEME)
talbot$PHONEME <- convert_sampa_ipa(talbot$PHONEME)
fitz$PHONEME <- convert_sampa_ipa(fitz$PHONEME)
ward$PHONEME <- convert_sampa_ipa(ward$PHONEME)
josh$PHONEME <- convert_sampa_ipa(josh$PHONEME)
all$PHONEME <- convert_sampa_ipa(all$PHONEME)
coulson_means$PHONEME <- convert_sampa_ipa(coulson_means$PHONEME)
talbot_means$PHONEME <- convert_sampa_ipa(talbot_means$PHONEME)
fitz_means$PHONEME <- convert_sampa_ipa(fitz_means$PHONEME)
ward_means$PHONEME <- convert_sampa_ipa(ward_means$PHONEME)
josh_means$PHONEME <- convert_sampa_ipa(josh_means$PHONEME)
all_means$PHONEME <- convert_sampa_ipa(all_means$PHONEME)
coulson_nasals$PHONEME <- convert_sampa_ipa(coulson_nasals$PHONEME)
talbot_nasals$PHONEME <- convert_sampa_ipa(talbot_nasals$PHONEME)
fitz_nasals$PHONEME <- convert_sampa_ipa(fitz_nasals$PHONEME)
ward_nasals$PHONEME <- convert_sampa_ipa(ward_nasals$PHONEME)
josh_nasals$PHONEME <- convert_sampa_ipa(josh_nasals$PHONEME)
all_nasals$PHONEME <- convert_sampa_ipa(all_nasals$PHONEME)

coulson$SPEAKER <- make_uppercase(coulson$SPEAKER)
talbot$SPEAKER <- make_uppercase(talbot$SPEAKER)
fitz$SPEAKER <- make_uppercase(fitz$SPEAKER)
ward$SPEAKER <- make_uppercase(ward$SPEAKER)
josh$SPEAKER <- make_uppercase(josh$SPEAKER)
all$SPEAKER <- make_uppercase(all$SPEAKER)
coulson_means$SPEAKER <- make_uppercase(coulson_means$SPEAKER)
talbot_means$SPEAKER <- make_uppercase(talbot_means$SPEAKER)
fitz_means$SPEAKER <- make_uppercase(fitz_means$SPEAKER)
ward_means$SPEAKER <- make_uppercase(ward_means$SPEAKER)
josh_means$SPEAKER <- make_uppercase(josh_means$SPEAKER)
all_means$SPEAKER <- make_uppercase(all_means$SPEAKER)
coulson_nasals$SPEAKER <- make_uppercase(coulson_nasals$SPEAKER)
talbot_nasals$SPEAKER <- make_uppercase(talbot_nasals$SPEAKER)
fitz_nasals$SPEAKER <- make_uppercase(fitz_nasals$SPEAKER)
ward_nasals$SPEAKER <- make_uppercase(ward_nasals$SPEAKER)
josh_nasals$SPEAKER <- make_uppercase(josh_nasals$SPEAKER)
all_nasals$SPEAKER <- make_uppercase(all_nasals$SPEAKER)

## ---- all_vowel_space ----
ggplot(data = all,
       aes(x = F2, y = F1, color = PHONEME)) +
  scale_x_reverse(name = "F2 (Hz)") +
  scale_y_reverse(name = "F1 (Hz)") +
  coord_cartesian(xlim = c(500, 2750),
                  ylim = c(200, 900)) +
  theme_classic() +
  stat_ellipse(level = 0.5) +
  geom_point(size = 0.5, alpha = 0.2) +
  facet_wrap(~ SPEAKER,
             ncol = 2) +
  labs(color = "Phoneme")

## ---- all_mean_space ----
ggplot(data = all_means) +
  aes(x = F2, y = F1, label = PHONEME) +
  scale_x_reverse(name = "F2 (Hz)") +
  scale_y_reverse(name = "F1 (Hz)") +
  coord_cartesian(xlim = c(1200, 2000),
                  ylim = c(300, 800)) +
  theme_classic() +
  geom_label() +
  facet_wrap(~ SPEAKER,
             ncol = 2)

## ---- all_nasalF1_histograms ----
nasal_histograms(all_nasals, all_nasals$F1)

## ---- all_nasalF2_histograms ----
nasal_histograms(all_nasals, all_nasals$F2)

## ---- all_nasalF3_histograms ----
nasal_histograms(all_nasals, all_nasals$F3)

## ---- calculate_affinities ----
coulson_affinity <- get_affinity(coulson_nasals)
talbot_affinity <- get_affinity(talbot_nasals)
fitz_affinity <- get_affinity(fitz_nasals)
ward_affinity <- get_affinity(ward_nasals)
josh_affinity <- get_affinity(josh_nasals)
