check_ratios <- function(plateDF, ratio = 0, averages = 0){
  
  averages <- matrix(NA, nrow = 4, ncol = 12, dimnames = list(c("A","B","C", "D"), c(1:12)))
  
  for (wellLetter in 1:4) {
    for (wellNum in 1:12) {
      
      wells <- c("A","B","C","D", "E", "F", "G", "H")
      
      id_1 = paste(wells[wellLetter], wellNum, sep = "")
      id_2 = paste(wells[wellLetter+4], wellNum, sep = "") 
      
      sbst <- subset(plateDF, id == id_1 | id == id_2)
      
      for (i in seq(1,200, by = 2)) {
        ratio[i] <- (sbst$OD[i] / sbst$OD[i+1])
      }
      ratio<-ratio[!is.na(ratio)]
      averages[wellLetter, wellNum] <- (mean(ratio))
    }
    ratio <-0
    
  }
  print(averages) 
  return(averages)
}

