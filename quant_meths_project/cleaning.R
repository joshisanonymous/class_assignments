# This script reads in the raw NCCFr T-V tokens, with a column for the
# speaker that produced each token, collapses the different cases of
# "tu" (and removes preceding dashes when they were in interrogative
# constructions), adds columns for other social variables for the
# speakers, then finally outputs a new csv for analysis.
#
# This script is evaluated when nccfr_tv.Rnw is run.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

## ---- clean_data ----
# Read in the data
tv <- read.csv("nccfr_tv_raw.csv",
               header = FALSE)

# Add names to the columns
colnames(tv) <- c("TV",
                  "SPEAKER")

# Collapse "-vous" to just "vous"
tv$TV <- as.factor(gsub("-vous",
                        "vous",
                        tv$TV))

# Collapse "toi", "te", "t'", and "-tu" to just "tu"
tv$TV <- as.factor(gsub("(-tu|t(oi|e|'))",
                        "tu",
                        tv$TV))

# Add a column for gender (the first letter of each speaker ID)
tv$GENDER <- substr(tv$SPEAKER,
                    1,
                    1)
tv$GENDER[tv$GENDER == "F"] <- "Female"
tv$GENDER[tv$GENDER == "M"] <- "Male"

# Coerce gender to a factor
tv$GENDER <- as.factor(tv$GENDER)

##########################################
# The values for the remaining variables #
# from Torreira et al. (2010, p. 202).   #
##########################################

# Add a column for age
tv$AGE[tv$SPEAKER == "M01L"] <- 23
tv$AGE[tv$SPEAKER == "M01R"] <- 25
tv$AGE[tv$SPEAKER == "M02L"] <- 24
tv$AGE[tv$SPEAKER == "M02R"] <- 24
tv$AGE[tv$SPEAKER == "F03L"] <- 50
tv$AGE[tv$SPEAKER == "F03R"] <- 40
tv$AGE[tv$SPEAKER == "F04L"] <- 25
tv$AGE[tv$SPEAKER == "F04R"] <- 25
tv$AGE[tv$SPEAKER == "F05L"] <- 19
tv$AGE[tv$SPEAKER == "F05R"] <- 18
tv$AGE[tv$SPEAKER == "F06L"] <- 21
tv$AGE[tv$SPEAKER == "F06R"] <- 21
tv$AGE[tv$SPEAKER == "F07L"] <- 20
tv$AGE[tv$SPEAKER == "F07R"] <- 20
tv$AGE[tv$SPEAKER == "F08L"] <- 21
tv$AGE[tv$SPEAKER == "F08R"] <- 20
tv$AGE[tv$SPEAKER == "M09L"] <- 24
tv$AGE[tv$SPEAKER == "M09R"] <- 24
tv$AGE[tv$SPEAKER == "F10L"] <- 19
tv$AGE[tv$SPEAKER == "F10R"] <- 20
tv$AGE[tv$SPEAKER == "M11L"] <- 18
tv$AGE[tv$SPEAKER == "M11R"] <- 18
tv$AGE[tv$SPEAKER == "F12L"] <- 22
tv$AGE[tv$SPEAKER == "F12R"] <- 21
tv$AGE[tv$SPEAKER == "F13L"] <- 19
tv$AGE[tv$SPEAKER == "F13R"] <- 18
tv$AGE[tv$SPEAKER == "F14L"] <- 20
tv$AGE[tv$SPEAKER == "F14R"] <- 23
tv$AGE[tv$SPEAKER == "M15L"] <- 27
tv$AGE[tv$SPEAKER == "M15R"] <- 23
tv$AGE[tv$SPEAKER == "F16L"] <- 19
tv$AGE[tv$SPEAKER == "F16R"] <- 21
tv$AGE[tv$SPEAKER == "M17L"] <- 20
tv$AGE[tv$SPEAKER == "M17R"] <- 20
tv$AGE[tv$SPEAKER == "M18L"] <- 20
tv$AGE[tv$SPEAKER == "M18R"] <- 20
tv$AGE[tv$SPEAKER == "M19L"] <- 19
tv$AGE[tv$SPEAKER == "M19R"] <- 26
tv$AGE[tv$SPEAKER == "M20L"] <- 22
tv$AGE[tv$SPEAKER == "M20R"] <- 22
tv$AGE[tv$SPEAKER == "M21L"] <- 21
tv$AGE[tv$SPEAKER == "M21R"] <- 19
tv$AGE[tv$SPEAKER == "M22L"] <- 19
tv$AGE[tv$SPEAKER == "M22R"] <- 19
tv$AGE[tv$SPEAKER == "M23L"] <- 20
tv$AGE[tv$SPEAKER == "M23R"] <- 23

