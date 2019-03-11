#########################
# Preamble/Data sorting #
#########################

## ---- load_libraries_data ----
# Load both the required libraries and data.


# Load the dataset
adj <- read.csv("Lynott_Connell_2009.csv")

# Create model
senses.lm <- lm(BNCLogFrequency ~
                  VisualStrengthMean +
                  HapticStrengthMean +
                  AuditoryStrengthMean +
                  OlfactoryStrengthMean +
                  GustatoryStrengthMean,
                data = adj)

#####################################
# Graphs of weights and familiarity #
#####################################

## ---- 
plot(BNCLogFrequency ~
       DominantModality,
     data = adj)
