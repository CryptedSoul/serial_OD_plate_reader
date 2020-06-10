# serial_OD_plate_reader
Reading 96-well plate reader output (target gene and baseline OD) and graphs them

# read_dictionary(filename) 
Reading the dictionary file, contains data on plate number, wells and gene names.

# read_read_plates(platefile, platename, dictionary_names)
Reading the plates file (OD then GFP), divides them, and assigning genenames to wells.
also contains tidyplates function that changes the time variable to hms format, removes the temparture row.

# plate_graphs(plateDF, platename)
Creates a directory and prints tif format graphs of each dual wells timeseries.

