# This script cleans the raw data in data_raw.csv from the Niche group project for my sociolinguistics course

## ---- clean ----

# Load in raw data
data_raw <- read.csv("data_raw.csv",
                     header = TRUE,
                     encoding = "UTF-8")

# Rename n.i.che and ni.che. to nIche and niCHE to make them more readable
colnames(data_raw) <- c("Asker",
                        "Location",
                        "Age",
                        "Gender",
                        "Ethnicity",
                        "Year",
                        "nIche",
                        "niCHE",
                        "Notes")

# Convert weird IPA stuff in "nIche" and "niCHE" into X-SAMPA
data_raw$nIche <- gsub("\u026A",
                       "I",
                       data_raw$nIche)
data_raw$niCHE <- gsub("\u0283",
                       "S",
                       data_raw$niCHE)

# Collapse "African American" into "Black" in "Ethnicity"
data_raw$Ethnicity <- gsub("African American",
                           "Black",
                           data_raw$Ethnicity)

# Collapse "White " and "White?" into "White" and "Indian?" into "Indian"
data_raw$Ethnicity <- gsub("White ",
                           "White",
                           data_raw$Ethnicity)
data_raw$Ethnicity <- gsub("\\?",
                           "",
                           data_raw$Ethnicity)

# Collapse ages into "20_or_younger"
data_raw$Age <- gsub("~20",
                     "20_or_younger",
                     data_raw$Age)
data_raw$Age <- gsub("<20",
                     "20_or_younger",
                     data_raw$Age)
data_raw$Age <- gsub("18",
                     "20_or_younger",
                     data_raw$Age)
data_raw$Age <- gsub("19",
                     "20_or_younger",
                     data_raw$Age)
data_raw$Age <- gsub("20_or_younger\\?",
                     "20_or_younger",
                     data_raw$Age)
data_raw$Age <- gsub("Around 20",
                     "20_or_younger",
                     data_raw$Age)
data_raw$Age <- gsub("under 20",
                     "20_or_younger",
                     data_raw$Age)

# Collapse ages into "early_20s"
data_raw$Age <- gsub("21",
                     "Early_20s",
                     data_raw$Age)
data_raw$Age <- gsub("Early-Mid 20s",
                     "Early_20s",
                     data_raw$Age)
data_raw$Age <- gsub("Early 20s",
                     "Early_20s",
                     data_raw$Age)

# Collapse ages into "mid_20s_or_older"
data_raw$Age <- gsub("30s",
                     "Mid_20s_or_older",
                     data_raw$Age)
data_raw$Age <- gsub("40s-50s",
                     "Mid_20s_or_older",
                     data_raw$Age)
data_raw$Age <- gsub("Mid 20s",
                     "Mid_20s_or_older",
                     data_raw$Age)

# Rename "" as "Unknown" in ages
data_raw$Age[data_raw$Age == ""] <- "Unknown"

# Make sure Age, Ethnicity, Year, nIche, and niCHE are factors
data_raw$Age <- as.factor(data_raw$Age)
data_raw$Ethnicity <- as.factor(data_raw$Ethnicity)
data_raw$nIche <- as.factor(data_raw$nIche)
data_raw$niCHE <- as.factor(data_raw$niCHE)

# Remove Notes column
data_raw <- data_raw[,1:8]

# Output cleaned data frame as data_cleaned.csv
write.csv(data_raw,
          file = "data_cleaned.csv",
          row.names = FALSE)