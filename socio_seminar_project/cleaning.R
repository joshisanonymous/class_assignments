# This script reads in raw data from interviews with Louisiana French
# speakers and performs data cleaning on the raw data before outputting
# a the results to a new csv.
#
# This script is evaluated when third_person.Rnw is run.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

## ---- clean_data ----
# Read in the data
tp <- read.csv("third_person_raw.csv",
               header = TRUE,
               encoding = "UTF-8")

# Collapse c', ç', and ça to just ça
tp$PRONOUN <- as.factor(gsub("c'",
                             "ça",
                             tp$PRONOUN))
tp$PRONOUN <- as.factor(gsub("ç'",
                             "ça",
                             tp$PRONOUN))

# Substitute positional tags to readable values
tp$SPECIFICITY <- as.factor(gsub("RGE",
                                 "Generic Referent",
                                 tp$SPECIFICITY))
tp$SPECIFICITY <- as.factor(gsub("RSP",
                                 "Specific Referent",
                                 tp$SPECIFICITY))
tp$ANIMACY <- as.factor(gsub("RAN",
                             "Animate Referent",
                             tp$ANIMACY))
tp$ANIMACY <- as.factor(gsub("RIN",
                             "Inanimate Referent",
                             tp$ANIMACY))
tp$REF.DISTANCE <- as.factor(gsub("ITU",
                                  "Referent in the T-unit",
                                  tp$REF.DISTANCE))
tp$REF.DISTANCE <- as.factor(gsub("OTU",
                                  "Referent not in the T-unit",
                                  tp$REF.DISTANCE))
tp$VERB.TYPE <- as.factor(gsub("VEA",
                               "Être or Avoir Verb",
                               tp$VERB.TYPE))
tp$VERB.TYPE <- as.factor(gsub("VRB",
                               "Regular Verb",
                               tp$VERB.TYPE))

# Capitalize speaker IDs
tp$SPEAKER <- as.factor(gsub("coulson",
                             "Coulson",
                             tp$SPEAKER))
tp$SPEAKER <- as.factor(gsub("talbot",
                             "Talbot",
                             tp$SPEAKER))
tp$SPEAKER <- as.factor(gsub("fitz",
                             "Fitz",
                             tp$SPEAKER))
tp$SPEAKER <- as.factor(gsub("ward",
                             "Ward",
                             tp$SPEAKER))

# Save completed data frame as a new csv
write.csv(tp,
          file = "third_person_cleaned.csv",
          row.names = FALSE)