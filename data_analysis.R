# This script analyzes the cleaned data in data_cleaned.csv from the Niche group project for my sociolinguistics course. Both tables and figures are generated here with ## ---- names for importing into Rtex writeup.

# Load in cleaned data
data_cleaned <- read.csv("data_cleaned.csv",
                         header = TRUE)

# Test of independance between nIche and niCHE
## ---- niche_niche_independance
    # Summary of counts in a table and in the margins
    nIche_by_niCHE <- table(data_cleaned$nIche,
                                data_cleaned$niCHE)
        addmargins(nIche_by_niCHE)
    
    # Chi-square test for independance for nIche by niCHE, expected counts and results
    nIche_by_niCHE_Xsq_result <- chisq.test(nIche_by_niCHE)
    nIche_by_niCHE_Xsq_result$expected
    nIche_by_niCHE_Xsq_result
    nIche_by_niCHE_Xsq_result$residuals # Actually sqrt of the residuals
    # Ultimately shows that these variables are highly dependant, and so we can look at
    # either one with the other factors and expect the same results. We'll use niCHE

# Overall distribution of niCHE
## ---- niche_overall_dist
    niCHE_overall <- table(data_cleaned$niCHE)
    niCHE_overall_barplot <- barplot(niCHE_overall,
                                       ylim = c(0,
                                                1.1*max(niCHE_overall)),
                                       names.arg = c("\u0283",
                                                     "t\u0283"),
                                       ylab = "Tokens",
                                       xlab = "Variant of ni(che)")
        text(niCHE_overall_barplot,
             y = niCHE_overall,
             label = niCHE_overall,
             pos = 3)
    
# Using Bonferroni correction for multiple hypothesis tests, starting wit alpha = 0.05
0.05/5
# Alpha = 0.01
        
# Test of independance between Age and niCHE
## ---- niche_Age_independance
    # Exclude those with unknown ages
    data_cleaned_sans_unknown_ages <- droplevels(data_cleaned[data_cleaned$Age != "Unknown",])
    
    # Summary of counts in a table and in the margins, excluding unknown ages
    niCHE_by_Age <- table(data_cleaned_sans_unknown_ages$niCHE,
                                data_cleaned_sans_unknown_ages$Age)
        addmargins(niCHE_by_Age)
    
    # Chi-square test for independance for Age by niCHE, expected counts and results
    niCHE_by_Age_Xsq_result <- chisq.test(niCHE_by_Age)
    niCHE_by_Age_Xsq_result$expected # Consevatively, chi-square shouldn't be used
        # Perform Fisher's exact test instead
        niCHE_by_Age_Fish_result <- fisher.test(niCHE_by_Age)
        niCHE_by_Age_Fish_result
        # The result is not significant by any likely alpha
        
# Test of independance between Gender and niCHE
## ---- niche_Gender_independance
    # Summary of counts in a table and in the margins
    niCHE_by_Gender <- table(data_cleaned$niCHE,
                          data_cleaned$Gender)
        addmargins(niCHE_by_Gender)
    
    # Chi-square test for independance for Gender by niCHE, expected counts and results
    niCHE_by_Gender_Xsq_result <- chisq.test(niCHE_by_Gender)
    niCHE_by_Gender_Xsq_result$expected
    niCHE_by_Gender_Xsq_result
    # The result is not significant by any likely alpha
    
# Test of independance between Ethnicity and niCHE
## ---- niche_Ethnicity_independance
    # Summary of counts in a table and in the margins
    niCHE_by_Ethnicity <- table(data_cleaned$niCHE,
                             data_cleaned$Ethnicity)
        addmargins(niCHE_by_Ethnicity)
    
    # Chi-square test for independance for Ethnicity by niCHE, expected counts and results
    niCHE_by_Ethnicity_Xsq_result <- chisq.test(niCHE_by_Ethnicity)
    niCHE_by_Ethnicity_Xsq_result$expected # Definitely not appropriate to use chi-square
        # Perform Fisher's exact test instead
        niCHE_by_Ethnicity_Fish_result <- fisher.test(niCHE_by_Ethnicity)
        niCHE_by_Ethnicity_Fish_result
        # The result is not significant by any likely alpha

# Test of independance between Location and niCHE
## ---- niche_Location_independance
    # Summary of counts in a table and in the margins
    niCHE_by_Location <- table(data_cleaned$niCHE,
                             data_cleaned$Location)
        addmargins(niCHE_by_Location)
    
    # Chi-square test for independance for Location by niCHE, expected counts and results
    niCHE_by_Location_Xsq_result <- chisq.test(niCHE_by_Location)
    niCHE_by_Location_Xsq_result$expected
    niCHE_by_Location_Xsq_result
    # The result is not significant by any likely alpha

# Test of independance between Year and niCHE
## ---- niche_Year_independance
    # Exclude those with unknown ages or who were non-students, the non-students only numbering 2
    data_cleaned_sans_unknown_and_nonstudent_years <- droplevels(data_cleaned[data_cleaned$Year != "Unknown" & data_cleaned$Year != "Not_student",])
    
    # Summary of counts in a table and in the margins
    niCHE_by_Year <- table(data_cleaned_sans_unknown_and_nonstudent_years$niCHE,
                           data_cleaned_sans_unknown_and_nonstudent_years$Year)
    addmargins(niCHE_by_Year)
    
    # Chi-square test for independance for Year by niCHE, expected counts and results
    niCHE_by_Year_Xsq_result <- chisq.test(niCHE_by_Year)
    niCHE_by_Year_Xsq_result$expected # Pretty inappropriate to use chi-square
        # Perform Fisher's exact test instead
        niCHE_by_Year_Fish_result <- fisher.test(niCHE_by_Year)
        niCHE_by_Year_Fish_result
        # The result is not significant by any likely alpha