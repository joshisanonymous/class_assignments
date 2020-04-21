## ---- load_data_libraries ----
library("ggplot2")

directory <- "./data/"
encoding <- "UTF-8"
axis_count <- "fréquence"

talbot <- read.csv(paste(directory, "talbot_tokens.csv", sep = ""),
                 encoding = encoding)
coulson <- read.csv(paste(directory, "coulson_tokens.csv", sep = ""),
                 encoding = encoding)
fitz <- read.csv(paste(directory, "fitz_tokens.csv", sep = ""),
                 encoding = encoding)
ward <- read.csv(paste(directory, "ward_tokens.csv", sep = ""),
                 encoding = encoding)

tokens <- rbind(talbot, coulson, fitz, ward)

## ---- clean_data ----
tokens$AUXILIAIRE <- gsub("(est|sont|suis)", "être", tokens$AUXILIAIRE, perl = TRUE)
tokens$AUXILIAIRE <- gsub("(ai|a|ont)", "avoir", tokens$AUXILIAIRE, perl = TRUE)
tokens$PRONOM <- gsub("(se|s')", "oui", tokens$PRONOM, perl = TRUE)
tokens$PRONOM[tokens$PRONOM == "y"] <- "non"
tokens$PRONOM[is.na(tokens$PRONOM)] <- "non"
tokens$SUJET[tokens$SUJET == "j'"] <- "je"

tokens$AUXILIAIRE <- as.factor(tokens$AUXILIAIRE)
tokens$PRONOM <- as.factor(tokens$PRONOM)

tokens <- droplevels(tokens)

names(tokens) <- c("auxiliaire", "verbe", "sujet", "pronominal", "locuteur")

## ---- freq_overall ----
ggplot(tokens,
       aes(x = auxiliaire)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar()

## ---- freq_pronominal ----
ggplot(tokens,
       aes(x = pronominal,
           fill = auxiliaire)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))

## ---- freq_locuteur ----
ggplot(tokens,
       aes(x = locuteur,
           fill = auxiliaire)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))

## ---- freq_pronom_locuteur ----
ggplot(tokens,
       aes(x = locuteur,
           fill = pronominal)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))
