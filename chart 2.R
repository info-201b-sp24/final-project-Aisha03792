library(ggplot2)
library(plotly)
library(gapminder)

foundation_dataset <- read.csv("shades (1).csv")

filtered_values <- subset(foundation_dataset, brand %in% c("MAC", "Fenty"))

# Box plot to compare ratings for MAC and Fenty shades
p2 <- ggplot(filtered_values, aes(x=brand, y=H, fill=brand)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title="Box Plot of Ratings for MAC and Fenty Shades", x="Brand", y="Hue")
ggplotly(p2)


