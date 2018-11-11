# This script analyzes the cleaned data in data_cleaned.csv from the Niche group project for my sociolinguistics course. Both tables and figures are generated here with ## ---- names for importing into Rtex writeup.

# Load in cleaned data
## ---- load_cleaned ----
data_cleaned <- read.csv("data_cleaned.csv",
                         header = TRUE)

# Test of independance between nIche and niCHE
    # Summary of counts in a table and in the margins
    ## --- niche_niche_table_make ----
    nIche_by_niCHE <- table(data_cleaned$nIche,
                                data_cleaned$niCHE)
        ## ---- niche_niche_table_view ----
        kable(addmargins(nIche_by_niCHE),
              format = "latex")
    
    # Chi-square test for independance for nIche by niCHE, expected counts and results
    ## ---- niche_niche_chisq_perform ----
    nIche_by_niCHE_chisq_result <- chisq.test(nIche_by_niCHE)
    ## ---- niche_niche_chisq_expected ----
    nIche_by_niCHE_chisq_result$expected
    ## ---- niche_niche_chisq_results ----
    nIche_by_niCHE_chisq_result
    ## ---- niche_niche_chisq_residuals ----
    nIche_by_niCHE_chisq_result$residuals # Actually sqrt of the residuals
    # Ultimately shows that these variables are highly dependant, and so we can look at
    # either one with the other factors and expect the same results. We'll use niCHE

# Overall distribution of niCHE
    ## ---- niche_overall_table_make ----
    niCHE_overall <- table(data_cleaned$niCHE)
    ## ---- niche_overall_barplot ----
    niCHE_overall_barplot <- barplot(niCHE_overall,
                                       ylim = c(0,
                                                1.3*max(niCHE_overall)),
                                       names.arg = c("\u0283",
                                                     "t\u0283"),
                                       ylab = "Tokens",
                                       xlab = "Variant of ni(che)")
        text(niCHE_overall_barplot,
             y = niCHE_overall,
             label = niCHE_overall,
             pos = 3)
    
# Using Bonferroni correction for multiple hypothesis tests, starting wit alpha = 0.05
## ---- bonferroni_correction ----
0.05/5
        
# Test of independance between Age and niCHE
    # Exclude those with unknown ages
    ## ---- age_niche_table_make ----
    data_cleaned_sans_unknown_ages <- droplevels(data_cleaned[data_cleaned$Age != "Unknown",])
    
    # Summary of counts in a table and in the margins, excluding unknown ages
    niCHE_by_Age <- table(data_cleaned_sans_unknown_ages$niCHE,
                                data_cleaned_sans_unknown_ages$Age)
        ## ---- age_niche_table_view
        addmargins(niCHE_by_Age)
    
    # Chi-square test for independance for Age by niCHE, expected counts and results
    ## --- age_niche_chisq_perform ----
    niCHE_by_Age_chisq_result <- chisq.test(niCHE_by_Age)
    ## --- age_niche_chisq_expected ----
    niCHE_by_Age_chisq_result$expected # Consevatively, chi-square shouldn't be used
        # Perform Fisher's exact test instead
        ## ---- age_niche_fish_perform ----
        niCHE_by_Age_Fish_result <- fisher.test(niCHE_by_Age)
        ## ---- age_niche_fish_result ----
        niCHE_by_Age_Fish_result
        # The result is not significant by any likely alpha
        
# Test of independance between Gender and niCHE
    # Summary of counts in a table and in the margins
    ## ---- gender_niche_table_make ----
    niCHE_by_Gender <- table(data_cleaned$niCHE,
                          data_cleaned$Gender)
        ## ---- gender_niche_table_view ----
        addmargins(niCHE_by_Gender)
    
    # Chi-square test for independance for Gender by niCHE, expected counts and results
    ## ---- gender_niche_chisq_perform ----
    niCHE_by_Gender_chisq_result <- chisq.test(niCHE_by_Gender)
    ## ---- gender_niche_chisq_expected ----
    niCHE_by_Gender_chisq_result$expected
    ## ---- gender_niche_chisq_result
    niCHE_by_Gender_chisq_result
    # The result is not significant by any likely alpha
    
