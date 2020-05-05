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
tokens$Verb <- as.factor(tokens$Verb)
tokens$Short <- as.factor(tokens$Short)
tokens$Speaker <- as.factor(tokens$Speaker)
tokens$Origin <- as.factor(tokens$Origin)
tokens$Gender <- as.factor(tokens$Gender)
tokens$Race <- as.factor(tokens$Race)
tokens$Citation <- as.factor(tokens$Citation)
tokens$Stative <- as.factor(tokens$Stative)

tokens$Origin <- gsub("False_River", "False River", tokens$Origin)
tokens$Origin <- gsub("New_Roads", "New Roads", tokens$Origin)
tokens$Origin <- gsub("Parlange Plantation", "Parlange", tokens$Origin)
tokens$Race <- gsub("Creole_of_color", "Creole", tokens$Race)

names(tokens) <- c(names(tokens[1:6]),
                   "Birth Year",
                   names(tokens[8:10]))

## ---- get_demographics ----
demographics <- tokens[!duplicated(tokens$Speaker), c(4, 6:9)]
row.names(demographics) <- NULL

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

## ---- freq_verb ----
ggplot(tokens,
       aes(x = Stative,
           fill = Short)) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))

## ---- freq_race_speaker ----
ggplot(tokens,
       aes(x = Speaker,
           fill = Short)) +
  facet_grid(Race ~ .) +
  theme_bw() +
  labs(y = axis_count) +
  geom_bar(position = position_dodge(preserve = "single"))
