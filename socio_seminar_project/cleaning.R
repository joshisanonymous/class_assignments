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
               header = FALSE)

# Add names to the columns
colnames(tp) <- c()

# Collapse ...
tp$... <- as.factor(gsub("...",
                        "...",
                        tp$...))

# Coerce ... to a factor
tp$... <- as.factor(tp$...)

# Save completed data frame as a new csv
write.csv(tp,
          file = "third_person_cleaned.csv",
          row.names = FALSE)
