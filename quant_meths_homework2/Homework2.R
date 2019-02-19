## ---- read_data_packages ----
# Read in the BNC and Reddit data
bnc <- read.csv("BNC.csv")
reddit <- read.table("lingRedditWords.txt")
# Load ggplot2
library(ggplot2)
library(plyr)
library(knitr)

## ---- check_initial_read ----
# Make sure both datasets loaded correctly
head(bnc)
head(reddit)

## ---- convert_reddit_rename ----
# Make reddit into a table to get the frequencies then convert to a data frame to match bnc
reddit.freq <- data.frame(table(reddit))

# Change the names of the columns in reddit and capitalize in reddit and bnc
colnames(bnc) <- c("FREQUENCY",
                   "WORD")
colnames(reddit.freq) <- c("WORD",
                           "FREQUENCY")

## ---- check_dfs ----
# Make sure bnc and reddit have the right headers and contents
tail(reddit.freq)
head(bnc)

## ---- sort_reddit_subset ----
# Sort reddit by the frequency column in descending order
reddit.ordered <- reddit.freq[order(reddit.freq$FREQUENCY,
                                    decreasing = TRUE),]

# Get the 200 most frequent words in both reddit and bnc
bnc.200 <- head(bnc,
                n = 200)
reddit.200 <- head(reddit.ordered,
                   n = 200)

## ---- bnc_hist ----
# Create a histogram of the top 200 words in bnc
ggplot(bnc.200,
       aes(x = log(FREQUENCY))) +
    geom_histogram() +
    labs(x = "Log of Counts",
         y = "Frequency of Words")

## ---- bnc_density ----
# Create a density plot of the top 200 words in bnc
ggplot(bnc.200,
       aes(x = log(FREQUENCY))) +
    geom_line(stat = "density") +
    labs(x = "Log of Counts",
         y = "Density of Words")

## ---- bnc_qq ----
# Create a Q-Q plot of the top 200 words in bnc
ggplot(bnc.200,
       aes(sample = log(FREQUENCY))) +
    stat_qq() +
    stat_qq_line() +
    labs(x = "Theoretical Distribution",
         y = "Sample Distribution")

## ---- reddit_hist ----
# Create a histogram of the top 200 words in reddit
ggplot(reddit.200,
       aes(x = log(FREQUENCY))) +
    geom_histogram() +
    labs(x = "Log of Counts",
         y = "Frequency of Words")

## ---- reddit_density ----
# Create a density plot of the top 200 words in reddit
ggplot(reddit.200,
       aes(x = log(FREQUENCY))) +
    geom_line(stat = "density") +
    labs(x = "Log of Counts",
         y = "Density of Words")

## ---- reddit_qq ----
# Create a Q-Q plot of the top 200 words in reddit
ggplot(reddit.200,
       aes(sample = log(FREQUENCY))) +
    stat_qq() +
    stat_qq_line() +
    labs(x = "Theoretical Distribution",
         y = "Sample Distribution")

## ---- shapiro-wilk_tests ----
# Perform a Shapiro-Wilk test for normality on bnc and save the results to an object
bnc.sh.wi <- shapiro.test(bnc.200$FREQUENCY)

# Perform a Shapiro-Wilk test for normality on reddit and save the results to an object
reddit.sh.wi <- shapiro.test(reddit.200$FREQUENCY)

## ---- shapiro-wilk_tests_results ----
# Display the results of the Shapiro-Wilk tests
bnc.sh.wi
reddit.sh.wi

## ---- bnc_top ----
# Show the top 6 most frequent words in the BNC in a LaTeX formatted table
kable(head(bnc.200),
      format = "latex")

## ---- reddit_top ----
# Show the top 6 most frequent words on linguistics Reddit in a LaTeX formatted table
kable(head(reddit.200),
      format = "latex")