## load needed packages

library(lubridate)
library(reshape)
library(scales)
library(sjPlot)
library(ggplot2)
library(dplyr)


##example of how to use the functions :

dictionary <- read_dictionary("merged_dictionary.csv")

plate_1 <- read_plates("Plate_1.csv", "LEN1", dictionary, "A-D")

plate_graphs(plate_1, "LEN1")


produce_OD_graph("Plate_1.csv")



