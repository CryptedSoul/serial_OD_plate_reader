# to produce the graphs use Shaqed functions:

library(lubridate)
library(reshape)
library(scales)
library(sjPlot)
library(ggplot2)
library(dplyr)


source("check_RMSE.R")
source("Read_dictionary_function.R")
source("master_plate_reader.R")
source("plate_graphs.R")
source("master_plate_grapher.R")


dictionary <- read_dictionary("merged_dictionary_new.csv")

master_plate_grapher("Plate_5_AD.csv", "LEN5", dictionary, "A-D")

