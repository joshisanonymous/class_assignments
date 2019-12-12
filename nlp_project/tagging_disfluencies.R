## ---- preamble ----
library(ggplot2)

stats_dir <- "./stats/"

test_dis_ext_result <- scan(paste(stats_dir, "test_dis_ext_result.txt",
                                  sep = ""))
test_dis_result <- scan(paste(stats_dir, "test_dis_result.txt",
                              sep = ""))
test_nodis_result <- scan(paste(stats_dir, "test_nodis_result.txt",
                                sep = ""))
test_results <- c(test_dis_ext_result, test_dis_result, test_nodis_result)
names(test_results) <- c("IOB style", "Just DIS", "No DIS")

## ---- compare_dis_nodis ----
plot <- barplot(test_results,
                ylim = c(0, 1),
                ylab = "Accuracy")
text(plot,
     y = test_results,
     label = round(test_results, 2),
     pos = 3)
