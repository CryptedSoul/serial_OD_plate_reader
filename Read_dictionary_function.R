## read the dictionary file and keep only the plate numbers, wells and gene names


read_dictionary <- function(filename) {
  dictionary_names <- read.csv(file = filename, check.names = FALSE)
  dictionary_names <- dictionary_names[, c("Plate", "Well", "Gene_name")]
}

