## ---- preamble ----
library(ggplot2)

test_dis_result <- 0.7232796486090776
test_nodis_result <- 0.8448023426061494
test_results <- c(test_dis_result, test_nodis_result)
names(test_results) <- c("w/ Disfluency Tags", "w/o Disfluency Tags")

## ---- compare_dis_nodis ----
# ggplot(data = test_results,
#        aes(seq_along(test_results), test_results)) +
#        geom_bar(stat = "identity")
barplot(test_results,
        ylim = c(0, 1),
        ylab = "Accuracy",
        main = "Comparison b/w Tagging\nStrategies",
        cex.axis = 2,
        cex.names = 2,
        cex.lab = 2,
        cex.main = 2)
