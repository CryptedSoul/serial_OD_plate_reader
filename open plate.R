## load needed packages

library(lubridate)
library(reshape)
library(scales)
library(sjPlot)


## read the dictionary file and keep only the plate numbers, wells and gene names

dictionary_names <- read.csv(file = "Well_dictionary.csv", check.names = FALSE)
dictionary_names <- dictionary[, c("Plate_Number", "Well", "Gene_Name")]




##example of how to use the functions :


plate_1 <- read_plates("Plate_1.csv", "AZ01")

plate_graphs(plate_1, "AZ01")

