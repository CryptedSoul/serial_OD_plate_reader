master_plate_grapher <- function(plate_file, platename, dictionary, position) {
  
  ## create directory if needed
  if (!file.exists(paste(platename, position, sep = "_"))){
    dir.create(file.path(paste(platename, position, sep = "_")))
  } 
  
  OD_plate <- read_plates(plate_file, platename, dictionary, "OD", position)
  
  GFP_plate <- read_plates(plate_file, platename, dictionary, "GFP", position)
  
  DIV_plate <- read_plates(plate_file, platename, dictionary, "DIV", position)
  
  
  OD_RMSE <- check_RMSE(OD_plate,position)
  write.csv(OD_RMSE, paste(platename, "_", position, "/", "failedODtest.csv", sep = ""))
  
  DIV_diff_exp <- check_diff_exp(DIV_plate,position)
  write.csv(DIV_diff_exp, paste(platename, "_", position, "/", "DIV_diff_exp.csv", sep = ""))
  
  
  
  plate_graphs(OD_plate, platename, "OD", position, OD_RMSE)
  
  plate_graphs(GFP_plate, platename, "GFP", position, OD_RMSE)
  
  plate_graphs(DIV_plate, platename, "DIV", position, OD_RMSE)
  
  
  
  
}
