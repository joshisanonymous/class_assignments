library(ggplot2)

data <- read.csv("./data/sines1.csv")

data$ms <- as.numeric(data$ms)

## ---- plot1 ----
ggplot(data,
       aes(x = ms,
           y = sin_theta_4)) +
    geom_line()
