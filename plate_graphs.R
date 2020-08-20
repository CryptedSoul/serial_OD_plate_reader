plate_graphs <- function(plateDF, platename, plate_type, position, OD_RMSE) {
  
  list_of_files <- vector()
  
  for (wellLetter in 1:4) {
    
    for (wellNum in 1:12) {
      
      #if ((OD_RMSE[wellLetter, wellNum] > 0.05)) { next }
      
      
      wells <- c("A","B","C","D", "E", "F", "G", "H")
      
      id_1 = paste(wells[wellLetter], wellNum, sep = "")
      id_2 = paste(wells[wellLetter+4], wellNum, sep = "") 
      
      list_of_files<- c(list_of_files, id_1)
      
      sbst <- subset(plateDF, id == id_1 | id == id_2)
      
      Gene <- sbst$Gene_name[1]
      
      p <- ggplot(sbst, aes(x =as.POSIXct(time, format = "%H:%M:%S") , y=OD, col = Condition)) + 
        geom_line(size = 0.5, aes(group = Condition)) +
        geom_point(size = 1)+
        ggtitle(Gene)+
        scale_x_datetime(expand= c(0.01,0), date_labels = "%H:%M", date_breaks = "1 hour")+
        xlab("time (hrs:min)") +
        theme(axis.text.x = element_text(angle = 45, vjust = 1,  hjust = 1)) +
        ylab(plate_type)
      
      
      if (plate_type == "OD") {p + scale_y_continuous(trans = 'log10')+ ylab("log10(OD)")}
      p
      
      if (position == "A-D")  {
        graphname <- paste(id_1, platename, plate_type, "tif", sep = ".") 
      }
      else {
        graphname <- paste(id_2, platename, plate_type, "tif", sep = ".")
      }
      
      filename <- paste(platename, "_", position, "/", graphname, sep = "")
      
      
      save_plot(
        filename = filename,
        fig = last_plot(),
        width = 12,
        height = 9,
        dpi = 300,
        theme = theme_get(),
        label.color = "black",
        label.size = 2.4,
        axis.textsize = 0.7,
        axis.titlesize = 0.75,
        legend.textsize = 0.6,
        legend.titlesize = 0.65,
        legend.itemsize = 0.5)
      
    }
  }
  if (plate_type == "OD") {print(list_of_files)}
}


