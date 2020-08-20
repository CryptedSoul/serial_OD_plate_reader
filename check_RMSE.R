check_RMSE <- function(plateDF, line_id1 = 0, line_id2 = 0, averages = 0){
  
  averages <- matrix(NA, nrow = 4, ncol = 12, dimnames = list(c("A","B","C", "D"), c(1:12)))
  failed<-vector()
  
  for (wellLetter in 1:4) {
    for (wellNum in 1:12) {
      
      wells <- c("A","B","C","D", "E", "F", "G", "H")
      
      id_1 = paste(wells[wellLetter], wellNum, sep = "")
      id_2 = paste(wells[wellLetter+4], wellNum, sep = "") 
      
      sbst <- subset(plateDF, id == id_1 | id == id_2)
      
      line_id1 <- 0
      line_id2 <- 0
      
      for (i in seq(1,122, by = 2)) {
        line_id1[i] <- (sbst$OD[i])
        line_id2[i] <- (sbst$OD[i+1])
        
      }
      line_id1<-line_id1[!is.na(line_id1)]
      line_id2<-line_id2[!is.na(line_id2)]
      
      averages[wellLetter, wellNum] <- sqrt(mean((line_id2 - line_id1)^2))
      
      if ((averages[wellLetter, wellNum] > 0.05)) {failed <- c(failed, (paste(id_1, "failed the OD test"))) }
    }
  }
  print(averages)
  return(failed)
}