# Test of independance between Ethnicity and niCHE
    # Summary of counts in a table and in the margins
    ## ---- ethnicity_niche_table_make ----
    niCHE_by_Ethnicity <- table(data_cleaned$niCHE,
                             data_cleaned$Ethnicity)
        ## ---- ethnicity_niche_table_view ----
        addmargins(niCHE_by_Ethnicity)
    
    # Chi-square test for independance for Ethnicity by niCHE, expected counts and results
    ## ---- ethnicity_niche_chisq_perform ----
    niCHE_by_Ethnicity_chisq_result <- chisq.test(niCHE_by_Ethnicity)
    ## ---- ethnicity_niche_chisq_expected ----
    niCHE_by_Ethnicity_chisq_result$expected # Definitely not appropriate to use chi-square
        # Perform Fisher's exact test instead
        ## ---- ethnicity_niche_fish_perform ----
        niCHE_by_Ethnicity_Fish_result <- fisher.test(niCHE_by_Ethnicity)
        ## ---- ethnicity_niche_fish_result ----
        niCHE_by_Ethnicity_Fish_result
        # The result is not significant by any likely alpha

# Test of independance between Location and niCHE
    # Summary of counts in a table and in the margins
    ## ---- location_niche_table_make ----
    niCHE_by_Location <- table(data_cleaned$niCHE,
                             data_cleaned$Location)
        ## ---- location_niche_table_view ----
        addmargins(niCHE_by_Location)
    
    # Chi-square test for independance for Location by niCHE, expected counts and results
    ## ---- location_niche_chisq_perform ----
    niCHE_by_Location_chisq_result <- chisq.test(niCHE_by_Location)
    ## ---- location_niche_chisq_expected ----
    niCHE_by_Location_chisq_result$expected
    ## ---- location_niche_chisq_result ----
    niCHE_by_Location_chisq_result
    # The result is not significant by any likely alpha

# Test of independance between Year and niCHE
## ---- Year_niche_independance
    # Exclude those with unknown ages or who were non-students, the non-students only numbering 2
    ## ---- year_niche_table_make ----
    data_cleaned_sans_unknown_and_nonstudent_years <- droplevels(data_cleaned[data_cleaned$Year != "Unknown" & data_cleaned$Year != "Not_student",])
    
    # Summary of counts in a table and in the margins
    niCHE_by_Year <- table(data_cleaned_sans_unknown_and_nonstudent_years$niCHE,
                           data_cleaned_sans_unknown_and_nonstudent_years$Year)
        ## ---- year_niche_table_view ----
        addmargins(niCHE_by_Year)
    
    # Chi-square test for independance for Year by niCHE, expected counts and results
    ## ---- year_niche_chisq_perform ----
    niCHE_by_Year_chisq_result <- chisq.test(niCHE_by_Year)
    ## ---- year_niche_chisq_expected ----
    niCHE_by_Year_chisq_result$expected # Pretty inappropriate to use chi-square
        # Perform Fisher's exact test instead
        ## ---- year_niche_fish_perform ----
        niCHE_by_Year_Fish_result <- fisher.test(niCHE_by_Year)
        ## ---- year_niche_fish_result ----
        niCHE_by_Year_Fish_result
        # The result is not significant by any likely alpha
        
    # There seems to be a pattern, though.
    # Create a side by side bar graph for Year by niCHE to show it
    ## ---- year_niche_barplot ----
    niCHE_by_Year_props <- prop.table(niCHE_by_Year,
                                      2)
    niCHE_by_Year_barplot <- barplot(niCHE_by_Year_props,
                                     beside = TRUE,
                                     ylim = c(0,
                                              1),
                                     xlab = "Year",
                                     ylab = "Proportion of variant",
                                     legend = c("\u0283",
                                                "t\u0283"),
                                     args.legend = list(x = 4,
                                                        y = 0.95))