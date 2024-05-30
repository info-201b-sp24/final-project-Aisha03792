
# Load necessary libraries
library(ggplot2)
library(dplyr)

# Load data from the URL
foundation_dataset <- read.csv("shades (1).csv")

# Filter the data for MAC and Fenty brands

filtered_data <- subset(foundation_dataset, brand %in% c("Fenty", "MAC"))

# Create the histogram

ggplot(data = filtered_data, aes(x = L, fill = brand)) +
  geom_histogram(bins = 30, color = "black", alpha = 0.7, position = "identity") +
  labs(
    title = "Histogram of Lightness for Fenty vs. MAC Foundations",
    x = "Lightness",
    y = "Frequency",
    fill = "Brand"
  ) +
  theme_minimal()
