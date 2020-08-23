check_diff_exp <- function(plateDF, position, line_id1 = 0, line_id2 = 0, averages = 0){
  
  passed <- vector()

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
      
      j<-1
      if (position == "E-H") {j<-2}
      
      times<-NULL
      for (i in seq(j,122, by = 2)) {
        times[i] <- (row.names(sbst[i,]))
      }
      times<-times[!is.na(times)]
      
      div_res<-0 
      for (i in length(line_id1)) {
       if (line_id1[i] >= line_id2[i]) {div_res<-(line_id1[i]/line_id2[i])}
       else {div_res<-(line_id2[i]/line_id1[i])}
       
       if (div_res >= 1.5) {
         passed <- c(passed, times[i])
       break}
     } 
      
    }
  }
  

  print(passed) 
  return(passed)
}


