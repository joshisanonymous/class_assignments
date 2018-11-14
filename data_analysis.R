# This script analyzes the cleaned data in data_cleaned.csv from the Niche group project for my sociolinguistics course. Both tables and figures are generated here with ## ---- names for importing into Rtex writeup.

## ---- load_cleaned ----
data_cleaned <- read.csv("data_cleaned.csv",
                         header = TRUE)

## ---- load_packages ----
require("knitr")
require("plyr")

# Test of independance between nIche and niCHE
## ---- niche_niche_table ----
nIche_by_niCHE <- table(data_cleaned$nIche,
                        data_cleaned$niCHE)
kable(addmargins(nIche_by_niCHE),
      format = "latex")

## ---- niche_niche_chisq_perform ----
nIche_by_niCHE_chisq_result <- chisq.test(nIche_by_niCHE)
## ---- niche_niche_chisq_expected ----
kable(nIche_by_niCHE_chisq_result$expected,
      format = "latex",
      digits = 2)
## ---- niche_niche_chisq_result ----
nIche_by_niCHE_chisq_result
## ---- niche_niche_chisq_residuals ----
kable(nIche_by_niCHE_chisq_result$residuals,
      format = "latex",
      digits = 2)

## ---- niche_overall_barplot_make ----
niCHE_overall <- table(data_cleaned$niCHE)
## ---- niche_overall_barplot_view ----
niCHE_overall_barplot <- barplot(niCHE_overall,
                                   ylim = c(0,
                                            1.3*max(niCHE_overall)),
                                   ylab = "Tokens",
                                   xlab = "Variant of ni(che)")
text(niCHE_overall_barplot,
     y = niCHE_overall,
     label = niCHE_overall,
     pos = 3)
        
## ---- age_niche_table ----
# Exclude those with unknown ages
data_cleaned_sans_unknown_ages <- droplevels(data_cleaned[data_cleaned$Age != "Unknown",])

niCHE_by_Age <- table(data_cleaned_sans_unknown_ages$niCHE,
                            data_cleaned_sans_unknown_ages$Age)
colnames(niCHE_by_Age) <- c("20 or Younger",
                            "Early 20s",
                            "Mid 20s or Older")
kable(addmargins(niCHE_by_Age),
      format = "latex")

## --- age_niche_chisq_perform ----
niCHE_by_Age_chisq_result <- chisq.test(niCHE_by_Age)
## --- age_niche_chisq_expected ----
kable(niCHE_by_Age_chisq_result$expected,
      format = "latex",
      digits = 2)

## ---- age_niche_fish_perform ----
niCHE_by_Age_Fish_result <- fisher.test(niCHE_by_Age)
## ---- age_niche_fish_result ----
niCHE_by_Age_Fish_result
        
## ---- gender_niche_table ----
niCHE_by_Gender <- table(data_cleaned$niCHE,
                         data_cleaned$Gender)
kable(addmargins(niCHE_by_Gender),
      format = "latex")

## ---- gender_niche_chisq_perform ----
niCHE_by_Gender_chisq_result <- chisq.test(niCHE_by_Gender)
## ---- gender_niche_chisq_expected ----
kable(niCHE_by_Gender_chisq_result$expected,
      format = "latex",
      digits = 2)
## ---- gender_niche_chisq_result ----
niCHE_by_Gender_chisq_result
    
## ---- ethnicity_niche_table ----
niCHE_by_Ethnicity <- table(data_cleaned$niCHE,
                         data_cleaned$Ethnicity)
kable(addmargins(niCHE_by_Ethnicity),
      format = "latex")

## ---- ethnicity_niche_chisq_perform ----
niCHE_by_Ethnicity_chisq_result <- chisq.test(niCHE_by_Ethnicity)
## ---- ethnicity_niche_chisq_expected ----
kable(niCHE_by_Ethnicity_chisq_result$expected,
      format = "latex",
      digits = 2)

## ---- ethnicity_niche_fish_perform ----
niCHE_by_Ethnicity_Fish_result <- fisher.test(niCHE_by_Ethnicity)
## ---- ethnicity_niche_fish_result ----
niCHE_by_Ethnicity_Fish_result

## ---- location_niche_table ----
niCHE_by_Location <- table(data_cleaned$niCHE,
                         data_cleaned$Location)
colnames(niCHE_by_Location) <- c("Downtown",
                                 "North Campus",
                                 "South Campus")
kable(addmargins(niCHE_by_Location),
      format = "latex")

## ---- location_niche_chisq_perform ----
niCHE_by_Location_chisq_result <- chisq.test(niCHE_by_Location)
## ---- location_niche_chisq_expected ----
kable(niCHE_by_Location_chisq_result$expected,
      format = "latex",
      digits = 2)
## ---- location_niche_chisq_result ----
niCHE_by_Location_chisq_result

## ---- year_niche_table_prep ----
# Exclude those with unknown ages or who were non-students, the non-students only numbering 2
data_cleaned_sans_unknown_and_nonstudent_years <- droplevels(data_cleaned[data_cleaned$Year != "Unknown" & data_cleaned$Year != "Not_student",])

## ---- year_niche_table ----
niCHE_by_Year <- table(data_cleaned_sans_unknown_and_nonstudent_years$niCHE,
                       data_cleaned_sans_unknown_and_nonstudent_years$Year)
addmargins(niCHE_by_Year)
kable(addmargins(niCHE_by_Year),
      format = "latex")

## ---- year_niche_chisq_perform ----
niCHE_by_Year_chisq_result <- chisq.test(niCHE_by_Year)
## ---- year_niche_chisq_expected ----
kable(niCHE_by_Year_chisq_result$expected,
      format = "latex",
      digits = 2)

## ---- year_niche_fish_perform ----
niCHE_by_Year_Fish_result <- fisher.test(niCHE_by_Year)
## ---- year_niche_fish_result ----
niCHE_by_Year_Fish_result

## ---- year_niche_barplot_make ----
niCHE_by_Year_props <- prop.table(niCHE_by_Year,
                                  2)
## ---- year_niche_barplot_view ----
niCHE_by_Year_barplot <- barplot(niCHE_by_Year_props,
                                 beside = TRUE,
                                 ylim = c(0,
                                          1),
                                 xlab = "Year",
                                 ylab = "Proportion of variant",
                                 legend = c("S",
                                            "tS"),
                                 args.legend = list(x = 5,
                                                    y = 1))