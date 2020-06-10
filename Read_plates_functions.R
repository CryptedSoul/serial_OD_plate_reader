##function for reading a plates file. it reads the two plates, divide the GFP plate by the OD plate,
## and creates a dataframe containing data about each sample (plate number, time, OD, well and gene name)

read_plates <- function(platefile, platename, dictionary_names) {
  
  plateOD <- read.csv(file = platefile, skip = 1, nrows = 97, row.names = 1, check.names = FALSE)
  
  plateGFP <- read.csv(file = platefile, skip = 101, nrows = 97, row.names = 1, check.names = FALSE)
  
  plateOD <- tidyplates(plateOD)
  plateGFP <- tidyplates(plateGFP)
  
  platediv <- plateGFP / plateOD
  
  df <- reshape(platediv, varying= list(colnames(platediv)), 
                direction="long", v.names = "OD", timevar = "time",
                idvar = "id", ids = rownames(platediv),
                times = colnames(platediv),)
  
  dictionary_plate1 <- subset(dictionary_names, Plate_Number == platename)
  
  df$Gene_name <- dictionary_plate1$Gene_Name[match(df$id, dictionary_plate1$Well)]
  
  df$Plate_number <- dictionary_plate1$Plate_Number
  
  return(df)
}


##tidyplates function changes the time variable to hms format, removes the temparture row.

tidyplates <- function(plate) {
  plate <- plate[-c(1), ]
  time <-  hms::as_hms(as.integer(colnames(plate)))
  names(plate) <- time
  return(plate)
}
