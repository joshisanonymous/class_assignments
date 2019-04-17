# This script performs statistical analyses of the 3rd
# person plural subject pronouns from four interviews
# with Louisiana French speakers. The data come from the
# output bof cleaning.R. This script also generates
# any graphs and tables that are needed.
#
# This script is evaluated by third_person.Rnw.
#
# -Joshua McNeill (joshua dot mcneill at uga dot edu)

## ---- load_libraries_data ----
# Read in data
tp <- read.csv("third_person_cleaned.csv")

# Load packages
library(plyr)

################
#   Analyses   #
################


################
#    Graphs    #
################
