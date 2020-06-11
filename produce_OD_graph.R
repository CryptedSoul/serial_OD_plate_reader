produce_OD_graph <- function(platefile) {
  
  plateOD <- read.csv(file = platefile, skip = 1, nrows = 97, row.names = 1, check.names = FALSE)
  
  plateOD <- tidyplates(plateOD)
  
  df <- reshape(plateOD, varying= list(colnames(plateOD)), 
                direction="long", v.names = "OD", timevar = "time",
                idvar = "id", ids = rownames(plateOD),
                times = colnames(plateOD),)
  
  summa <- df %>% 
    group_by(id) %>% 
    summarize(mean = mean(OD),
              max = max(OD))
  
  
  for (i in 1:96) {
    if (summa$max[i] < 0.2) (print(summa$id[i]))
  }
  
  p <- ggplot(df, aes(x =as.POSIXct(time, format = "%H:%M:%S") , y=OD, col = id))
  
  p <- p + 
    #geom_line(size = 1.5, aes(group = id)) +
    geom_point(size = 1,aes(col = ))+
    scale_x_datetime(expand= c(0.01,0), date_labels = "%H:%M", date_breaks = "1 hour")+
    xlab("time (hrs:min)") +
    theme(axis.text.x = element_text(angle = 45, vjust = 1,  hjust = 1)) +
    ylab("OD")
  print(p)
  
}
