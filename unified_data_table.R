library(tidyverse)
library(dplyr)
library(knitr)

foundation_dataset <- read.csv("shades (1).csv")

complete_data <- select(foundation_dataset, c(brand, product, hex, H, S, L))

complete_data <- rename(complete_data, Brand = brand)
complete_data <- rename(complete_data, Product = product)
complete_data <- rename(complete_data, Shade_Code = hex)
complete_data <- rename(complete_data, Hue = H)
complete_data <- rename(complete_data, Saturation = S)
complete_data <- rename(complete_data, Lightness = L)
write.csv(complete_data, "unified_data.csv")