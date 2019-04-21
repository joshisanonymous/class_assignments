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
                                 "generic",
                                 tp$SPECIFICITY))
tp$SPECIFICITY <- as.factor(gsub("RSP",
                                 "specific",
                                 tp$SPECIFICITY))
tp$ANIMACY <- as.factor(gsub("RAN",
                             "animate",
                             tp$ANIMACY))
tp$ANIMACY <- as.factor(gsub("RIN",
                             "inanimate",
                             tp$ANIMACY))
tp$REF.DISTANCE <- as.factor(gsub("ITU",
                                  "in.t.unit",
                                  tp$REF.DISTANCE))
tp$REF.DISTANCE <- as.factor(gsub("OTU",
                                  "out.t.unit",
                                  tp$REF.DISTANCE))
tp$VERB.TYPE <- as.factor(gsub("VEA",
                               "etre.avoir",
                               tp$VERB.TYPE))
tp$VERB.TYPE <- as.factor(gsub("VRB",
                               "regular",
                               tp$VERB.TYPE))

# Save completed data frame as a new csv
write.csv(tp,
          file = "third_person_cleaned.csv",
          row.names = FALSE)