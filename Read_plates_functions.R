##function for reading a plates file. it reads the two plates, divide the GFP plate by the OD plate,
## and creates a dataframe containing data about each sample (plate number, time, OD, well and gene name)

read_plates <- function(platefile, platename, dictionary_names, position = "A-D") {
  
  plateOD <- read.csv(file = platefile, skip = 1, nrows = 97, row.names = 1, check.names = FALSE)
  
  plateGFP <- read.csv(file = platefile, skip = 102, nrows = 97, row.names = 1, check.names = FALSE)
  
  plateOD <- tidyplates(plateOD)
  plateGFP <- tidyplates(plateGFP)
  
  platediv <- plateGFP / plateOD
  
  df <- reshape(platediv, varying= list(colnames(platediv)), 
                direction="long", v.names = "OD", timevar = "time",
                idvar = "id", ids = rownames(platediv),
                times = colnames(platediv),)
  
  dictionary_plate1 <- subset(dictionary_names, Plate == platename)
  
  if (position == "A-D") (df$Gene_name <- dictionary_plate1$Gene_name[1:48])
  else if (position == "E-H") (df$Gene_name <- dictionary_plate1$Gene_name[49:96])
  else (print("error in positions"))
  
  
  for (i in 1:nrow(df)) {
    if (grepl("A|B|C|D", as.character(df$id[i]))) (df$Condition[i] <- "RPMI")
    else (df$Condition[i] <- "E.coli")
    
  }
    

  df$Plate <- dictionary_plate1$Plate
  
  return(df)
}


##tidyplates function changes the time variable to hms format, removes the temparture row.

tidyplates <- function(plate) {
  plate <- plate[-c(1), ]
  time <-  hms::as_hms(as.integer(colnames(plate)))
  names(plate) <- time
  return(plate)
}
