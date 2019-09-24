## ---- data ----
library(ggplot2)

data <- read.csv("./data/sines1.csv")
data$sin_theta_123 <- data$sin_theta_1 + data$sin_theta_2 + data$sin_theta_3

sinplot <- function(sinusoid){
             ggplot(data,
                    aes_string(x = "ms",
                               y = sinusoid)) +
               geom_line() +
               labs(x = "Time (ms)",
                    y = "Amplitude (dB?)")
}

## ---- plot1 ----
sinplot("sin_theta_4")

## ---- plot2 ----
sinplot("sin_theta_5")

## ---- plot3 ----
sinplot("sin_theta_6")

## ---- plotcombo ----
sinplot("sin_theta_123")
