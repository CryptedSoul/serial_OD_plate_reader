## the function creates a folder with all dual wells graphs for a plate.


plate_graphs <- function(plateDF, platename) {
 ## create directory if needed
   if (!file.exists(platename)){
    dir.create(file.path(platename))
  } 
  
  for (wellLetter in 1:4) {
  for (wellNum in 1:12) {
    
    plot_list = list()
    
    wells <- c("A","B","C","D", "E", "F", "G", "H")
      
    id_1 = paste(wells[wellLetter], wellNum, sep = "")
    id_2 = paste(wells[wellLetter+4], wellNum, sep = "") 
    
    sbst <- subset(plateDF, id == id_1 | id == id_2)
    
    Gene <- sbst$Gene_name[1]
    
    p <- ggplot(sbst, aes(x =as.POSIXct(time, format = "%H:%M:%S") , y=OD, col = Condition))
    
    p + 
      geom_line(size = 0.5, aes(group = Condition)) +
      geom_point(size = 1)+
      ggtitle(Gene)+
      scale_x_datetime(expand= c(0.01,0), date_labels = "%H:%M", date_breaks = "1 hour")+
      xlab("time (hrs:min)") +
      theme(axis.text.x = element_text(angle = 45, vjust = 1,  hjust = 1)) +
      ylab("OD")
    
  
    graphname <- paste(platename,id_1, id_2, "tif", sep = ".")
    
    filename <- paste(platename, "/", graphname, sep = "")
    
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
  
}
