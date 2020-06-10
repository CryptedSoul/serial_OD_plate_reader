## load needed packages

library(lubridate)
library(reshape)
library(scales)
library(sjPlot)
library(ggplot2)


##example of how to use the functions :

dictionary <- read_dictionary("Well_dictionary.csv")

plate_1 <- read_plates("Plate_1.csv", "AZ01", dictionary)

plate_graphs(plate_1, "AZ01")

