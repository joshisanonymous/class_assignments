## ---- load_data_libraries ----
library("plyr")
library("readr")
library("ggplot2")

directory <- "./data/"
files <- list.files(path = directory,
                    pattern = "*.csv",
                    full.names = TRUE)
tokens <- ldply(files, read_csv)
axis_count <- "Frequency"

## ---- clean_data ----
tokens$Verb <- as.factor(tokens$Verb)
tokens$Short <- as.factor(tokens$Short)
tokens$Speaker <- as.factor(tokens$Speaker)
tokens$Origin <- as.factor(tokens$Origin)
tokens$Gender <- as.factor(tokens$Gender)
tokens$Race <- as.factor(tokens$Race)

tokens$Origin <- gsub("False_River", "False River", tokens$Origin)
tokens$Origin <- gsub("New_Roads", "New Roads", tokens$Origin)
tokens$Origin <- gsub("Parlange Plantation", "Parlange", tokens$Origin)
tokens$Race <- gsub("Creole_of_color", "Creole", tokens$Race)

names(tokens) <- c(names(tokens[1:5]),
                   "Birth Year",
                   names(tokens[7:8]))

## ---- freq_overall ----
ggplot(tokens,
       aes(x = Short)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar()

## ---- freq_race ----
ggplot(tokens,
       aes(x = Race,
           fill = Short)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))

## ---- freq_gender ----
ggplot(tokens,
       aes(x = Gender,
           fill = Short)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))

## ---- freq_origin ----
ggplot(tokens,
       aes(x = Origin,
           fill = Short)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))