# Add a column for region of origin
tv$REGION[tv$SPEAKER == "M01L"] <- "Paris"
tv$REGION[tv$SPEAKER == "M01R"] <- "Paris"
tv$REGION[tv$SPEAKER == "M02L"] <- "Paris"
tv$REGION[tv$SPEAKER == "M02R"] <- "Paris"
tv$REGION[tv$SPEAKER == "F03L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F03R"] <- "Paris"
tv$REGION[tv$SPEAKER == "F04L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F04R"] <- "Paris"
tv$REGION[tv$SPEAKER == "F05L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F05R"] <- "Paris"
tv$REGION[tv$SPEAKER == "F06L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F06R"] <- "Paris"
tv$REGION[tv$SPEAKER == "F07L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F07R"] <- "Paris"
tv$REGION[tv$SPEAKER == "F08L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F08R"] <- "Paris"
tv$REGION[tv$SPEAKER == "M09L"] <- "Paris"
tv$REGION[tv$SPEAKER == "M09R"] <- "Paris"
tv$REGION[tv$SPEAKER == "F10L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F10R"] <- "Paris"
tv$REGION[tv$SPEAKER == "M11L"] <- "Paris"
tv$REGION[tv$SPEAKER == "M11R"] <- "Paris"
tv$REGION[tv$SPEAKER == "F12L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F12R"] <- "Not Paris"
tv$REGION[tv$SPEAKER == "F13L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F13R"] <- "Not Paris"
tv$REGION[tv$SPEAKER == "F14L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F14R"] <- "Paris"
tv$REGION[tv$SPEAKER == "M15L"] <- "Not Paris"
tv$REGION[tv$SPEAKER == "M15R"] <- "Not Paris"
tv$REGION[tv$SPEAKER == "F16L"] <- "Paris"
tv$REGION[tv$SPEAKER == "F16R"] <- "Paris"
tv$REGION[tv$SPEAKER == "M17L"] <- "Paris"
tv$REGION[tv$SPEAKER == "M17R"] <- "Paris"
tv$REGION[tv$SPEAKER == "M18L"] <- "Paris"
tv$REGION[tv$SPEAKER == "M18R"] <- "Paris"
tv$REGION[tv$SPEAKER == "M19L"] <- "Not Paris"
tv$REGION[tv$SPEAKER == "M19R"] <- "Paris"
tv$REGION[tv$SPEAKER == "M20L"] <- "Not Paris"
tv$REGION[tv$SPEAKER == "M20R"] <- "Not Paris"
tv$REGION[tv$SPEAKER == "M21L"] <- "Paris"
tv$REGION[tv$SPEAKER == "M21R"] <- "Not Paris"
tv$REGION[tv$SPEAKER == "M22L"] <- "Not Paris"
tv$REGION[tv$SPEAKER == "M22R"] <- "Not Paris"
tv$REGION[tv$SPEAKER == "M23L"] <- "Paris"
tv$REGION[tv$SPEAKER == "M23R"] <- "Paris"

# Coerce region to a factor
tv$REGION <- as.factor(tv$REGION)

# Save completed data frame as a new csv
write.csv(tv,
          file = "nccfr_tv_cleaned.csv",
          row.names = FALSE)
