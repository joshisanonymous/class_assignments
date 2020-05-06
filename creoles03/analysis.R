## ---- load_data_libraries ----
library("plyr")
library("readr")
library("ggplot2")
library("knitr")

directory <- "./data/"
files <- list.files(path = directory,
                    pattern = "*.csv",
                    full.names = TRUE)
tokens <- ldply(files, read_csv)
axis_count <- "Frequency"

## ---- clean_data ----
tokens$Determiner <- as.factor(tokens$Determiner)
tokens$Agreement <- as.factor(tokens$Agreement)
tokens$Speaker <- as.factor(tokens$Speaker)
tokens$Origin <- as.factor(tokens$Origin)
tokens$Gender <- as.factor(tokens$Gender)
tokens$Race <- as.factor(tokens$Race)
tokens$Number <- as.factor(tokens$Number)
tokens$'Possessor Features' <- as.factor(tokens$'Possessor Features')

tokens$Origin <- gsub("False_River", "False River", tokens$Origin)
tokens$Origin <- gsub("New_Roads", "New Roads", tokens$Origin)
tokens$Origin <- gsub("Parlange Plantation", "Parlange", tokens$Origin)
tokens$Race <- gsub("Creole_of_color", "Creole", tokens$Race)

names(tokens) <- c(names(tokens[1:7]),
                   "Birth Year",
                   names(tokens[9:10]))

## ---- get_demographics ----
demographics <- tokens[!duplicated(tokens$Speaker), c(5, 7:10)]
row.names(demographics) <- NULL

## ---- freq_overall ----
ggplot(tokens,
       aes(x = Agreement)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar()

## ---- freq_race ----
ggplot(tokens,
       aes(x = Race,
           fill = Agreement)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))

## ---- freq_gender ----
ggplot(tokens,
       aes(x = Gender,
           fill = Agreement)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))

## ---- freq_origin ----
ggplot(tokens,
       aes(x = Origin,
           fill = Agreement)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))

## ---- freq_number ----
ggplot(tokens,
       aes(x = Number,
           fill = Agreement)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))

## ---- freq_race_speaker ----
ggplot(tokens,
       aes(x = Speaker,
           fill = Agreement)) +
  facet_grid(Race ~ .) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))
