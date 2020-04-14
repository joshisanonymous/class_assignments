## ---- load_data ----
directory <- "./data/"
encoding <- "UTF-8"

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
