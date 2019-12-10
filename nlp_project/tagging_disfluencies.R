## ---- preamble ----
library(ggplot2)

stats_dir <- "./stats/"

test_dis_result <- scan(paste(stats_dir, "test_dis_result.txt",
                              sep = ""))
test_nodis_result <- scan(paste(stats_dir, "test_nodis_result.txt",
                                sep = ""))
test_dis_ext_result <- scan(paste(stats_dir, "test_dis_ext_result.txt",
                                  sep = ""))
test_results <- c(test_dis_result, test_nodis_result, test_dis_ext_result)
names(test_results) <- c("w/ Disfluencies", "w/o Disfluencies", "w/ Extended Tags")

## ---- compare_dis_nodis ----
barplot(test_results,
        ylim = c(0, 1),
        ylab = "Accuracy")
