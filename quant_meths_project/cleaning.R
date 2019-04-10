# Read in the data
tv <- read.csv("nccfr_tv_raw.csv",
               header = FALSE)

# Add names to the columns
colnames(tv) <- c("TV",
                  "SPEAKER")

# Add a column for gender (the first letter of each speaker ID)
tv$GENDER <- substr(tv$SPEAKER,
                    1,
                    1)
tv$GENDER[tv$GENDER == "F"] <- "female"
tv$GENDER[tv$GENDER == "M"] <- "male"

###############################################
# The values for the remaining variables from #
# from Torreira et al. (2010, p. 202).        #
###############################################

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
tv$REGION[tv$SPEAKER == "M01L"] <- "paris"
tv$REGION[tv$SPEAKER == "M01R"] <- "paris"
tv$REGION[tv$SPEAKER == "M02L"] <- "paris"
tv$REGION[tv$SPEAKER == "M02R"] <- "paris"
tv$REGION[tv$SPEAKER == "F03L"] <- "paris"
tv$REGION[tv$SPEAKER == "F03R"] <- "paris"
tv$REGION[tv$SPEAKER == "F04L"] <- "paris"
tv$REGION[tv$SPEAKER == "F04R"] <- "paris"
tv$REGION[tv$SPEAKER == "F05L"] <- "paris"
tv$REGION[tv$SPEAKER == "F05R"] <- "paris"
tv$REGION[tv$SPEAKER == "F06L"] <- "paris"
tv$REGION[tv$SPEAKER == "F06R"] <- "paris"
tv$REGION[tv$SPEAKER == "F07L"] <- "paris"
tv$REGION[tv$SPEAKER == "F07R"] <- "paris"
tv$REGION[tv$SPEAKER == "F08L"] <- "paris"
tv$REGION[tv$SPEAKER == "F08R"] <- "paris"
tv$REGION[tv$SPEAKER == "M09L"] <- "paris"
tv$REGION[tv$SPEAKER == "M09R"] <- "paris"
tv$REGION[tv$SPEAKER == "F10L"] <- "paris"
tv$REGION[tv$SPEAKER == "F10R"] <- "paris"
tv$REGION[tv$SPEAKER == "M11L"] <- "paris"
tv$REGION[tv$SPEAKER == "M11R"] <- "paris"
tv$REGION[tv$SPEAKER == "F12L"] <- "paris"
tv$REGION[tv$SPEAKER == "F12R"] <- "not_paris"
tv$REGION[tv$SPEAKER == "F13L"] <- "paris"
tv$REGION[tv$SPEAKER == "F13R"] <- "not_paris"
tv$REGION[tv$SPEAKER == "F14L"] <- "paris"
tv$REGION[tv$SPEAKER == "F14R"] <- "paris"
tv$REGION[tv$SPEAKER == "M15L"] <- "not_paris"
tv$REGION[tv$SPEAKER == "M15R"] <- "not_paris"
tv$REGION[tv$SPEAKER == "F16L"] <- "paris"
tv$REGION[tv$SPEAKER == "F16R"] <- "paris"
tv$REGION[tv$SPEAKER == "M17L"] <- "paris"
tv$REGION[tv$SPEAKER == "M17R"] <- "paris"
tv$REGION[tv$SPEAKER == "M18L"] <- "paris"
tv$REGION[tv$SPEAKER == "M18R"] <- "paris"
tv$REGION[tv$SPEAKER == "M19L"] <- "not_paris"
tv$REGION[tv$SPEAKER == "M19R"] <- "paris"
tv$REGION[tv$SPEAKER == "M20L"] <- "not_paris"
tv$REGION[tv$SPEAKER == "M20R"] <- "not_paris"
tv$REGION[tv$SPEAKER == "M21L"] <- "paris"
tv$REGION[tv$SPEAKER == "M21R"] <- "not_paris"
tv$REGION[tv$SPEAKER == "M22L"] <- "not_paris"
tv$REGION[tv$SPEAKER == "M22R"] <- "not_paris"
tv$REGION[tv$SPEAKER == "M23L"] <- "paris"
tv$REGION[tv$SPEAKER == "M23R"] <- "paris"

# Save completed data frame as a new csv
write.csv(tv,
          file = "nccfr_tv_cleaned.csv",
          row.names = FALSE)
